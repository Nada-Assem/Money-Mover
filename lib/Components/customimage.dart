import 'package:fingerprint/helper/import.dart';

class CustomImage extends StatelessWidget {
  CustomImage({super.key, required this.image, required this.hight});
  final String image;
  final double hight;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: hight,
      child: Lottie.asset('assets/imagejson/$image.json'),
    );
  }
}
