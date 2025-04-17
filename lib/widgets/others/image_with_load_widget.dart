import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:adradio/utils/basic_screen_imports.dart';

import '../../utils/basic_widget_imports.dart';

class ImageLoadWidget extends StatefulWidget {
  final String imageUrl;
  final BoxFit? fit;
  final bool? getBackOn;

  const ImageLoadWidget({super.key, required this.imageUrl, this.fit, this.getBackOn});

  @override
  ImageLoadWidgetState createState() => ImageLoadWidgetState();
}

class ImageLoadWidgetState extends State<ImageLoadWidget> {
  late ImageStream _imageStream;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _imageStream =
        Image.network(widget.imageUrl).image.resolve(ImageConfiguration.empty);
    _imageStream.addListener(ImageStreamListener((_, __) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }));
  }

  @override
  void dispose() {
    _imageStream.removeListener(ImageStreamListener((_, __) {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            widget.imageUrl,
            fit: widget.fit ?? BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Opacity(opacity: .7, child: CustomLoadingAPI());
            },
          ),
          if (_isLoading)
            const Opacity(opacity: .7, child: CustomLoadingAPI()),
        ],
      ),
    );
  }
}
