import 'package:adradio/utils/basic_screen_imports.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: crossCenter,
        mainAxisAlignment: mainCenter,
        children: [
          Lottie.asset('assets/empty_animation.json',height: Dimensions.buttonHeight * 3),
          const TitleHeading4Widget(text: Strings.noDataFound, fontWeight: FontWeight.w800)
        ],
      ),
    );
  }
}