import 'package:flutter/material.dart';
import 'package:network_http/Pages/EditProdects.dart';
import 'package:network_http/Pages/ViewOrderAdmain.dart';

import 'AddProdectPage.dart';

class AdminPage extends StatelessWidget {
  static final route = 'AdminPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admain"),
      ),
      body: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
              child: Text('Add Prodect'),
              onPressed: () {
                Navigator.of(context).pushNamed(AddProdect.id);
              }),
          RaisedButton(
              child: Text('Edit Prodect'),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProdect.id);
              }),
          RaisedButton(
              child: Text('View Order'),
              onPressed: () {
                Navigator.of(context).pushNamed(ViewOrder.id);
              })
        ],
      )),
    );
  }
}
