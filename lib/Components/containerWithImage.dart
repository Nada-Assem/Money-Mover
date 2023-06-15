import 'package:flutter/material.dart';

class containerAdmin extends StatelessWidget {
  containerAdmin({super.key, required this.image, this.text});
  String? image;
  String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      height: 55,
      width: 320,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Image.asset(
                image!,
                height: 40,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              text!,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      //color: primaryColor,
    );
  }
}
