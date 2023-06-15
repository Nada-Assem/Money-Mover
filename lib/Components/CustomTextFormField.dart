import '../helper/import.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {required this.hintText,
      required this.onChanged,
      this.labName,
      this.len,
      this.min,
      this.iconpass,
      this.initialValue,
      required this.showtext,
      required this.type,this.enabled});
  String? hintText;
  String? initialValue;
  String? labName;
  TextInputType? type;
  int? len;
  bool? enabled;
  int? min;
  Widget? iconpass;
  bool showtext;
  Function(String)? onChanged;
  //Function ()
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        //controller: _userPasswordController,
        obscureText: showtext,
        maxLength: len,
        minLines: min,
        enabled: enabled,
        initialValue: initialValue,
        keyboardType: type,
        validator: (data) {
          if (data == "") {
            return "field is requird";
          }
        },
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          //password
          suffixIcon: iconpass,
          //============
          counterStyle: const TextStyle(color: Colors.blue),
          label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              labName!,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 14.5,
              ),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
