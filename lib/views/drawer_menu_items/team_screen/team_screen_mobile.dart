import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../backend/model/dashboard/team_model.dart';
import '../../../controller/drawer/team_controller/team_controller.dart';
import '../../../utils/basic_screen_imports.dart';

class TeamScreenMobile extends StatelessWidget {
  const TeamScreenMobile({super.key, required this.controller});
  final TeamController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        Strings.team,
        appbarSize: Dimensions.appBarHeight * .75,
        centerTitle: false,
      ),
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    Data data = controller.teamModel.data;
    String imagePath = "${data.baseUrl}/${data.imagePath}";
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize,
      ),
      child: MasonryGridView.count(
        scrollDirection: Axis.vertical,
        crossAxisSpacing: Dimensions.paddingHorizontalSize * .5,
        mainAxisSpacing: Dimensions.paddingVerticalSize * .5,
        crossAxisCount: 2,
        itemCount: data.teams.length,
        itemBuilder: (context, index) {
          Team team = data.teams[index];
          int length = team.socialLinks.length;
          return Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.sizeOf(context).height * .08,
                    backgroundColor: CustomColor.primaryLightColor,
                    child: CircleAvatar(
                      radius: MediaQuery.sizeOf(context).height * .075,
                      backgroundImage: NetworkImage('$imagePath/${team.image}'),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingHorizontalSize * .2
                      ),
                      child: CircularWidgets(
                        config: CircularWidgetConfig(
                          innerSpacing: 0,
                          itemRadius: 12,
                          centerWidgetRadius: 36,
                          startAngleDeg: (20),
                          totalArchDeg: (45 * length.toDouble()),
                          isClockwise: true,
                          isAddExtraFakeItem: true,
                          drawOrder: CircularLayoutDrawOrder.itemsOnTop,
                        ),
                        itemsLength: length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: (){
                              _launchUrl(team.socialLinks[i].link);
                            },
                            child: CircleAvatar(
                              radius: 8,
                              backgroundImage: NetworkImage(
                                  '$imagePath/${team.socialLinks[i].image}',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize,
                  vertical: Dimensions.paddingVerticalSize * .1,
                ),
                margin: EdgeInsets.only(
                  bottom: Dimensions.paddingVerticalSize * .75,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 5),
                  color: CustomColor.primaryLightColor,
                ),
                child: Column(
                  children: [
                    TitleHeading4Widget(
                      text: team.itemName,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w700,
                      color: CustomColor.whiteColor,
                    ),
                    TitleHeading5Widget(
                      text: team.itemDesignation,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: Dimensions.headingTextSize7,
                      color: CustomColor.whiteColor.withOpacity(.6),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
