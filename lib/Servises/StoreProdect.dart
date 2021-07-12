import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:network_http/Models/Prodect.dart';

class StoreP {
  // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
  // FirebaseFirestore firestore =
  //     FirebaseFirestore.instanceFor(app: null );

  // CollectionReference fStore =
  //     FirebaseFirestore.instance.collection('collection');

  FirebaseFirestore fStore = FirebaseFirestore.instance;
  Future addProdect(Prodect p) {
    return fStore.collection('collection').add({
      //return fStore.add({
      'ProdectName': p.name,
      'Prodectprice': p.price,
      'Prodectdescrption': p.descrption,
      'Prodectcategory': p.category,
      'Prodectlocation': p.location,
    });
  }

//   Future<List<Prodect>> loadProdects() async {
//     List<Prodect> prodects = [];
//     var snapshot = await fStore.get();
//     for (var doc in snapshot.docs) {
//       var data = doc.data();
//       prodects.add(Prodect(
//         price: data['Prodectprice'],
//         name: data['ProdectName'],
//         descrption: data['Prodectdescrption'],
//         category: data['Prodectcategory'],
//         location: data['Prodectlocation'],
//       ));
//     }
//     return prodects;
//   }

  Stream<QuerySnapshot> loadingProduct() {
    return fStore.collection('collection').snapshots();
  }

  deletProdect(doId) {
    fStore.doc(doId).delete();
  }

  editProdect(data, doId) {
    fStore.doc(doId).update(data);
  }

  storeOrder(data, List<Prodect> prodects) {
    var documentRef = fStore.collection("order").doc();
    documentRef.set(data);

    for (var p in prodects) {
      documentRef.collection("order details").doc().set({
        'ProdectName': p.name,
        'Prodectprice': p.price,
        'Prodectdescrption': p.descrption,
        'Prodectcategory': p.category,
        'Prodectlocation': p.location,
      });
    }
  }

  Stream<QuerySnapshot> orderDetails() {
    return fStore.collection('order').snapshots();
  }
}
