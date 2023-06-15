import 'import.dart';

class txtStyle extends StatelessWidget {
  txtStyle({super.key, required this.text, required this.font});
  String text;
  double font;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: font,
      ),
    );
  }
}
