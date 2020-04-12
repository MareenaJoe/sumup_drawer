import 'package:flutter/material.dart';
import 'package:flutterdrawer/screens/screens/hf_sale_items_screen.dart';
import 'details_screen.dart';
import 'package:flutterdrawer/screens/screens/details_screen.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://i.vimeocdn.com/portrait/6200626_300x300',
                          ),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Text(
                    'Mareena Thomas',
                    style: TextStyle(fontSize: 22,color: Colors.white,
                    ),
                  ),
                  Text(
                    'M.Thomas8@nuigalway.ie',
                    style: TextStyle(color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Events',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap:(){
              Navigator.of(context).pushNamed(DetailsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text(
              'Add Products',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
              onTap:(){
                Navigator.of(context).pushNamed(SaleItems.routeSaleName);
              }
          ),
        ],
      ),
    );
  }
}
