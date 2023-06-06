import 'package:flutter/material.dart';
import 'package:image_zoom/const_values/route_paths.dart';
import 'package:image_zoom/ui/views/zoom_image_screen/zoom_image_screen.dart';
import 'package:image_zoom/ui/widgets/text/text_view.dart';


/// All the Routes for navigating are placed here
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.zoomImageScreen:
        var arguments = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => ZoomImageScreen(
              initializedIndex: arguments['index'],
              images: arguments['images'],
            ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: TextView(
                      text: 'No route defined for ${settings.name}',
                      size: 16,
                    ),
                  ),
                ));
    }
  }
}
