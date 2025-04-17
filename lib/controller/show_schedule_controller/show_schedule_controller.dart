
import 'package:adradio/extensions/custom_extensions.dart';

import '../../backend/model/dashboard/show_schedule_model.dart';
import '../../backend/services/dashboard_services/dashboard_service.dart';
import '../../utils/basic_screen_imports.dart';

class ShowScheduleController extends GetxController with DashboardService{

  late Rx<Day> selectedDay;
  RxInt currentShowIndex = (-1).obs;
  String imagePath = "";


  @override
  void onInit() {
    showScheduleProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  late ShowScheduleModel _showScheduleModel;
  ShowScheduleModel get showScheduleModel => _showScheduleModel;


  ///* Get ShowSchedule in process
  Future<ShowScheduleModel> showScheduleProcess() async {
    _isLoading.value = true;
    update();
    await showScheduleProcessApi().then((value) {
      _showScheduleModel = value!;
      selectedDay = _showScheduleModel.data.days.first.obs;
      debugPrint(">> Step >> day match checking");
      for (var element in _showScheduleModel.data.days) {
        debugPrint(">> Day Name: ${element.name} : ${DateTime.now().showWeek}");
        if(element.name == DateTime.now().showWeek){
          debugPrint(">> Step >> day matched");
          debugPrint("");
          selectedDay = element.obs;
          break;
        }
      }

      for (int index = 0; index < selectedDay.value.dailySchedule.length; index++) {
        var element = selectedDay.value.dailySchedule[index];

        DateTime start = DateTime.parse("${DateTime.now().showDateOnly} ${element.startTime}");
        DateTime end = DateTime.parse("${DateTime.now().showDateOnly} ${element.endTime}");
        DateTime myDateTime = DateTime.now();

        debugPrint(">> Step>> Start: ${element.startTime}, End: ${element.endTime}");
        bool activeTime = (myDateTime.isAfter(start) && myDateTime.isBefore(end));
        debugPrint(">> Step >> ${activeTime.toString()} :: ${myDateTime.showTimeOnly}");

        if (activeTime) {
          debugPrint(">> Step >> In Time Select ${currentShowIndex.value}");
          currentShowIndex.value = index;
          break;
        }
      }

      imagePath = "${_showScheduleModel.data.baseUrl}/${_showScheduleModel.data.imagePath}";

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _showScheduleModel;
  }
}