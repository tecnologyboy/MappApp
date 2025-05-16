import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsapp/blocs/bloc.dart';

import 'package:mapsapp/views/views.dart';
import 'package:mapsapp/widgets/btn_follow_user.dart';
import 'package:mapsapp/widgets/btn_show_user_route.dart';
import 'package:mapsapp/widgets/btncurrentlocation.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationProvider;

  @override
  void initState() {
    super.initState();

    locationProvider = BlocProvider.of<LocationBloc>(context);

    // locationbloc.getCurrentPosition();

    locationProvider.startFollowingUser();
  }

  @override
  void dispose() {
    locationProvider.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastknownLocation == null) {
            return Center(child: Text('Aun no hay ubicación, espere...'));
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polyLines = Map.from(mapState.polylines);

              if (!mapState.showMyRoute) {
                polyLines.removeWhere((key, value) => key == 'myRoute');
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      lastknownLocation: locationState.lastknownLocation!,
                      polylines: polyLines.values.toSet(),
                    ),
                  ],

                  //TODO Botones y otras cosas
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnShowUserRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}
