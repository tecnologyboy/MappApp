part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  bool get isGpsAllGranted => isGpsEnabled && isGpsPermissionGranted;

  const GpsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
  });

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];

  GpsState copyWith({bool? isGpsEnabled, bool? isGpsPermissionGranted}) =>
      GpsState(
        isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
        isGpsPermissionGranted:
            isGpsPermissionGranted ?? this.isGpsPermissionGranted,
      );

  @override
  String toString() {
    return '{isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted}';
  }
}
