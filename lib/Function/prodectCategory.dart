import 'package:network_http/Models/Prodect.dart';

List<Prodect> prodectCategoryFunction(
    String categore, List<Prodect> prodectSav) {
  List<Prodect> pro = [];
  try {
    for (var p in prodectSav) {
      if (p.category == categore) {
        pro.add(p);
        print('lengthinfunction ${pro[0].name}');
      }
    }
  } on Error catch (e) {
    print(e);
  }
  return pro;
}
