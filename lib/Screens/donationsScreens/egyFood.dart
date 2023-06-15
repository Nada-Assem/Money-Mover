import '../../helper/import.dart';

class egyFood extends StatelessWidget {
  String User_Email = '';
  egyFood(String mail) {
    User_Email = mail;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Egyption Food Bank", style: TextStyle(fontSize: 20)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return send_D(
                      App_text: "Food Bank",
                      User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: 'Food Bank',
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "Saq Odheya Balady - Food Bank",
                      User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: "Saq Odheya Balady - Food Bank",
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "Saq Mostawrad - Food Bank",
                      User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/image/donationIcon.png",
              text: "Saq Mostawrad - Food Bank",
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
