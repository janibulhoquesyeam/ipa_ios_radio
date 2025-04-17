
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../backend/model/dashboard/dashboard_model.dart';
import '../../utils/basic_screen_imports.dart';

class VideoScreenMobile extends StatefulWidget {
  const VideoScreenMobile({super.key, required this.video});

  final Video video;

  @override
  State<VideoScreenMobile> createState() => _VideoScreenMobileState();
}

class _VideoScreenMobileState extends State<VideoScreenMobile> {

  late YoutubePlayerController _controller;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.itemLink.split("/embed/").last,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _controller.addListener(() {
      if (_controller.value.isFullScreen != isFullScreen) {
        setState(() {
          isFullScreen = _controller.value.isFullScreen;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: PrimaryAppBar(
            widget.video.itemTitle,
            centerTitle: false,
            appbarSize: Dimensions.heightSize * 4,
          ),
          body: _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return YoutubePlayerBuilder(
        onExitFullScreen: () {
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          setState(() {
            isFullScreen = true;
          });
        },
        player: YoutubePlayer(
          controller: _controller,
          liveUIColor: Colors.amber,
          showVideoProgressIndicator: true,

        ),
        builder: (context, player) => Scaffold(
          body: ListView(
            children: [
              player,
            ],
          ),
        )
    );
  }
}
