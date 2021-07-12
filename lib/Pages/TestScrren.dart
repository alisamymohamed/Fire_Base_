import 'package:flutter/material.dart';

class TestScrren extends StatefulWidget {
  static final String id = 'TestScrren';
  @override
  _TestScrrenState createState() => _TestScrrenState();
}

class _TestScrrenState extends State<TestScrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          // backgroundColor: Colors.black,
          //  foregroundColor: Colors.red,
          flexibleSpace: FlexibleSpaceBar(
            background: Image(
              image: AssetImage('Assets/img/1.jpg'),
              fit: BoxFit.fill,
            ),
            //  background:,
            title: Text(
              'Sliver App Bar',
            ),
          ),

          title: Icon(Icons.arrow_back),
          leading: Icon(Icons.favorite),

          pinned: true,
          // snap: true,
          // floating: true,
          expandedHeight: 200,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  color: Colors.yellow,
                  child: Text('data$index'),
                ),
              );
            },
            childCount: 20,
          ),
        )
      ],
    ));
  }
}

//     Scaffold(
//       appBar: AppBar(
//         title: Text('Test Scrren'),
//       ),
//       body: Center(
//         child: Column(
//           //crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RaisedButton(
//                 child: Text('Show Dialog'),
//                 onPressed: () {
//                   showDialog(
//                       barrierDismissible: false,
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Delet'),
//                           content: Container(
//                             height: 150,
//                             child: Column(
//                               children: [Icon(Icons.sanitizer)],
//                             ),
//                           ),
//                           actions: [
//                             RaisedButton(
//                               child: Text('No'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                             RaisedButton(
//                               child: Text('Yes'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       });
//                 }),
//             RaisedButton(
//                 child: Text('Show Custom 1'),
//                 onPressed: () {
//                   showDialog(
//                       barrierDismissible: false,
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Dialog(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Container(
//                             height: 200,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'Enter Your Name ',
//                                   ),
//                                   TextField(
//                                     decoration: InputDecoration(
//                                       // labelText: 'Pleas',
//                                       hintText: 'name',
//                                       icon: Icon(
//                                         Icons.person,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   RaisedButton(
//                                       child: Text(
//                                         'Save',
//                                       ),
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       })
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       });
//                 }),
//             RaisedButton(
//                 child: Text('Show Custom 2'),
//                 onPressed: () {
//                   customDialog();
//                 }),
//           ],
//         ),
//       ),
//     );
//   }

//   customDialog() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 40, left: 20, right: 20),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(20)),
//                       height: 200,
//                       width: 250,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'This is The Castum Dialog',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               SizedBox(
//                                 height: 50,
//                               ),
//                               RaisedButton(
//                                 child: Text('Save'),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 5,
//                     right: 5,
//                     top: 0,
//                     child: CircleAvatar(
//                       radius: 40,
//                       backgroundColor: Colors.blue,
//                     ),
//                   )
//                 ],
//               ));
//         });
//   }
// }
