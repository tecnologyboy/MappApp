import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsStreamSuscription;

  GpsBloc()
    : super(
        const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false),
      ) {
    on<GpsAndPermissionEvent>(
      (event, emit) => emit(
        state.copyWith(
          isGpsEnabled: event.isGpsEnabled,
          isGpsPermissionGranted: event.isGpsPermissionGranted,
        ),
      ),
    );

    _init();
  }
  Future<void> _init() async {
    // final isEnabled = await _checkGpsStatus();
    // final isGranted = await _isGpsPermissionGranted();

    // add(
    //   GpsAndPermissionEvent(
    //     isGpsEnabled: isEnabled,
    //     isGpsPermissionGranted: isGranted,
    //   ),
    // );

    //Esta forma de llamar los Futures, nos ahorra esperar de manera individual por cada Future

    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isGpsPermissionGranted(),
    ]);

    add(
      GpsAndPermissionEvent(
        isGpsEnabled: gpsInitStatus[0],
        isGpsPermissionGranted: gpsInitStatus[1],
      ),
    );
  }

  Future<bool> _isGpsPermissionGranted() async {
    final isPermissionGranted = await Permission.location.isGranted;

    return isPermissionGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();

    gpsStreamSuscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;

      add(
        GpsAndPermissionEvent(
          isGpsEnabled: isEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted,
        ),
      );
    });

    return isEnabled;
  }

  Future<void> AskGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        GpsAndPermissionEvent(
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: true,
        );
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        GpsAndPermissionEvent(
          isGpsEnabled: state.isGpsEnabled,
          isGpsPermissionGranted: false,
        );
        openAppSettings();
    }
  }

  @override
  Future<void> close() {
    gpsStreamSuscription?.cancel();
    return super.close();
  }
}
