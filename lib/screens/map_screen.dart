import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapsapp/blocs/bloc.dart';

import 'package:mapsapp/views/views.dart';
import 'package:mapsapp/widgets/btn_follow_user.dart';
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
        builder: (context, state) {
          if (state.lastknownLocation == null) {
            return Center(child: Text('Aun nohay ubicación, espere...'));
          }

          return SingleChildScrollView(
            child: Stack(
              children: [MapView(lastknownLocation: state.lastknownLocation!)],

              //TODO Botones y otras cosas
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [BtnFollowUser(), BtnCurrentLocation()],
      ),
    );
  }
}
