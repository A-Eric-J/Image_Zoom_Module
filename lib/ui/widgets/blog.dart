import 'package:image_zoom/ui/shared/colors.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_zoom/ui/widgets/widget_in_busy_state.dart';

/// [ImageAndIconFill] is a custom Image widget that accepts 2 the types of images => network image
/// assets image, you can use it in your app
class ImageAndIconFill extends StatefulWidget {
  final String path;
  final Color? color;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final bool fromNetWork;
  final BoxFit fit;
  final double? radius;
  final Clip? clipBehavior;

  const ImageAndIconFill(
      {Key? key,
      required this.path,
      this.color,
      this.height,
      this.width,
      this.onTap,
      this.fromNetWork = false,
      this.fit = BoxFit.fill,
      this.radius,
      this.clipBehavior})
      : super(key: key);

  @override
  State<ImageAndIconFill> createState() => _ImageAndIconFillState();
}

class _ImageAndIconFillState extends State<ImageAndIconFill> {

  @override
  Widget build(BuildContext context) {
    final placeholderBuilder = PlaceholderBuilder.of(context);

    return InkWell(
      onTap: widget.onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Stroke(
        height: widget.height,
        width: widget.width,
        clipBehavior: widget.clipBehavior,
        radius: widget.radius ?? 0,
        borderWidth: 0,
        child: widget.fromNetWork
            ? NetImage(
                url: widget.path,
                fit: BoxFit.fill,
                networkKey: Key('key ${widget.path}'),
                keyCache: 'key ${widget.path}',
                placeholder: placeholderBuilder != null
                    ? placeholderBuilder.builder()(context)
                    : const WidgetInBusyState(),
                errorPlaceholder: placeholderBuilder != null
                    ? placeholderBuilder.errorBuilder()(context)
                    : const WidgetInBusyState(),
              )
            : Image.asset(
                widget.path,
                fit: widget.fit,
                color: widget.color,
              ),
      ),
    );
  }
}

/// [Stroke] is a custom Container widget that you can use it in your app
class Stroke<T> extends StatefulWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double? minHeight;
  final double? radius;
  final double? borderWidth;
  final Color? disableBorderColor;
  final Color? enableBorderColor;
  final Color? disableShadowColor;
  final Color? enableShadowColor;
  final Color? backgroundColor;
  final T? value;
  final T? groupValue;
  final List<T>? groupsValue;
  final ValueChanged<T>? onChanged;
  final VoidCallback? onTap;
  final BoxShadow? boxShadow;
  final EdgeInsetsGeometry? margin;
  final Clip? clipBehavior;

  const Stroke({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor,
    this.borderWidth,
    this.value,
    this.groupValue,
    this.onChanged,
    this.disableShadowColor,
    this.enableShadowColor,
    this.disableBorderColor,
    this.enableBorderColor,
    this.onTap,
    this.minHeight,
    this.boxShadow,
    this.groupsValue,
    this.margin,
    this.clipBehavior,
  }) : super(key: key);

  @override
  State<Stroke<T>> createState() => _StrokeState<T>();
}

class _StrokeState<T> extends State<Stroke<T>> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: (widget.onTap == null)
          ? ((widget.groupsValue != null)
              ? () => widget.onChanged!(widget.value as T)
              : (widget.value != null)
                  ? () => widget.onChanged!(widget.value as T)
                  : null)
          : widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        margin: widget.margin ?? EdgeInsets.zero,
        constraints: BoxConstraints(minHeight: widget.minHeight ?? 0),
        clipBehavior: widget.clipBehavior ?? Clip.none,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.transparent,
          borderRadius: widget.radius != null
              ? BorderRadius.circular(widget.radius!)
              : BorderRadius.zero,
          border: Border.all(color: color(), width: width()),
          boxShadow: [
            widget.boxShadow ??
                BoxShadow(
                  color: shadowColor(),
                  spreadRadius: 1,
                  blurRadius: 9,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
          ],
        ),
        child: widget.child,
      ),
    );
  }

  void onTap() {
    if (widget.onTap == null) {
      if (widget.groupsValue != null) {
        widget.onChanged!(widget.value as T);
      } else if (widget.value != null) {
        widget.onChanged!(widget.value as T);
      } else {}
    } else {
      widget.onTap!();
    }
  }

  double width() {
    if (widget.value != null) {
      if (widget.groupsValue != null) {
        if (widget.groupsValue!.contains(widget.value)) {
          return 1.5;
        } else {
          return widget.borderWidth ?? 1;
        }
      } else if (widget.value == widget.groupValue) {
        return 1.5;
      } else {
        return widget.borderWidth ?? 1;
      }
    } else {
      return widget.borderWidth ?? 1;
    }
  }

  Color shadowColor() {
    if (widget.value != null) {
      if (widget.groupsValue != null) {
        if (widget.groupsValue!.contains(widget.value)) {
          return widget.enableShadowColor ?? Colors.transparent;
        } else {
          return widget.disableShadowColor ?? Colors.transparent;
        }
      } else if (widget.value == widget.groupValue) {
        return widget.enableShadowColor ?? Colors.transparent;
      } else {
        return widget.disableShadowColor ?? Colors.transparent;
      }
    } else {
      return widget.disableShadowColor ?? Colors.transparent;
    }
  }

  Color color() {
    if (widget.value != null) {
      if (widget.groupsValue != null) {
        if (widget.groupsValue!.contains(widget.value)) {
          return widget.enableBorderColor ?? Colors.transparent;
        } else {
          return widget.disableBorderColor ?? Colors.transparent;
        }
      } else if (widget.value == widget.groupValue) {
        return widget.enableBorderColor ?? Colors.transparent;
      } else {
        return widget.disableBorderColor ?? Colors.transparent;
      }
    } else {
      return widget.disableBorderColor ?? Colors.transparent;
    }
  }
}


/// [NetImage] refers to network image that is a custom version of ExtendedImage that is using in [ImageAndIconFill]
class NetImage extends StatefulWidget {

  final Key? networkKey;
  final String? keyCache;
  final String url;
  final double? height;
  final double? width;
  final int? cacheWidth;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorPlaceholder;

  const NetImage({
    this.networkKey,
    required this.url,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorPlaceholder,
    this.cacheWidth,
    this.keyCache,
  }) : super(key: networkKey);

  @override
  State<NetImage> createState() => _NetImageState();
}

class _NetImageState extends State<NetImage> with TickerProviderStateMixin {
  AnimationController? animation;
  Animation<double>? _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation!);

    animation!.forward();
  }

  @override
  void dispose() {
    animation!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      widget.url,
      key: widget.networkKey,
      width: widget.height,
      height: widget.width,
      cacheWidth: widget.cacheWidth,
      fit: widget.fit,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        Widget renderWidget;

        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            animation!.reset();

            renderWidget = widget.placeholder ??
                SizedBox(
                  width: widget.width,
                  height: widget.height,
                );
            break;
          case LoadState.completed:
            if (state.wasSynchronouslyLoaded) {
              renderWidget = ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
              );
            } else {
              animation!.forward();

              renderWidget = FadeTransition(
                opacity: _fadeInFadeOut!,
                child: ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                ),
              );
            }
            break;
          case LoadState.failed:
            animation!.reset();

            renderWidget = widget.errorPlaceholder ??
                Container(
                  color: brandMainColor,
                  width: widget.width,
                  height: widget.height,
                );
            break;
        }

        return renderWidget;
      },
    );
  }
}

class PlaceholderBuilder extends InheritedWidget {
  final WidgetBuilder Function() builder;
  final WidgetBuilder Function() errorBuilder;

  const PlaceholderBuilder({
    Key? key,
    required this.builder,
    required this.errorBuilder,
    required Widget child,
  })  : super(key: key, child: child);

  static PlaceholderBuilder? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PlaceholderBuilder>();
  }

  @override
  bool updateShouldNotify(PlaceholderBuilder oldWidget) {
    return builder != oldWidget.builder ||
        errorBuilder != oldWidget.errorBuilder;
  }
}
