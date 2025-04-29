import 'package:flutter/material.dart';
import 'package:techware_products/core/utils/app_theme.dart';

class TextTile extends StatelessWidget {
  final String title;
  final String value;
  const TextTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: appColor(context).subText, fontStyle: FontStyle.italic),
          ),
          TextSpan(
            text: value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: appColor(context).buttonColor, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
