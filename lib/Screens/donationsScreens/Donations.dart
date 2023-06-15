import '../../helper/import.dart';

class Donations extends StatelessWidget {
  String User_Email='';
  Donations(String mail) {
    User_Email = mail;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Donations",
            style: TextStyle(fontSize: 25),
          )),
      body: ListView(
        children: [
          const SizedBox(height: 30), //
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return M_Y(User_Email);
                  },
                ),
              );
            },
            child: D_container(
              image: 'assets/donations/magdiYacoub.png',
              text: "Magdi Yacoub Heart Foundation",
            ),
          ),
          //
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return egyFood(User_Email);
                  },
                ),
              );
            },
            child: D_container(
                image: "assets/donations/egyFoodBank.png",
                text: "Egyption Food Bank"),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "Misr ElKheir Foundation", User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
                image: "assets/donations/misrElkheir.jpg",
                text: "Misr ElKheir Foundation"),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "Dar Al Orman Association", User_Email: User_Email,

                    );
                  },
                ),
              );
            },
            child: D_container(
                image: "assets/donations/darAlorman.png",
                text: "Dar Al Orman Association"),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "Shefa El Orman", User_Email: User_Email,

                    );
                  },
                ),
              );
            },
            child: D_container(
                image: "assets/donations/ShefaElOrman.jpg",
                text: "Shefa El Orman"),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "Children Cancer Hospital 57357", User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
                image: "assets/donations/childercancer.jpg",
                text: "Children Cancer Hospital 57357"),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "ElHelal ElAhmar ElMasry Foundation", User_Email: User_Email,

                    );
                  },
                ),
              );
            },
            child: D_container(
                image: "assets/donations/ElHelalElAhmar.jpg",
                text: "ElHelal ElAhmar ElMasry Foundation"),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "Bayt Al Zakat", User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/donations/baytElzakat.jpg",
              text: "Bayt Al Zakat",
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "Ahl-Masr For Burns", User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/donations/ahlmasrforburns.png",
              text: "Ahl-Masr For Burns",
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "Resala", User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/donations/resala.png",
              text: "Resala",
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    //send donation page
                    return send_D(
                      App_text: "ElNas Hospital", User_Email: User_Email,
                    );
                  },
                ),
              );
            },
            child: D_container(
              image: "assets/donations/elnas.png",
              text: "ElNas Hospital",
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
