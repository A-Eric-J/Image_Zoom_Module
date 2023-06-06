import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:image_zoom/const_values/assets.dart';
import 'package:image_zoom/const_values/route_paths.dart';
import 'package:image_zoom/locator.dart';
import 'package:image_zoom/services/navigation_service.dart';
import 'package:image_zoom/ui/shared/colors.dart';
import 'package:image_zoom/ui/widgets/blog.dart';
import 'package:image_zoom/ui/widgets/text/text_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var images = <String>[];

  @override
  void initState() {
    super.initState();
    images = Assets.images;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TextView(
              text: 'Tab to zoom!',
              size: 16,
              color: primaryDark,
            ),
            SizedBox(
              height: width * 0.03,
            ),
            Expanded(
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: ImageAndIconFill(
                      path: images[index],
                      fromNetWork: true,
                      radius: width * 0.04,
                      clipBehavior: Clip.hardEdge,
                      onTap: () => locator<NavigationService>().navigateTo(
                          RoutePaths.zoomImageScreen,
                          arguments: {'index': index, 'images': images}),
                    ),
                  );
                },
                autoplay: true,
                loop: images.length == 1 ? false : true,
                itemCount: images.length,
                physics: const AlwaysScrollableScrollPhysics(),
                control: const SwiperControl(size: 0),
                pagination: images.length > 1
                    ? SwiperPagination(
                        margin: const EdgeInsets.all(0.0),
                        builder: SwiperCustomPagination(builder:
                            (BuildContext context, SwiperPluginConfig config) {
                          return ConstrainedBox(
                            constraints:
                                BoxConstraints.expand(height: width * 0.048),
                            child: Align(
                              alignment: Alignment.center,
                              child: DotSwiperPaginationBuilder(
                                color: white,
                                activeColor: brandMainColor,
                                size: width * 0.015,
                              ).build(context, config),
                            ),
                          );
                        }))
                    : null,
                // controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
