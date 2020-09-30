import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(),
          ListTile(
            leading: Icon(Icons.ac_unit),
          ),
        ],
      ),
    );
  }
}
