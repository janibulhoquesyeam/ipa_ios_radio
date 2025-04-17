

import 'package:adradio/backend/services/dashboard_services/dashboard_service.dart';
import 'package:get/get.dart';

import '../../../backend/model/dashboard/gallery_model.dart';

class GalleryController extends GetxController with DashboardService{


  @override
  void onInit() {
    galleryProcess();
    super.onInit();
  }


  /// ------------------------------------- >>

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late GalleryModel _galleryModel;
  GalleryModel get galleryModel => _galleryModel;

  ///* Get Gallery in process
  Future<GalleryModel> galleryProcess() async {
    _isLoading.value = true;
    update();
    await galleryProcessApi().then((value) {
      _galleryModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _galleryModel;
  }

}