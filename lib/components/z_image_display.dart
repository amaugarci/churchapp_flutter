import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shimmer/shimmer.dart';

class ZImageDisplay extends StatelessWidget {
  const ZImageDisplay({Key? key, required this.imageUrl, this.height, this.width, this.borderRadius}) : super(key: key);

  final String imageUrl;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    Color baseColor = isLight ? Colors.grey.shade200 : Colors.grey.shade800;
    Color highlightColor = isLight ? Colors.grey.shade300 : Colors.grey.shade700;
    Color containerColor = isLight ? Colors.grey.shade100 : Colors.grey.shade600;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Container(
        alignment: Alignment.center,
        height: height ?? 85,
        width: width ?? 85,
        child: imageUrl != ''
            ? CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                fadeInCurve: Curves.easeIn,
                fadeInDuration: Duration(milliseconds: 600),
                imageUrl: imageUrl,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(decoration: BoxDecoration(color: containerColor, borderRadius: borderRadius)),
                ),
                errorWidget: (context, url, error) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.black12),
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Icon(AntDesign.picture, size: 45, color: Colors.black26), SizedBox(height: 2)],
                      ),
                    )),
              )
            : Container(
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(AntDesign.picture, size: 45, color: Colors.black26),
                    SizedBox(height: 2),
                  ],
                ),
              ),
      ),
    );
  }
}
