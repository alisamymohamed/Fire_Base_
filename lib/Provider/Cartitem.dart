import 'package:flutter/cupertino.dart';
import 'package:network_http/Models/Prodect.dart';

class CartItem extends ChangeNotifier {
  List<Prodect> prodectsCard = [];

  addToCart(Prodect p) {
    prodectsCard.add(p);
    notifyListeners();
  }

  deletingProdect(Prodect p) {
    prodectsCard.remove(p);
    notifyListeners();
  }
}
