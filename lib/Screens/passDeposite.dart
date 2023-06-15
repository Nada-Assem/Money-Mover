import '../helper/import.dart';
import 'fingerAuth.dart';

String User_Emailll = '';

class PassDeposite extends StatefulWidget {
  PassDeposite(String mail) {
    User_Emailll = mail;
  }

  @override
  State<PassDeposite> createState() => _PassDepositeState();
}

String user_password = '';
final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('User');

Future<bool> fetchUserData_Password(String Email, String pass) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return (value['Operations password'] == pass);
  }
  // return (value['Email'].toString() == Email) ;
  return false;
}

Future<void> suspendd(String email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({'state': false});
    print(' suspend the account and send message to mail $email');
  }
}

int counter = 0;

class _PassDepositeState extends State<PassDeposite> {
  bool passwordVisible = true;

  void initState() {
    super.initState();
    passwordVisible = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(title: "Password"),
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          const SizedBox(height: 15),
          CustomImage(image: "reg2", hight: 300),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: txtStyle(text: "Enter your Password", font: 18),
          ),
          const SizedBox(height: 30),
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
              hintText: "Enter your Password here",
              labName: "Password",
              onChanged: (data) {
                user_password = data;
              }),
          const SizedBox(height: 50),
          button(
              text: "Go to OTP",
              onTap: () async {
                if (User_Emailll.isNotEmpty || user_password.isNotEmpty) {
                  if (await fetchUserData_Password(
                      User_Emailll, user_password)) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                      return OTP();
                    }));
                  } else {
                    counter++;
                    // ignore: avoid_single_cascade_in_expression_statements, use_build_context_synchronously
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.scale,
                      title: 'Error',
                      desc: 'invalid password',
                      btnOkOnPress: () {},
                      btnOkColor: Colors.blue,
                    )..show();
                  }
                } else {
                  counter++;
                  // ignore: avoid_single_cascade_in_expression_statements, use_build_context_synchronously
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Error',
                    desc: 'enter required data ',
                    btnOkOnPress: () {},
                    btnOkColor: Colors.blue,
                  )..show();
                }

                if (counter >= 3) {
                  // ignore: avoid_single_cascade_in_expression_statements, use_build_context_synchronously
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Error',
                    desc:
                        'You have entered the password wrong for 3 times, For more secure get the second level of security',
                    btnOkOnPress: () {
                      counter = 0;
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return FingerAuth('deposit');
                      }));
                    },
                    btnOkColor: Colors.blue,
                  )..show();
                }
              }),
        ],
      ),
    );
  }
}
