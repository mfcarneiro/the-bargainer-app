import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/scoped_main.dart';

class LogoutListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onLongPress: () {
              model.logout();
            });
      }),
    );
  }
}
