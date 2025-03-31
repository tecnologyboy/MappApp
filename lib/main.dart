import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapsapp/blocs/gps/gps_bloc.dart';
import 'package:mapsapp/screens/screens.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => GpsBloc())],
      child: MapApp(),
    ),
  );
}

class MapApp extends StatelessWidget {
  const MapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapp App',
      home: LoadingScreen(),
    );
  }
}
