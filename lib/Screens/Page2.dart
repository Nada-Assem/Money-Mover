import '../helper/import.dart';
import 'loginPage.dart';

class Page2 extends StatelessWidget {
  static String? id = "Page2";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/image/logo.png",
            height: 100,
          ),
          Image.asset(
            "assets/image/money mover.png",
            height: 80,
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return login_page();
                }));
              },
              child: container(icon: Icons.login, text: "Login")),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterPage1.id!);
            },
            child: container(icon: Icons.app_registration, text: "Register"),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const contactUs();
                }));
              },
              child: container(icon: Icons.email, text: "Contact us")),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const questions();
                }));
              },
              child: container(icon: Icons.question_answer, text: "FAQ's")),
        ],
      ),
    );
  }
}
