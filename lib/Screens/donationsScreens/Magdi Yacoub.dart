import 'package:fingerprint/Screens/donationsScreens/newHospital.dart';
import '../../helper/import.dart';
import 'childOperation.dart';

class M_Y extends StatelessWidget {
  String User_Email = '';
  M_Y(String mail) {
    User_Email = mail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Magdi Yacoub Heart Foundation",
            style: TextStyle(fontSize: 20)),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return send_D(
                      App_text: "General Donation",
                      User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: 'General Donation',
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return BabyOperation(User_Email, 'Child Operation');
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: 'Child Operation',
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return MecicalEquiment(User_Email, 'Medical Equipment');
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: 'Medical Equipment',
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return newHospital(User_Email, 'New Hospital Construction');
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: 'New Hospital Construction',
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return send_D(
                      App_text: "Sadaka Garia",
                      User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: 'Sadaka Garia',
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return send_D(
                      App_text: "Zakat Mal",
                      User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: 'Zakat Mal',
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return send_D(
                      App_text: "Donation(F.Plus)",
                      User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: 'Donation(F.Plus)',
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
