import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapsapp/blocs/bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return state.isGpsEnabled
                ? const _AccessButton()
                : const _EnableGpsMessage();
          },
        ),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Se requiere acceso al GPS'),
        MaterialButton(
          shape: StadiumBorder(),
          elevation: 0,
          //splashColor: Colors.transparent, //Al instructor no le gusta el efecto del spalsh, a mi si
          onPressed: () {
            final blocprovider = BlocProvider.of<GpsBloc>(context);
            blocprovider.AskGpsAccess();
          },
          color: Colors.black,
          child: Text(
            'Solicitar Acceso',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe habilitar el gps',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}
