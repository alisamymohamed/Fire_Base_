import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:network_http/Function/prodectCategory.dart';
import 'package:network_http/Models/Const.dart';
import 'package:network_http/Models/Prodect.dart';
import 'package:network_http/Pages/CartScreen.dart';
import 'package:network_http/Pages/ProdectInf.dart';
import 'package:network_http/Servises/StoreProdect.dart';
import 'package:network_http/Widgets/ProdectView.dart';

class HomePage extends StatefulWidget {
  static final route = 'HomePage';
  @override
  HomePage_State createState() => HomePage_State();
}

class HomePage_State extends State<HomePage> {
  // static final route = 'HomePage';

  List<Prodect> prodectSave = [];
  final leStore = StoreP();
  int currentIndexTab = 0;
  int currentIndexNavgator = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndexNavgator,
              selectedItemColor: Colors.red[400],
              unselectedItemColor: kmainColor,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  currentIndexNavgator = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('person'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('person'),
                  activeIcon: Icon(Icons.save),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('person'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('person'),
                ),
              ],
            ),
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                    indicatorColor: Colors.red[400],
                    onTap: (index) {
                      setState(() {
                        currentIndexTab = index;
                      });
                    },
                    tabs: [
                      Text(
                        'jacket1',
                        style: TextStyle(
                            color: currentIndexTab == 0
                                ? Colors.black
                                : Colors.black12),
                      ),
                      Text(
                        'jacket2',
                        style: TextStyle(
                            color: currentIndexTab == 1
                                ? Colors.black
                                : Colors.black12),
                      ),
                      Text(
                        'jacket3',
                        style: TextStyle(
                            color: currentIndexTab == 2
                                ? Colors.black
                                : Colors.black12),
                      ),
                      Text(
                        'jacket 4',
                        style: TextStyle(
                            color: currentIndexTab == 3
                                ? Colors.black
                                : Colors.black12),
                      ),
                    ])),
            body: TabBarView(children: [
              // setState
              jacket(),
              //prodectViewByCategory(kJacjet, prodectSave),
              prodectViewByCategory(kteshart, prodectSave),
              // prodectViewByCategory(kShose, prodectSave),
              Text('data'),
              Text('data'),
            ]),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Cart.id);
                    },
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * .05,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        )
      ],
    );
  }

  Widget jacket() {
    return StreamBuilder<QuerySnapshot>(
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
          prodectSave = [...prodects];
          prodects.clear();
          prodects = prodectCategoryFunction(kJacjet, prodectSave);
          // print(prodectSave.length);

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: .8),
            itemCount: prodects.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ProdectInfo.id, arguments: prodects[index]);
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
            ),
          );
        } else {
          return Text('Loading ......');
        }
      },
    );
  }
}
