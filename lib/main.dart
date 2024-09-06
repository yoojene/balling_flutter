import 'package:balling/pages/favourites.dart';
import 'package:balling/pages/home.dart';
import 'package:balling/pages/schedule.dart';
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(29, 66, 138, 1)),
          // seedColor: const Color.fromRGBO(200, 16, 46, 0.5)),
          useMaterial3: true,
        ),
        home: const BallingApp(),
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
}

class BallingApp extends StatefulWidget {
  const BallingApp({super.key});

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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(appState.title),
      ),
      body: [
        HomePage(),
        FavouritesPage(),
        SchedulePage()
      ][appState.currentPageIndex],

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
