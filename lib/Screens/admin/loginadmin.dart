import 'package:fingerprint/Screens/loginPage.dart';
import 'package:fingerprint/helper/import.dart';
import '../forgetPass.dart';

class loginAdmin extends StatefulWidget {
  const loginAdmin({super.key});

  static String? id = "LoginAdmin";

  @override
  State<loginAdmin> createState() => _loginAdminState();
}

final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('Admin');

Future<bool> fetchAdminData_Password(String Email, String pass) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return (value['login_Password'] == pass);
  }
  return false;
}

class _loginAdminState extends State<loginAdmin> {
  TextEditingController controller = TextEditingController();
  bool passwordVisible = true;

  void initState() {
    super.initState();
    passwordVisible = false;
  }

  String Admin_Email = '@moneymover.com', Admin_Password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Login As Admin"),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return login_page();
            }));
          },
        ),
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          CustomImage(image: "logadmin", hight: 320),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            showtext: false,
            type: TextInputType.emailAddress,
            hintText: "Enter your Email",
            onChanged: (data) {
              Admin_Email = data;
            },
            labName: "Email",
            initialValue: '@moneymover.com',
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            showtext: !passwordVisible,
            iconpass: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                !passwordVisible ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
            type: TextInputType.visiblePassword,
            hintText: "Enter your Password",
            onChanged: (data) {
              Admin_Password = data;
            },
            labName: "Password",
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return ForgetPass('Admin');
                }),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 250),
              child: Text(
                "Forget Password",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          button(
            text: "Login",
            onTap: () async {
              if (!Admin_Email.isEmpty && !Admin_Password.isEmpty) {
                if (await fetchAdminData_Password(
                    Admin_Email, Admin_Password)) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        // not working and display admin page
                        return AdminPage();
                      },
                    ),
                  );
                } else {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Error',
                    desc: 'Check your User_Email and password',
                    btnOkOnPress: () {},
                    btnOkColor: Colors.blue,
                  )..show();
                }
              } else {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Error',
                  desc: 'Please, Enter required data',
                  btnOkOnPress: () {},
                  btnOkColor: Colors.blue,
                )..show();
              }
            },
          ),
        ],
      ),
    );
  }
}
