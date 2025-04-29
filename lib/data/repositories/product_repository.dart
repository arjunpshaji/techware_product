import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techware_products/domain/enitities/product_entity.dart';

class ProductRepository {
  final _db = FirebaseFirestore.instance;

  /// Class to interact with Firestore for product operations.
  ///
  /// Has methods to add and get products.
  /// Adds a new product to Firestore.
  ///
  /// Returns a map with a 'status' key indicating success or failure,
  /// and an optional 'error' key if an error occurred.
  Future<Map<String, dynamic>> addProduct(ProductEntity product) async {
    try {
      await _db.collection('products').add(product.toMap());
      return {'status': true};
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  /// Gets all products from Firestore.
  ///
  /// Returns a stream of ProductEntity objects.
  Stream<List<ProductEntity>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductEntity.fromDocument(doc)).toList();
    });
  }
}
