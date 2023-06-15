import 'package:flutter/material.dart';

class container extends StatelessWidget {
  container({required this.icon, required this.text});
  IconData? icon;
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
            child: Icon(
              icon!,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              text!,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ],
      ),
      //color: primaryColor,
    );
  }
}
