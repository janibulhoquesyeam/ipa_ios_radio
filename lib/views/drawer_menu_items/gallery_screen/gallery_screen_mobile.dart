import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:adradio/controller/drawer/gallery_controller/gallery_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/others/image_with_load_widget.dart';

class GalleryScreenMobile extends StatelessWidget {
  const GalleryScreenMobile({super.key, required this.controller});

  final GalleryController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        Strings.gallery,
        appbarSize: Dimensions.appBarHeight * .75,
        centerTitle: false,
      ),
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return GridView.custom(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.mirrored,
          pattern: [
            const QuiltedGridTile(2, 2),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index){
            var data = controller.galleryModel.data;
            String image = "${data.baseUrl}/${data.imagePath}/${data.galleries[index].image}";
            return ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
              child: GestureDetector(
                onTap: (){
                  Get.to(ImageLoadWidget(imageUrl: image, fit: BoxFit.contain, getBackOn: true));
                },
                child: ImageLoadWidget(
                  // 'https://source.unsplash.com/random?sig=$index',
                  imageUrl: image,
                ),
              ),
            );
          },
          childCount: controller.galleryModel.data.galleries.length
        ));
  }
}