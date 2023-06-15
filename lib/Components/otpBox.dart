import '../helper/import.dart';

class otpBox extends StatelessWidget {
  otpBox({required this.num});
  String? num;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: 65,
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          //border: Border.all(width: 5, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
            child: Text('$num',
                style: TextStyle(fontSize: 35, color: primaryColor))),
        //color: Colors.white,
      ),
    );
  }
}
