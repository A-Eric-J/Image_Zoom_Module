import 'package:image_zoom/providers/zoom_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// provider_setup initializes the providers that are using in your app
List<SingleChildWidget> providers = [
  ...independentServices,
];

/// you should add your providers here to use
List<SingleChildWidget> independentServices = [
  ListenableProvider.value(value: ZoomProvider()),
];

