//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:network_http/Models/Order.dart';
//import 'package:network_http/Servises/StoreProdect.dart';

class ViewOrder extends StatefulWidget {
  static final String id = 'ViewOrder';
  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  int favColor = Colors.white.value;
  SharedPreferences prefs;

  setData(int c) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt("favColor", c);
  }

  getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      favColor = prefs.getInt('favColor');
    });
  }

  // Color favColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      // backgroundColor: Color(favColor),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadioListTile(
              title: Text('Green'),
              value: Colors.green.value,
              groupValue: favColor,
              onChanged: (int value) {
                setState(() {
                  favColor = value;
                });
              }),
          RadioListTile(
              title: Text('red'),
              value: Colors.red.value,
              groupValue: favColor,
              onChanged: (int col) {
                setState(() {
                  favColor = col;
                });
              }),
          RadioListTile(
              title: Text('blue'),
              value: Colors.blue.value,
              groupValue: favColor,
              onChanged: (int value) {
                setState(() {
                  favColor = value;
                });
              })
        ],
      )),
    );
  }
}
// class ViewOrder extends StatelessWidget {
//   static final String id = 'ViewOrder';
//   StoreP p = StoreP();
//   List<Order> orderListDetails = [];

//   int favColor = Colors.white.value;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           RadioListTile(
//               value: favColor, groupValue: Colors.green, onChanged: (value) {

//               })
//         ],
//       )),
//     );

//  Scaffold(
//   body: StreamBuilder<QuerySnapshot>(
//     stream: p.orderDetails(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         for (var a in snapshot.data.docs) {
//           var data = a.data();
//           orderListDetails.add(Order(
//               address: data['Addres'], totalPrice: data['TotalPrice']));
//         }
//         return ListView.builder(
//             itemCount: orderListDetails.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 100,
//                   decoration: BoxDecoration(
//                       color: Colors.yellow,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: Column(
//                     children: [
//                       Text(orderListDetails[index].address),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text('\$${orderListDetails[index].totalPrice}'),
//                     ],
//                   ),
//                 ),
//               );
//             });
//       } else {
//         return Center(
//           child: Text('Loading'),
//         );
//       }
//     },
//   ),
// );
//   }
// }
