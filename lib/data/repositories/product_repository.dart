import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techware_products/domain/enitities/product_entity.dart';

class ProductRepository {
  final _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addProduct(ProductEntity product) async {
    try {
      await _db.collection('products').add(product.toMap());
      return {'status': true};
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  Stream<List<ProductEntity>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductEntity.fromDocument(doc)).toList();
    });
  }
}
