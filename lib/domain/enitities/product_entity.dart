import 'package:cloud_firestore/cloud_firestore.dart';

class ProductEntity {
  final String id;
  final String name;
  final String measurement;
  final double price;
  final String qrCodeData;

  ProductEntity({
    required this.id,
    required this.name,
    required this.measurement,
    required this.price,
    required this.qrCodeData,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'measurement': measurement,
      'price': price,
      'qrCodeData': qrCodeData,
    };
  }

  factory ProductEntity.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ProductEntity(
      id: doc.id,
      name: data['name'] ?? '',
      measurement: data['measurement'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      qrCodeData: data['qrCodeData'] ?? '',
    );
  }
}