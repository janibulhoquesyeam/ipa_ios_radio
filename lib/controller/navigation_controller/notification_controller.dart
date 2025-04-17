
import 'package:adradio/backend/services/dashboard_services/dashboard_service.dart';
import 'package:get/get.dart';

import '../../backend/model/dashboard/notification_model.dart';

class NotificationController extends GetxController with DashboardService{

  @override
  void onInit() {
    notificationProcess();
    super.onInit();
  }
  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late NotificationModel _notificationModel;
  NotificationModel get notificationModel => _notificationModel;

  ///* Get Notification in process
  Future<NotificationModel> notificationProcess() async {
    _isLoading.value = true;
    update();
    await notificationProcessApi().then((value) {
      _notificationModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _notificationModel;
  }

}