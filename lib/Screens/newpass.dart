import 'package:fingerprint/helper/import.dart';

String User_mail = "", Role = "";

class newpass extends StatefulWidget {
  newpass(String usermail, String role) {
    User_mail = usermail;
    Role = role;
  }

  @override
  State<newpass> createState() => _newpassState();
}

Future<void> updatepass(
    String email, String login_Password, String role) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(role);
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({"login_Password": login_Password});
    print(' updated successfully for user with email $email');
  }
}

bool validatepassword(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

class _newpassState extends State<newpass> {
  String User_pass = '';
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
        title: appBar(title: "New Password"),
      ),
      backgroundColor: primaryColor,
      body: ListView(children: [
        const SizedBox(height: 15),
        CustomImage(image: "p", hight: 300),
        Text(
          "Enter the new Password",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 40),
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
          type: TextInputType.emailAddress,
          hintText: "new password",
          onChanged: (data) {
            User_pass = data;
          },
          labName: "new password",
        ),
        const SizedBox(height: 70),
        button(
          text: "Reset",
          onTap: () async {
            if (User_pass.isNotEmpty) {
              if (validatepassword(User_pass)) {
                updatepass(User_mail, User_pass, Role);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const DonePassLogin();
                }));
              } else {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Error',
                  desc:
                      'Please Choose A Strong Password Try A Mix Of Letters Numbers And Symbols',
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
                desc: 'Please enter password',
                btnOkOnPress: () {},
                btnOkColor: Colors.blue,
              )..show();
            }
          },
        ),
      ]),
    );
  }
}
