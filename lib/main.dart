import 'package:flutter/material.dart';
import 'package:flutterdrawer/services/events_services.dart';
import 'package:get_it/get_it.dart';
import 'screens/screens/home_screen.dart';
import 'screens/screens/details_screen.dart';
import 'screens/screens/hf_sale_items_screen.dart';


void setupLocator() {
  GetIt.I.registerLazySingleton(() => EventsServices());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: {
        HomeScreen.homerouteName:(_) => HomeScreen(),
        DetailsScreen.routeName:(_) => DetailsScreen(),
        SaleItems.routeSaleName:(_) => SaleItems()
      },
      home: HomeScreen(),
    );
  }
}

