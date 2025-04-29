import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techware_products/domain/enitities/product_entity.dart';
import 'package:techware_products/data/repositories/product_repository.dart';

part 'product_notifier.g.dart';

@riverpod
class ProductNotifier extends _$ProductNotifier {
  late final ProductRepository _productRepository;

  @override
  Stream<List<ProductEntity>> build() {
    _productRepository = ProductRepository();
    return _productRepository.getProducts();
  }
  /// Adds a new product to Firestore.
  ///
  /// Returns a boolean indicating success or failure.
  Future<bool> addProduct(ProductEntity product) async {
    final result = await _productRepository.addProduct(product);
    return result['status'];
  }
}