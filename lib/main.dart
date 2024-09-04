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
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
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

  var title = 'test';

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Get Ballin'!";

  @override
  State<BallingApp> createState() => _BallingAppState();
}

class _BallingAppState extends State<BallingApp> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<BallingAppState>();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(Icons.search),
              icon: Icon(Icons.search),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.favorite), label: 'Favourites'),
          NavigationDestination(
              icon: Icon(Icons.calendar_month), label: 'Schedule')
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
