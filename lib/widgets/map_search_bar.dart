import 'package:flutter/material.dart';
import 'package:mapsapp/delegates/delegates.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context,
              delegate: MapSearchDelegate(),
            );

            if (result == null) ;

            print(result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              'Donde quieres ir?',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
