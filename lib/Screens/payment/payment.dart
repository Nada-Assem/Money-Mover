import 'package:fingerprint/Screens/payment/water.dart';
import '../../helper/import.dart';
import 'electricity.dart';
import 'gas.dart';

class payment extends StatelessWidget {
  String User_Email = '';

  payment(String mail) {
    User_Email = mail;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: appBar(title: "Payment"),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          CustomImage(image: "payment", hight: 300),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return Electricity(User_Email);
                  },
                ),
              );
            },
            child: NewWidget(
              image: "electric",
              text: "Electricity",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return Water(User_Email);
                  },
                ),
              );
            },
            child: NewWidget(
              image: "water",
              text: "Water",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return Gass(User_Email);
                  },
                ),
              );
            },
            child: NewWidget(
              image: "gas",
              text: "Gas",
            ),
          ),
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  NewWidget({
    super.key,
    required this.text,
    required this.image,
  });
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xff369be9)),
      ),
      child: Row(children: [
        const SizedBox(width: 15),
        CustomImage(image: image, hight: 100),
        const SizedBox(width: 20),
        Text(
          text,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 23,
          ),
        )
      ]),
    );
  }
}
