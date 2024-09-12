import 'package:balling/models/players.dart';
import 'package:balling/models/teams.dart';
import 'package:balling/pages/favourites.dart';
import 'package:balling/pages/home.dart';
import 'package:balling/pages/player.dart';
import 'package:balling/pages/schedule.dart';
import 'package:balling/pages/teams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BallingAppState(),
      child: MaterialApp(
        title: 'Balling with Flutter',
        initialRoute: '/',
        routes: {
          BallingApp.routeName: (context) => const BallingApp(),
          PlayerDetail.routeName: (context) => PlayerDetail(),
          TeamDetail.routeName: (context) => TeamDetail(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(29, 66, 138, 1)),
          // seedColor: const Color.fromRGBO(200, 16, 46, 0.5)),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class BallingAppState extends ChangeNotifier {
  int currentPageIndex = 0;

  var title = 'Home'; // Default title

  void changePage(int index) {
    currentPageIndex = index;
    switch (index) {
      case 0:
        title = 'Home';
      case 1:
        title = 'Favourites';
      case 2:
        title = 'Schedule';
    }
    notifyListeners();
  }

  late List<Players> favouritePlayers = [];
  late List<String> favouritePlayerIds = [];

  void toggleFavoritePlayer(Players player) {
    if (favouritePlayerIds.contains(player.idPlayer)) {
      favouritePlayerIds.remove(player.idPlayer);
      favouritePlayers.removeWhere((p) => p.idPlayer == player.idPlayer);
    } else {
      favouritePlayerIds.add(player.idPlayer);
      favouritePlayers.add(player);
    }
    notifyListeners();
  }

  late List<Teams> favouriteTeams = [];
  late List<String> favouriteTeamIds = [];

  void toggleFavoriteTeam(Teams team) {
    if (favouriteTeamIds.contains(team.idTeam)) {
      favouriteTeamIds.remove(team.idTeam);
      favouriteTeams.removeWhere((t) => t.idTeam == team.idTeam);
    } else {
      favouriteTeamIds.add(team.idTeam);
      favouriteTeams.add(team);
    }
    notifyListeners();
  }
}

class BallingApp extends StatefulWidget {
  const BallingApp({super.key});

  static const routeName = '/';

  @override
  State<BallingApp> createState() => _BallingAppState();
}

class _BallingAppState extends State<BallingApp> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<BallingAppState>();

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(Icons.search),
              icon: Icon(Icons.search),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.favorite), label: 'Favourites'),
          NavigationDestination(
              icon: Icon(Icons.calendar_month), label: 'Schedules')
        ],
        selectedIndex: appState.currentPageIndex,
        onDestinationSelected: (index) => appState.changePage(index),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        title: Text(appState.title),
      ),
      body: [
        HomePage(),
        FavouritesPage(),
        SchedulePage()
      ][appState.currentPageIndex],
    );
  }
}
