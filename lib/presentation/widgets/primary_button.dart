import 'package:flutter/material.dart';
import 'package:techware_products/core/utils/app_theme.dart';

class PrimaryButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final double? height;
  final double? width;
  final TextOverflow? overFlow;
  final Color? textColor;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.height = 49.0,
    this.width = double.infinity,
    this.overFlow,
    this.textColor,
    this.isLoading = false,
  });

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Container(decoration: BoxDecoration(color: widget.buttonColor ?? appColor(context).primary, borderRadius: BorderRadius.circular(8))),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isLoading ? null : widget.onPressed,
              borderRadius: BorderRadius.circular(8),
              child: Center(
                child: widget.isLoading ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: appColor(context).primaryText,)) : Text(
                  widget.buttonText,
                  style: TextStyle(color: widget.textColor ?? appColor(context).primaryText, fontWeight: FontWeight.bold, overflow: widget.overFlow),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}