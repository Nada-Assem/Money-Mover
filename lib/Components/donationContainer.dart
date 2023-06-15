import 'package:flutter/material.dart';

class D_container extends StatelessWidget {
  D_container({required this.image, required this.text});
  String? image;
  String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: 400,
      child: Row(
        children: [
          const SizedBox(width: 15),
          Image.asset(
            image!,
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 15),
          Text(text!,
              style: const TextStyle(fontSize: 15, color: Colors.white)),
        ],
      ),
    );
  }
}
