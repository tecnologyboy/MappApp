part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowinUser;

  const MapState({
    this.isMapInitialized = false, 
    this.isFollowinUser = true
    });

  MapState copyWidth({
    bool? isMapInitialized, 
    bool? isFollowinUser}) 
    =>MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowinUser: isFollowinUser ?? this.isFollowinUser,
      );

  @override
  List<Object> get props => [isMapInitialized, isFollowinUser];
}
