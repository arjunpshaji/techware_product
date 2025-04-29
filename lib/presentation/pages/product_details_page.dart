import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:techware_products/core/utils/app_theme.dart';
import 'package:techware_products/domain/enitities/product_entity.dart';
import 'package:techware_products/core/utils/app_fade_transition.dart';
import 'package:techware_products/presentation/widgets/common_appbar.dart';
import 'package:techware_products/presentation/widgets/text_tile.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailPage({super.key, required this.product});

  static Route route({required ProductEntity product}) {
    return AppFadeTransition(page: ProductDetailPage(product: product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor(context).background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CommonAppbar(title: product.name, isNeedBackArrow: true, arrowColor: appColor(context).primary),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: appColor(context).primary)),
              const SizedBox(height: 16),
              TextTile(title: 'Measurement: ', value: product.measurement),
              TextTile(title: 'Price: ', value: '₹${product.price}'),
              const SizedBox(height: 32),
              QrImageView(data: product.qrCodeData, version: QrVersions.auto, size: 200.0,backgroundColor: appColor(context).whiteColor!,),
            ],
          ),
        ),
      ),
    );
  }
}
