import 'package:balling/main.dart';
import 'package:balling/models/players.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerDetailParams {
  final String idPlayer; // final Players ;
  final String strPlayer;
  final String strNumber;
  final String strCutout;
  final String strPosition;
  final String strDescriptionEN;

  PlayerDetailParams(this.idPlayer, this.strPlayer, this.strNumber,
      this.strCutout, this.strPosition, this.strDescriptionEN);
}

class PlayerDetail extends StatelessWidget {
  static const routeName = '/player';
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<BallingAppState>();

    final args =
        ModalRoute.of(context)!.settings.arguments as PlayerDetailParams;

    var player = Players(
      args.idPlayer,
      args.strPlayer,
      args.strNumber,
      args.strCutout,
      args.strPosition,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        title: Text(args.strPlayer),
      ),
      body: ListView(
        children: [
          Card(
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        selectedIcon: Icon(Icons.favorite),
                        isSelected: appState.favouritePlayerIds
                            .contains(player.idPlayer),
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.primaryFixedDim)),
                        onPressed: () => appState.toggleFavoritePlayer(player),
                        icon: Icon(Icons.favorite_outline)),
                    Image.network(args.strCutout),
                    SizedBox(height: 10),
                    Text('Number',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),
                    Text(args.strNumber,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(height: 10),
                    Text('Position',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),

                    Text(args.strPosition,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(height: 10),

                    Text('Bio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),

                    Text(args.strDescriptionEN,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        )),
                    // Text('${args.strDescriptionEN}'),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class Player {}
