import 'package:flutter/material.dart';
import 'package:network_http/Models/Prodect.dart';
import 'package:network_http/Pages/CartScreen.dart';
import 'package:network_http/Provider/Cartitem.dart';
import 'package:provider/provider.dart';

class ProdectInfo extends StatefulWidget {
  static final String id = 'ProdectInfo';
  @override
  _ProdectInfoState createState() => _ProdectInfoState();
}

class _ProdectInfoState extends State<ProdectInfo> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int pNumber = 1;
  @override
  Widget build(BuildContext context) {
    Prodect prodect = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: scaffoldKey,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage(prodect.location),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Container(
            //color: Colors.white,
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 50,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 50,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Cart.id);
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Opacity(
            opacity: .5,
            child: Container(
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prodect.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Text(
                      '\$ ${prodect.price}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.white30,
                            child: IconButton(
                              icon: Icon(Icons.add,
                                  size: 25, color: Colors.yellow),
                              onPressed: () {
                                setState(() {
                                  pNumber++;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .03,
                        ),
                        Text(
                          pNumber.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .03,
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.white30,
                            child: IconButton(
                              icon: Icon(Icons.remove,
                                  size: 25, color: Colors.yellow),
                              onPressed: () {
                                setState(() {
                                  if (pNumber > 1) {
                                    pNumber--;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: ButtonTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            minWidth: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .1,
            child: RaisedButton(
              color: Colors.yellow,
              child: Text(
                'Add To Card'.toUpperCase(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                addToCard(prodect);
              },
            ),
          ),
        ),
      ]),
    );
  }

  addToCard(Prodect prodect) {
    CartItem cart = Provider.of<CartItem>(context, listen: false);
    List<Prodect> prodectInCard = cart.prodectsCard;
    bool exist = false;
    prodect.qunantaty = pNumber;
    for (var p in prodectInCard) {
      if (prodect.name == p.name) {
        exist = true;
      }
    }
    if (exist) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'The Item In card'.toUpperCase(),
          ),
        ),
      );
    } else {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'The Item Add To Card'.toUpperCase(),
          ),
        ),
      );
      cart.addToCart(prodect);
    }
  }
}
