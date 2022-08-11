import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'z_card.dart';

class ZButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final String text;
  final double? elevation;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final bool isLoading;
  final double? radius;
  final BorderRadius? borderRadius;
  final Color borderRadiusColor;

  ZButton({
    required this.text,
    required this.onTap,
    this.elevation,
    this.color,
    this.margin,
    this.width,
    this.height,
    this.textStyle,
    this.padding,
    this.isLoading = false,
    this.radius,
    this.borderRadius,
    this.borderRadiusColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: height ?? 48,
      width: width ?? null,
      child: ZCard(
        margin: EdgeInsets.symmetric(),
        padding: padding ?? null,
        elevation: elevation,
        color: getColor(context),
        borderRadius: borderRadius ?? BorderRadius.circular(7),
        borderRadiusColor: borderRadiusColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) Row(children: [Center(child: SpinKitFadingCircle(color: Colors.white, size: 25)), SizedBox(width: 5)]),
            Text(text, style: textStyle ?? TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (!isLoading) onTap();
        },
      ),
    );
  }

  Color getColor(BuildContext context) {
    Color _color = color ?? Colors.blue;
    if (!isLoading) return _color;
    return _color.withOpacity(0.8);
  }
}
