import 'package:fingerprint/helper/import.dart';

class appBar extends StatelessWidget {
  appBar({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20),
    );
  }
}
