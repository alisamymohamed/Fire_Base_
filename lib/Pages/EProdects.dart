import 'package:flutter/material.dart';
import 'package:network_http/Widgets/CustomTextField.dart';
import 'package:network_http/Models/Prodect.dart';
import 'package:network_http/Servises/StoreProdect.dart';

class EProdect extends StatelessWidget {
  static String id = 'EProdect';
  String nameP, priceP, descrptionP, categoryP, locationP;
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  var saveProdect = StoreP();

  @override
  Widget build(BuildContext context) {
    Prodect _prodect = ModalRoute.of(context).settings.arguments;
    double hi = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Form(
        key: keyForm,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: hi * .3,
                ),
                CustomTextField(
                    hintText: 'Prodect Name',
                    iconText: null,
                    onClick: (value) {
                      nameP = value;
                    }),
                SizedBox(
                  height: hi * .01,
                ),
                CustomTextField(
                    hintText: 'Prodect price',
                    iconText: null,
                    onClick: (value) {
                      priceP = value;
                    }),
                SizedBox(
                  height: hi * .01,
                ),
                CustomTextField(
                    hintText: 'Prodect descrption',
                    iconText: null,
                    onClick: (value) {
                      descrptionP = value;
                    }),
                SizedBox(
                  height: hi * .01,
                ),
                CustomTextField(
                    hintText: 'Prodect category',
                    iconText: null,
                    onClick: (value) {
                      categoryP = value;
                    }),
                SizedBox(
                  height: hi * .01,
                ),
                CustomTextField(
                    hintText: 'Prodect location',
                    iconText: null,
                    onClick: (value) {
                      locationP = value;
                    }),
                SizedBox(
                  height: hi * .02,
                ),
                RaisedButton(
                    child: Text('Done'),
                    onPressed: () {
                      if (keyForm.currentState.validate()) {
                        keyForm.currentState.save();
                        saveProdect.editProdect({
                          'ProdectName': nameP,
                          'Prodectprice': priceP,
                          'Prodectdescrption': descrptionP,
                          'Prodectcategory': categoryP,
                          'Prodectlocation': locationP
                        }, _prodect.pId);
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
