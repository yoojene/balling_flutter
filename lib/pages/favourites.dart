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
    var favouritePlayers = appState.favouritePlayers;
    var favouritePlayerIds = appState.favouritePlayerIds;

    var favouriteTeamIds = appState.favouriteTeamIds;
    var favouriteTeams = appState.favouriteTeams;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: favouritePlayerIds.isNotEmpty
              ? Text(
                  'Favourite Players',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              : Text('No Favourite Players',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
            // For horizontal scrolling not using a complete list view
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var player in favouritePlayers) ...[
                  //can spread into the children array if there are more than one child https://flutterqueen5.medium.com/flutter-tip-use-spread-operator-959c5581dfca
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(player.strCutout),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          player.strPlayer,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  )
                ]
              ],
            )),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: favouriteTeamIds.isNotEmpty
              ? Text(
                  'Favourite Teams',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              : Text('No Favourite Teams',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
            // For horizontal scrolling not using a complete list view
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var team in favouriteTeams) ...[
                  //can spread into the children array if there are more than one child https://flutterqueen5.medium.com/flutter-tip-use-spread-operator-959c5581dfca
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(team.strBadge),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          team.strTeam,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  )
                ]
              ],
            ))
      ],
    );
  }
}
