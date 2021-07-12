import 'package:flutter/material.dart';
import 'package:network_http/Models/Const.dart';
import 'package:network_http/Models/Prodect.dart';
import 'package:network_http/Pages/ProdectInf.dart';
import 'package:network_http/Provider/Cartitem.dart';
import 'package:network_http/Servises/StoreProdect.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  static final String id = "Cart";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List<Prodect> pInCard = Provider.of<CartItem>(context).prodectsCard;
    final double scrrenHieght = MediaQuery.of(context).size.height;
    final double scrrenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Card Scrren',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constrain) {
                if (pInCard.isNotEmpty) {
                  return ListView.builder(
                    itemCount: pInCard.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: GestureDetector(
                          onTapUp: (details) {
                            double dx = details.globalPosition.dx;
                            double dy = details.globalPosition.dy;
                            double dx2 = MediaQuery.of(context).size.width - dx;
                            double dy2 =
                                MediaQuery.of(context).size.height - dy;

                            showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(
                                  dx,
                                  dy,
                                  dx2,
                                  dy2,
                                ),
                                items: [
                                  PopupMenuItem(
                                    child: GestureDetector(
                                      child: Text('Edit'),
                                      onTap: () {
                                        print('Edit Button');
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushNamed(
                                            ProdectInfo.id,
                                            arguments: pInCard[index]);
                                        Provider.of<CartItem>(context,
                                                listen: false)
                                            .deletingProdect(pInCard[index]);
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: GestureDetector(
                                      child: Text('Delet'),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        Provider.of<CartItem>(context,
                                                listen: false)
                                            .deletingProdect(pInCard[index]);
                                      },
                                    ),
                                  ),
                                ]);
                          },
                          child: Container(
                            color: kPrimeColor,
                            height: scrrenHieght * .2,
                            width: scrrenWidth,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: (scrrenHieght * .2) / 2,
                                  backgroundImage:
                                      AssetImage(pInCard[index].location),
                                  // child: Image(
                                  //   fit: BoxFit.fill,
                                  //   image: AssetImage(pInCard[index].location),
                                  // ),
                                ),
                                SizedBox(
                                  width: scrrenWidth * .03,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            pInCard[index].name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: scrrenHieght * .01,
                                          ),
                                          Text(
                                            '\$ ${pInCard[index].price}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          pInCard[index].qunantaty.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'no Prodect In Card'.toUpperCase(),
                    ),
                  );
                }
              },
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   child:
          ButtonTheme(
            height: scrrenHieght * .07,
            minWidth: scrrenWidth,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                color: kPrimeColor,
                child: Text(
                  'order'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  showdialog(pInCard, context);
                }),
          ),
        ],
      ),
    );
  }

  showdialog(List<Prodect> p, context) {
    var adres;
    AlertDialog alert = AlertDialog(
      title: Text('\$ ${allPrice(p)}'),
      content: TextField(
        decoration: InputDecoration(hintText: 'Enter The Adrress'),
        onChanged: (value) {
          adres = value;
        },
      ),
      actions: [
        MaterialButton(
            child: Text('Confirm'),
            onPressed: () {
              StoreP().storeOrder({
                'Addres': adres,
                'TotalPrice': allPrice(p),
              }, p);
              Navigator.of(context).pop();
              scaffoldKey.currentState
                  .showSnackBar(SnackBar(content: Text('The order Is Done')));
            })
        // RaisedButton(
        //     child: Text('Confirm'),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //       scaffoldKey.currentState
        //           .showSnackBar(SnackBar(content: Text('The order Is Done')));
        //     })
      ],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  int allPrice(List<Prodect> p) {
    int price = 0;
    for (var pr in p) {
      price += int.parse(pr.price) * pr.qunantaty;
    }
    return price;
  }
}
/*   // Card(
              //   shape:
              //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //   elevation: 20,
              //   color: kPrimeColor,
              //   child:

              Container(
            height: scrrenHieght * .1,
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimeColor,
            ),
            child: ListTile(
              isThreeLine: true,
              //  minLeadingWidth: 50,
              //  horizontalTitleGap: 50,

              trailing: Text(
                '\$ Traliling ${pInCard[index].price}',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              leading:
                  //  Column(
                  //   children: [
                  CircleAvatar(
                radius: scrrenHieght * .1,
                backgroundImage: AssetImage(pInCard[index].location),
              ),
              //   //],
              // ),
              title: Text(
                pInCard[index].name,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              subtitle: Text(
                pInCard[index].name,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          );
*/
