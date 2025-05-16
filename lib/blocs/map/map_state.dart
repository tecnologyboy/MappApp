part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowinUser;
  final bool showMyRoute;
  final Map<String, Polyline> polylines;

  const MapState({
    Map<String, Polyline>? polylines,
    this.isMapInitialized = false,
    this.isFollowinUser = true,
    this.showMyRoute = true,
  }) : polylines = polylines ?? const {};

  MapState copyWidth({
    bool? isMapInitialized,
    bool? isFollowinUser,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowinUser: isFollowinUser ?? this.isFollowinUser,
    showMyRoute: showMyRoute ?? this.showMyRoute,
    polylines: polylines ?? this.polylines,
  );

  @override
  List<Object> get props => [isMapInitialized, isFollowinUser, showMyRoute, polylines];
}
