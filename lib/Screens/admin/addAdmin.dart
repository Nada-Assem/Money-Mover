import 'package:fingerprint/helper/import.dart';

class Addadmin extends StatefulWidget {
  const Addadmin({super.key});

  @override
  State<Addadmin> createState() => _AddadminState();
}

bool validatepassword(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool emailValid(String value) {
  String pattern = r"^[a-zA-Z0-9._]+@moneymover\.com$";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

Future<bool> isAccountNotExist(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Admin')
      .where('Email', isEqualTo: email)
      .get();
  return querySnapshot.docs.isEmpty;
}

class _AddadminState extends State<Addadmin> {
  bool passwordVisible = true;

  void initState() {
    super.initState();
    passwordVisible = false;
  }

  String Admin_mail = '@moneymover.com', Admin_password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Add Admin"),
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          CustomImage(image: "addAdmin", hight: 280),
          CustomTextFormField(
            showtext: false,
            type: TextInputType.emailAddress,
            hintText: "Enter Email for the new admin",
            onChanged: (data) {
              Admin_mail = data;
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
            hintText: "Enter Password for the new admin",
            onChanged: (data) {
              Admin_password = data;
            },
            labName: "Password",
          ),
          const SizedBox(
            height: 60,
          ),
          button(
            text: "Add",
            onTap: () async {
              Map<String, dynamic> Data = {
                'Email': Admin_mail,
                'login_Password': Admin_password,
              };
              if (Admin_password.isEmpty || Admin_mail.isEmpty) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Error',
                  desc: 'Please, Enter required data',
                  btnOkOnPress: () {},
                  btnOkColor: Colors.blue,
                )..show();
              } else {
                bool doesNotExist = await isAccountNotExist(Admin_mail);
                if (emailValid(Admin_mail)) {
                  if (validatepassword(Admin_password)) {
                    if (doesNotExist) {
                      FirebaseFirestore.instance.collection('Admin').add(Data);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            // not working and display admin page
                            return const Done();
                          },
                        ),
                      );
                    } else {
                      //Account already exists
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        title: 'Error',
                        desc: 'Account already exists',
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
                    desc: 'invalid mail',
                    btnOkOnPress: () {},
                    btnOkColor: Colors.blue,
                  )..show();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
