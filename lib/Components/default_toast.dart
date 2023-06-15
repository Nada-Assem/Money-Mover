import 'package:fingerprint/helper/import.dart';

void defaultToast({required String text, Color? color, ToastGravity? type}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: type ?? ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? primaryColor,
      textColor: Colors.white,
      fontSize: 12);
}
