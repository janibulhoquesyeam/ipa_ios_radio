import 'package:adradio/backend/services/dashboard_services/dashboard_service.dart';
import 'package:get/get.dart';

import '../../../backend/model/dashboard/team_model.dart';

class TeamController extends GetxController with DashboardService{

  @override
  void onInit() {
    teamProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late TeamModel _teamModel;
  TeamModel get teamModel => _teamModel;

  ///* Get Team in process
  Future<TeamModel> teamProcess() async {
    _isLoading.value = true;
    update();
    await teamProcessApi().then((value) {
      _teamModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _teamModel;
  }

}