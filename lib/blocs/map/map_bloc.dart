import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapsapp/blocs/bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  LocationBloc locationBloc;

  GoogleMapController? _mapController;

  StreamSubscription<LocationState>? userLocationSuscriptions;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializeEvent>(_onInitMap);

    //Entiendo que esto fue lo que se solicito a nivel de Bloc para la tarea
    on<OnMapStartFollowingUser>(_onStartFollowingUser);

    on<OnMapStopFollowingUser>(
      (event, emit) => emit(state.copyWidth(isFollowinUser: false)),
    );

    on<UpdateUserPolylinesEvent>(_onPolylinePoint);

    on<OnToggleUserRoute>(
      (event, emit) => emit(state.copyWidth(showMyRoute: !state.showMyRoute)),
    );

    locationBloc.stream.listen((locationState) {
      if (locationState.lastknownLocation != null) {
        add(
          UpdateUserPolylinesEvent(
            userLocations: locationState.myLocationHistory,
          ),
        );
      }

      if (!state.isFollowinUser) return;
      if (locationState.lastknownLocation == null) return;

      moveCamera(locationState.lastknownLocation!);
    });
  }

  void _onStartFollowingUser(
    OnMapStartFollowingUser event,
    Emitter<MapState> emit,
  ) {
    emit(state.copyWidth(isFollowinUser: true));

    if (locationBloc.state.lastknownLocation == null) return;

    moveCamera(locationBloc.state.lastknownLocation!);
  }

  void _onInitMap(OnMapInitializeEvent event, Emitter<MapState> map) {
    _mapController = event.controller;

    //Esto esta deprecado, por eso lo puse en el MapView
    // _mapController!.setMapStyle(jsonEncode(uberMapTheme));

    emit(state.copyWidth(isMapInitialized: true));
  }

  void _onPolylinePoint(UpdateUserPolylinesEvent event, Emitter<MapState> map) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations,
    );

    final currentPolyline = Map<String, Polyline>.from(state.polylines);

    currentPolyline['myRoute'] = myRoute;

    emit(state.copyWidth(polylines: currentPolyline));
  }

  void moveCamera(LatLng newLocation) {
    final camaraUpdate = CameraUpdate.newLatLng(newLocation);

    _mapController?.animateCamera(camaraUpdate);
  }

  @override
  Future<void> close() {
    userLocationSuscriptions?.cancel();
    return super.close();
  }
}
