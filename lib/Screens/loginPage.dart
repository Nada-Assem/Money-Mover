import '../helper/import.dart';
import 'admin/loginadmin.dart';
import 'contactUs_suspend.dart';
import 'forgetPass.dart';

class login_page extends StatefulWidget {
  login_page({super.key});
  static String? id = "LoginPage";

  @override
  State<login_page> createState() => _login_pageState();
}

final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('User');

Future<bool> fetchUserData_email(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return (value['Email'] == Email);
  }
  // return (value['Email'].toString() == Email) ;
  return false;
}

Future<bool> fetchUserData_Password(String Email, String pass) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return (value['login_Password'] == pass);
  }
  // return (value['Email'].toString() == Email) ;
  return false;
}

Future<bool> check_accuntstate(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return (value['state'] == true);
  }
  return false;
}

late String User_EmailLogin;

class _login_pageState extends State<login_page> {
  TextEditingController controller = TextEditingController();
  String User_Password = '';

  bool passwordVisible = true;
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Login"),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Page2();
            }));
          },
        ),
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          CustomImage(image: "login", hight: 280),
          CustomTextFormField(
            showtext: false,
            type: TextInputType.emailAddress,
            hintText: "Enter your Email",
            onChanged: (data) {
              User_EmailLogin = data;
            },
            labName: "Email",
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
              User_Password = data;
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
                  return ForgetPass('User');
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('email', 'useremail@gmail.com');
              await prefs.setBool('isLoggedIn', true);
              if (!User_EmailLogin.isEmpty && !User_Password.isEmpty) {
                if (await fetchUserData_Password(
                    User_EmailLogin, User_Password)) {
                  if (await check_accuntstate(User_EmailLogin)) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                      return Unlock(User_EmailLogin);
                      //return Home(User_Email);
                    }));
                  } else {
                    // ignore: avoid_single_cascade_in_expression_statements, use_build_context_synchronously
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.scale,
                      title: 'Error',
                      desc:
                          'This account has been suspended, please contact us',
                      btnOkOnPress: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Contact_Suspend()),
                            (Route<dynamic> route) => false);
                      },
                      btnOkColor: Colors.blue,
                    )..show();
                  }
                } else {
                  // ignore: avoid_single_cascade_in_expression_statements, use_build_context_synchronously
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
                // ignore: avoid_single_cascade_in_expression_statements, use_build_context_synchronously
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
          const SizedBox(
            height: 140,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return const loginAdmin();
                  }),
                );
              },
              child: const Text(
                "Login As Admin",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
