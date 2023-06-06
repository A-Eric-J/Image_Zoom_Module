import 'package:flutter/material.dart';
import 'package:image_zoom/ui/shared/colors.dart';

/// Collection of IconButtons  that are using in your app

class ClosingIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;

  const ClosingIcon({Key? key, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.close,
        size: width * 0.0533,
        color: color ?? backingIconColor,
      ),
    );
  }
}
