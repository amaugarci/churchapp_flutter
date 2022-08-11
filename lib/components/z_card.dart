import 'package:flutter/material.dart';

class ZCard extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final Color borderRadiusColor;
  final Color? color;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureTapCallback? onLongPress;
  final Color? shadowColor;
  final double? elevation;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  ZCard({
    Key? key,
    required this.child,
    this.borderRadius,
    this.borderRadiusColor = Colors.transparent,
    this.color,
    this.onTap,
    this.shadowColor,
    this.elevation,
    this.margin,
    this.padding,
    this.height,
    this.width,
    this.onDoubleTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      width: width ?? null,
      decoration: BoxDecoration(border: Border.all(color: borderRadiusColor), borderRadius: borderRadius ?? BorderRadius.circular(8)),
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        margin: EdgeInsets.all(0),
        color: color ?? null,
        elevation: elevation ?? 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(8)),
        child: InkWell(
          // splashColor: Color(0x66C8C8C8),
          focusColor: Colors.grey.shade50,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          onTap: onTap ?? null,
          onDoubleTap: onDoubleTap ?? null,
          onLongPress: onLongPress ?? null,
          child: Container(padding: padding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 6), child: child),
        ),
      ),
    );
  }

  Color? get getColor {
    if (color == null) return null;
    return color!.withOpacity(0.9);
  }
}
