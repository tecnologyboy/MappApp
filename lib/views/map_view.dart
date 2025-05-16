import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapsapp/blocs/bloc.dart';
import 'package:mapsapp/themes/themes.dart';

class MapView extends StatelessWidget {
  final LatLng lastknownLocation;
  final Set<Polyline> polylines;

  const MapView({
    super.key, 
    required this.lastknownLocation, 
    required this.polylines
    });

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    CameraPosition initialCameraPosition = CameraPosition(
      target: lastknownLocation,
      zoom: 15,
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,

      child: Listener(
        // onPointerMove: (event) => mapBloc.add(OnMapStopFollowingUser()),
        onPointerMove: (event) {
          mapBloc.add(OnMapStopFollowingUser());
        },
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          buildingsEnabled: true,
          polylines: polylines,

          style: uberMapTheme.toString(),
          onMapCreated:
              (controller) => mapBloc.add(OnMapInitializeEvent(controller)),

          //TODO markers, polylines y cuando se mueve el mapa
        ),
      ),
    );
  }
}
