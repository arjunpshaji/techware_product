import 'package:flutter/material.dart';
import 'package:techware_products/domain/enitities/product_entity.dart';
import 'package:techware_products/core/utils/app_theme.dart';

class ProductTile extends StatelessWidget {
  final ProductEntity product;
  final void Function()? onTap;
  const ProductTile({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage("assets/icons/paper_bg.jpg"), fit: BoxFit.cover),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: product.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: appColor(context).background)),
                  TextSpan(
                    text: " / ${product.measurement}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: appColor(context).background, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Text("₹${product.price}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: appColor(context).buttonColor)),
          ],
        ),
      ),
    );
  }
}
