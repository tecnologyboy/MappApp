part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializeEvent extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitializeEvent(this.controller);
}

class OnMapStartFollowingUser extends MapEvent {}

class OnMapStopFollowingUser extends MapEvent {}

class UpdateUserPolylinesEvent extends MapEvent {
  final List<LatLng> userLocations;

  const UpdateUserPolylinesEvent({required this.userLocations});
}

class OnToggleUserRoute extends MapEvent {}
