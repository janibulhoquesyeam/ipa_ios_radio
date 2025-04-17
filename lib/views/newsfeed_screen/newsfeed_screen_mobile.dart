import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:adradio/views/newsfeed_screen/sub_screen_widget/my_carousel_slider.dart';

import '../../controller/newsfeed_controller/newsfeed_controller.dart';
import '../../utils/basic_screen_imports.dart';
import 'sub_screen_widget/show_time_widget.dart';
import 'sub_screen_widget/video_play_list_widget.dart';

class NewsfeedScreenMobile extends StatelessWidget {
  const NewsfeedScreenMobile({
    super.key,
    required this.controller,
  });

  final NewsfeedController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        verticalSpace(Dimensions.heightSize),
        MyCarouselSlider(),
        ShowTimeWidget(),
        VideoPlayListWidget(),
        verticalSpace(Dimensions.heightSize * 2),
      ],
    );
  }
}