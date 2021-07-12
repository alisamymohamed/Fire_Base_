import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:network_http/Pages/EProdects.dart';
import 'package:network_http/Servises/StoreProdect.dart';
import 'package:network_http/Models/Prodect.dart';

class EditProdect extends StatefulWidget {
  static String id = 'editProdect';
  @override
  _EditProdectState createState() => _EditProdectState();
}

class _EditProdectState extends State<EditProdect> {
  var leStore = StoreP();
  // List<Prodect> prodects = [];
  bool load = false;
  @override
  Widget build(BuildContext context) {
    // var model = Provider.of<ModalHub>(context);
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: leStore.loadingProduct(),
      builder: (context, snapshot) {
        List<Prodect> prodects = [];
        if (snapshot.hasData) {
          for (var doc in snapshot.data.docs) {
            var data = doc.data();

            prodects.add(
              Prodect(
                pId: doc.id,
                price: data['Prodectprice'],
                name: data['ProdectName'],
                descrption: data['Prodectdescrption'],
                category: data['Prodectcategory'],
                location: data['Prodectlocation'],
              ),
            );
          }
        }
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: .8),
            itemCount: prodects.length,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                  child: GestureDetector(
                    onTapUp: (details) async {
                      double dX = details.globalPosition.dx;
                      double dY = details.globalPosition.dy;
                      double dX2 = MediaQuery.of(context).size.width - dX;
                      double dY2 = MediaQuery.of(context).size.width - dY;
                      await showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dX, dY, dX2, dY2),
                          items: [
                            PopupMenuItem(
                              child: GestureDetector(
                                child: Text('Edits'),
                                onTap: () {
                                  Navigator.of(context).pushNamed(EProdect.id,
                                      arguments: prodects[index]);
                                },
                              ),
                            ),
                            PopupMenuItem(
                              child: GestureDetector(
                                child: Text('Delet'),
                                onTap: () {
                                  leStore.deletProdect(prodects[index].pId);
                                },
                              ),
                            )
                          ]);
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(prodects[index].location),
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
                                prodects[index].name,
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
                ));
      },
    )

        //       return ListView.builder(
        //         itemCount: prodects.length,
        //         itemBuilder: (context, index) {
        //           return Text(prodects[index].name);
        //         },
        //       );
        //     } else {
        //       return Center(
        //         child: Text('Loading . . . . '),
        //       );
        //     }
        //   },
        // )
        //  FutureBuilder<List<Prodect>>(
        //     future: leStore.loadProdects(),
        //     builder: (context, snapahot) {
        //       if (snapahot.hasData) {
        //         // setState(() {
        //         //   load = false;
        //         // });
        //         return ListView.builder(
        //           itemCount: snapahot.data.length,
        //           itemBuilder: (context, index) =>
        //               Center(child: Text(snapahot.data[index].name)),
        //         );
        //       } else {
        //         // setState(() {
        //         //   load = true;
        //         // });
        //         return Center(
        //           child: Text('Loading . . . . '),
        //         );
        //       }
        //     }),
        );
  }

  // void initState() {
  //   getProducts();
  // }

  // getProducts() async {
  //   prodects = await leStore.loadProdects();
  // }
}
