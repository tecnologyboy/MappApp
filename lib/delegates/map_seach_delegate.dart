import 'package:flutter/material.dart';
import 'package:mapsapp/models/search_result.dart';

class MapSearchDelegate extends SearchDelegate<SearchResult> {
  MapSearchDelegate() : super(searchFieldLabel: 'Buscar...');

  @override
  List<Widget>? buildActions(Object context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        final searchResult = SearchResult(cancel: true);
        close(context, searchResult);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Estos Son los resultados');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined),
          title: const Text(
            'Colocar una ubicacón manualmente',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            //TODO regresar algo - Meter Cabra

              final searchResult = SearchResult(cancel: false, manual: true);
              close(context, searchResult);
          },
        ),
      ],
    );
  }
}
