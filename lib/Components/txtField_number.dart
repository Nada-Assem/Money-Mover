import 'package:fingerprint/helper/import.dart';

class txtField extends StatelessWidget {
  txtField({required this.HintText, required this.Data});
  String? HintText;
  @override
  TextEditingController Data = TextEditingController();

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 18,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintStyle: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 14,
          ),
          hintText: HintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        controller: Data,
      ),
    );
  }
}
