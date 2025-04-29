import 'package:flutter/material.dart';
import 'package:techware_products/core/utils/app_theme.dart';

class CommonAppbar extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final double? toolbarHeight;
  final Color? arrowColor;
  final Color? backgroundColor;
  final Widget? actionWidget;
  final EdgeInsets actionPadding;
  final double actionHeight;
  final bool isNeedBackArrow;
  final PreferredSizeWidget? bottom;

  const CommonAppbar({
    super.key,
    required this.title,
    this.titleStyle,
    this.toolbarHeight = 65,
    this.arrowColor,
    this.backgroundColor,
    this.actionWidget,
    this.actionPadding = const EdgeInsets.only(top: 30.0, right: 10),
    this.actionHeight = 35,
    this.isNeedBackArrow = false,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: toolbarHeight,
      backgroundColor: backgroundColor ?? appColor(context).background,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: false,
      bottom: bottom,
      title: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 18),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if(isNeedBackArrow)
                IconButton(
                  padding: const EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                  icon: Icon(Icons.arrow_back_ios_new, color: arrowColor ?? appColor(context).background),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: titleStyle ?? TextStyle(color: appColor(context).primary, fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [Padding(padding: actionPadding, child: SizedBox(height: actionHeight, child: actionWidget ?? const SizedBox()))],
    );
  }
}