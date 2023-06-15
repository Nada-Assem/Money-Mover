import '../../helper/import.dart';
import '../loginPage.dart';

class DonePassLogin extends StatelessWidget {
  const DonePassLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const SizedBox(height: 140),
          CustomImage(image: "d", hight: 300),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(5),
            child: txtStyle(text: 'Password is Updated Successfully', font: 18),
          ),
          const SizedBox(height: 100),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => login_page()),
                  (Route<dynamic> route) => false);
            },
            child: const Center(
              child: Text(
                "Click here to Login",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
