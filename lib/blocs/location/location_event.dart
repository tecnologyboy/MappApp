part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnMyNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;

  const OnMyNewUserLocationEvent(this.newLocation);
}

class OnStartFollowingUser extends LocationEvent {}

class OnStopFollowiingUser extends LocationEvent {}
