import 'package:fingerprint/Screens/admin/addAdmin.dart';
import 'active_account.dart';
import 'checkmail.dart';
import 'deleteAccount.dart';
import 'delteAdmin.dart';
import 'package:fingerprint/helper/import.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});
  static String? id = "AdminPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Admin"),
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          Image.asset(
            "assets/image/logo.png",
            height: 80,
          ),
          Image.asset(
            "assets/image/money mover.png",
            height: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return RegisterPage1();
                }),
              );
            },
            child: containerAdmin(
                image: "assets/image/draw.png", text: "Add Client"),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return DeleteAccount();
                }),
              );
            },
            child: containerAdmin(
              image: "assets/image/close.png",
              text: "Delete Account",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Addadmin();
              }));
            },
            child: containerAdmin(
              image: "assets/image/add-admin.png",
              text: "Add Admin",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    // not working and display admin page
                    return deleteAdmin(); //DeleteAccount('Admin');
                  },
                ),
              );
            },
            child: containerAdmin(
              image: "assets/image/block-admin.png",
              text: "Delete Admin",
            ),
          ),
          /////////////////////////////////////////////
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    // not working and display admin page
                    return checkmail(); //DeleteAccount('Admin');
                  },
                ),
              );
            },
            child: containerAdmin(
              image: "assets/image/check.png",
              text: "Approve & Reject User",
            ),
          ),
          ///////////////////////////////////////////
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    // not working and display admin page
                    return active_accountt(); //DeleteAccount('Admin');
                  },
                ),
              );
            },
            child: containerAdmin(
              image: "assets/image/active.png",
              text: "Activate Account",
            ),
          ),
          //////////////////////////////////////////
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                // When the user logs out
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Page2()),
                    (Route<dynamic> route) => false);
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
