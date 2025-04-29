import 'package:flutter/material.dart';
import 'package:techware_products/core/utils/app_theme.dart';

class SearchField extends StatelessWidget {
  final String hint;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  const SearchField({super.key, required this.hint, this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: appColor(context).subText),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12, color: appColor(context).primaryText?.withValues(alpha: 0.5)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appColor(context).background!, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appColor(context).background!, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Padding(padding: const EdgeInsets.all(11), child: Icon(Icons.search, color: appColor(context).primaryText)),
        ),
        style: TextStyle(fontSize: 13, color: appColor(context).primaryText),
      ),
    );
  }
}
