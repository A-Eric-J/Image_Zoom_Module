import 'package:card_swiper/card_swiper.dart';
import 'package:image_zoom/locator.dart';
import 'package:image_zoom/providers/zoom_provider.dart';
import 'package:image_zoom/services/navigation_service.dart';
import 'package:image_zoom/ui/shared/colors.dart';
import 'package:image_zoom/ui/widgets/blog.dart';
import 'package:image_zoom/ui/widgets/button/icon_button.dart';
import 'package:image_zoom/ui/widgets/text/text_view.dart';
import 'package:flutter/material.dart';
import 'package:image_zoom/ui/widgets/views/zoom_image_screen/custom_zoom.dart';
import 'package:provider/provider.dart';

/// [ZoomImageScreen] contains a galley of images that can be zoom in or out.
/// Note that when you have zoomed in you can not change the page of gallery
/// since you zoom it out!

class ZoomImageScreen extends StatefulWidget {
  final int? initializedIndex;
  final List<String> images;

  const ZoomImageScreen({Key? key, this.initializedIndex, required this.images})
      : super(key: key);

  @override
  State<ZoomImageScreen> createState() => _ZoomImageScreenState();
}

class _ZoomImageScreenState extends State<ZoomImageScreen> {
  var currentIndex = 0;

  @override
  void initState() {
    if (widget.initializedIndex != null) {
      currentIndex = widget.initializedIndex!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: black,
          child: Consumer<ZoomProvider>(
              builder: (context, zoomProvider, snapshot) {
            return Stack(
              children: [
                Center(
                  child: Swiper(
                    index: currentIndex,
                    onIndexChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return CustomZoom(
                        child: ImageAndIconFill(
                          path: widget.images[index],
                          fromNetWork: true,
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    },
                    autoplay: false,
                    loop: widget.images.length == 1 ? false : true,
                    itemCount: widget.images.length,
                    physics: zoomProvider.zoomedIn
                        ? const NeverScrollableScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    control: const SwiperControl(size: 0),
                    // controller: controller,
                  ),
                ),
                Container(
                  color: zoomToolBarColor,
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.0213),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClosingIcon(
                          color: white,
                          onTap: () {
                            locator<NavigationService>().goBack();
                          },
                        ),
                        TextView(
                          text: '${currentIndex + 1}/${widget.images.length}',
                          color: white,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
