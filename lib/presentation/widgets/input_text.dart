import 'package:flutter/material.dart';
import 'package:techware_products/core/utils/app_theme.dart';

class InputText extends StatefulWidget {
  final void Function(String) onChanged;
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final String? Function(String?)? validator;
  const InputText({
    super.key,
    required this.onChanged,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.textStyle,
    this.labelStyle,
    this.validator,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      style: widget.textStyle ?? TextStyle(color: appColor(context).primaryText, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.labelText,
        focusColor: appColor(context).primary,
        labelStyle: widget.labelStyle ?? TextStyle(color: appColor(context).primaryText),
        suffixIcon: widget.obscureText ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: appColor(context).primary, size: 15,),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ) : null,
      ),
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      validator: widget.validator,
    );
  }
}