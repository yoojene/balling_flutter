import 'package:balling/main.dart';
import 'package:balling/pages/home.dart';
import 'package:balling/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatelessWidget {
  // var favourites = [];
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<BallingAppState>();

    var favourites = appState.favourites;
    var players = [];
    // print('Favourites: $favourites');
    readJson(type: SegmentType.players.name).then((value) => {players = value});

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            favourites.isNotEmpty ? favourites.toString() : 'No favourites yet',
          ),
          // Text(
          //   players.isNotEmpty
          //       ? players[1]['strPlayer'].toString()
          //       : 'No Players yet',
          // ),
        ],
      ),
    );
  }
}
