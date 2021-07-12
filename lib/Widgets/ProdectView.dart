import 'package:flutter/material.dart';
import 'package:network_http/Function/prodectCategory.dart';
import 'package:network_http/Models/Prodect.dart';
import 'package:network_http/Pages/ProdectInf.dart';

Widget prodectViewByCategory(String category, List<Prodect> prodectS) {
  List<Prodect> prodectSave = [];
  print('comming ${prodectS.length}');

  prodectSave = prodectCategoryFunction(category, prodectS);
  if (prodectSave.length > 0) {
    print('the Output${prodectSave[0].name}');
  }
  // print('the Output${prodectSave.length}');
  //print(prodectSave);
  if (prodectSave.length >= 0) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: .8),
      itemCount: prodectSave.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProdectInfo.id, arguments: prodectSave[index]);
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(prodectSave[index].location),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Opacity(
                  opacity: .4,
                  child: Container(
                    color: Colors.black,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      prodectSave[index].name,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  } else {
    return Center(child: Text('Loading.....'));
  }
}
