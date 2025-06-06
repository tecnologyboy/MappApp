import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 70, left: 20, child: _BtnBack()),

          Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                from: 100,
                child: Icon(Icons.location_on_rounded, size: 60),
              ),
            ),
          ),
          //Boton de confirmar

          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width -120,
                color: Colors.black,
                elevation: 0,
                height: 50,
                shape: StadiumBorder(),
                
                onPressed: () {
              
                        },
                        child: Text(
              'Confirmar destino', 
              style: TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.w300
                ),
              ),
                        ),
            ))
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            //TODO Cancelar el marcador manual
      
          },
        ),
      ),
    );
  }
}
