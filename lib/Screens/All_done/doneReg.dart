import '../../helper/import.dart';
import '../loginPage.dart';

class doneReg extends StatelessWidget {
  const doneReg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const SizedBox(height: 200),
          CustomImage(image: "thank", hight: 300),
          Center(
            child: Text(
              'Wait until an admin approve your',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          Center(
            child: Text(
              'acount, Then you can login',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 130),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => login_page()),
                  (Route<dynamic> route) => false);
            },
            child: const Center(
              child: Text(
                "Click here to login",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
