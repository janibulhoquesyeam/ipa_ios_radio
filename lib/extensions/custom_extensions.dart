
import 'dart:ui';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../backend/services/api_endpoint.dart';


extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}
extension EndPointExtensions on String {
  String addBaseURl() {
    return ApiEndpoint.baseUrl + this;
  }

  double parseDouble() {
    return double.parse(this);
  }
}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

extension SupperRoute on String {
  get toNamed => Get.toNamed(this);
  get offAllNamed => Get.offAllNamed(this);
  get offNamed => Get.offNamed(this);
}

extension DateTimeShow on DateTime{
  get showFullDate => DateFormat('dd MMMM, yyyy').format(this);
  get showDate => DateFormat('dd').format(this);
  get showMonthFull => DateFormat.MMMM().format(this);
  get showMonthSub => DateFormat('MMM').format(this);

  get showMonthSubCapital => DateFormat('MMM').format(this).toUpperCase();
  get showYearHalf => DateFormat('yy').format(this);
  get showYearFull => DateFormat('yyyy').format(this);

  get showWeek => DateFormat('EEEE').format(this);
  get showTimeOnly => DateFormat('HH:mm:ss').format(this);
  get showDateOnly => DateFormat('yyyy-MM-dd').format(this);
}



