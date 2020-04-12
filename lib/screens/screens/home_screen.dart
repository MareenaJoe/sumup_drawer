import 'package:flutter/material.dart';
import 'package:flutterdrawer/screens/screens/details_screen.dart';
import 'package:flutterdrawer/screens/screens/main_drawer.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  static const homerouteName = '/home_screen';

  static const routeName = '/details_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: MainDrawer(),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('We are in the Home page',
            style: TextStyle(
              fontSize: 22,
            ),
            ),
            RaisedButton(
              child: Text('Go to details...'),
              onPressed: (){
                Navigator.of(context).pushNamed(DetailsScreen.routeName);
            },
            )
          ],
        )
      )
    );
  }
}

