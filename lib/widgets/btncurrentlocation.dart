import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapsapp/blocs/bloc.dart';
import 'package:mapsapp/ui/uis.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final localtionBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            /*
              De esta manera, obtengo la ultima ubicaciond del usuario y 
              y posiciono la camara en el mapa en la ultima ubicacion conocida del suaurio
            */
            final userLocation = localtionBloc.state.lastknownLocation;
            if (userLocation == null) {
              final snackBar = Customsnackbar(
                message: 'No hay ubicación especificada aun',
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              return;
            }

            mapBloc.moveCamera(userLocation);
          },
          icon: Icon(Icons.my_location_outlined, color: Colors.black),
        ),
      ),
    );
  }
}
