import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;

  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>(
      (event, emit) => emit(state.copyWith(followingUser: true)),
    );

    on<OnStopFollowiingUser>(
      (event, emit) => emit(state.copyWith(followingUser: false)),
    );

    on<OnMyNewUserLocationEvent>((event, emit) {
      emit(
        state.copyWith(
          lastknownLocation: event.newLocation,
          myLocationHistory: [...state.myLocationHistory, event.newLocation],
        ),
      );
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    add(
      OnMyNewUserLocationEvent(LatLng(position.latitude, position.longitude)),
    );
  }

  void startFollowingUser() {
    add(OnStartFollowingUser());
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;

      add(
        OnMyNewUserLocationEvent(LatLng(position.latitude, position.longitude)),
      );

      // print('startFollowingUser');

      // print('Posicion: $position');
    });
  }

  void stopFollowingUser() {
    add(OnStopFollowiingUser());
    // print('stopFollowingUser');
    positionStream?.cancel();
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
