import 'package:image_zoom/providers/zoom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// [CustomZoom] is a customized widget for zooming in or out
class CustomZoom extends StatefulWidget {
  final Widget child;

  const CustomZoom({Key? key, required this.child}) : super(key: key);

  @override
  State<CustomZoom> createState() => _CustomZoomState();
}

class _CustomZoomState extends State<CustomZoom>
    with SingleTickerProviderStateMixin {
  TransformationController? controller;
  AnimationController? animationController;
  Animation<Matrix4>? animation;
  ZoomProvider? zoomProvider;

  final double minScale = 1;
  final double maxScale = 4;

  double scale = 1;
  OverlayEntry? entry;

  @override
  void initState() {
    super.initState();
    zoomProvider = Provider.of(context, listen: false);
    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => controller!.value = animation!.value);
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
    animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return buildZoomImage(widget.child, width);
  }

  Widget buildZoomImage(Widget child, double width) {
    return Builder(
        builder: (context) => InteractiveViewer(
              transformationController: controller,
              clipBehavior: Clip.none,
              panEnabled: true,
              minScale: minScale,
              maxScale: maxScale,
              onInteractionUpdate: (details) {
                if (controller!.value[0] > 1.0) {
                  zoomProvider!.setZoomedIn(true);
                } else {
                  zoomProvider!.setZoomedIn(false);
                }
              },
              onInteractionEnd: (details) {
                if (controller!.value[0] > 1.0) {
                  zoomProvider!.setZoomedIn(true);
                } else {
                  zoomProvider!.setZoomedIn(false);
                }
              },
              child: AspectRatio(
                aspectRatio: 1,
                child: child,
              ),
            ));
  }
}
