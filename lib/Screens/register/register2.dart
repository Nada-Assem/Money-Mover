import '../../helper/import.dart';

String email = '';

bool validatepassword(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool emailValid(String value) {
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

////////////////////////////
void countDocuments() async {
  QuerySnapshot _myDoc =
      await FirebaseFirestore.instance.collection('User').get();
  List<DocumentSnapshot> _myDocCount = _myDoc.docs;
  print(_myDocCount.length); // Count of Documents in Collection
}

/////////////////////////////
Map<String, dynamic> Data = {};

class register2 extends StatefulWidget {
  static String? id = "register2";

  register2(String mail, Map<String, dynamic> Dataa) {
    email = mail;
    Data = Dataa;
  }

  @override
  State<register2> createState() => _register2State();
}

final _auth = FirebaseAuth.instance;

Future<bool> isAccountNotExist(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('Email', isEqualTo: email)
      .get();
  return querySnapshot.docs.isEmpty;
}

final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('User');

Future<void> updateinfo(
    String email, String secret_email, String Operations_password) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({
      'secret email': secret_email,
      "Operations password": Operations_password
    });
    print(' updated successfully for user with email $email');
  }
}

class _register2State extends State<register2> {
  String c_secret_email = '', c_Operations_password = '';

  bool passwordVisible = true;

  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(title: "Secret Info"),
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          CustomImage(image: "reg2", hight: 200),
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 2),
                child: Center(
                  child: Text(
                    'Give Us a New E-mail which Will be Secret',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 49, bottom: 10),
                child: Text(
                  "We Will Contact with You through it",
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 2),
                child: Text(
                  'Make a New Password to use inside the App',
                  // "Remember this password as you'll",
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
                child: Center(
                  child: Text(
                    "You will use it in each operation, Don't Forget!",
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          CustomTextFormField(
              showtext: false,
              type: TextInputType.emailAddress,
              hintText: "Enter Email",
              labName: "Email",
              onChanged: (data) {
                c_secret_email = data;
              }),
          const SizedBox(height: 40),
          CustomTextFormField(
              showtext: !passwordVisible,
              iconpass: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  !passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              type: TextInputType.visiblePassword,
              hintText: "Enter Password",
              labName: "Password",
              onChanged: (data) {
                c_Operations_password = data;
              }),
          const SizedBox(height: 50),
          TextButton(
              onPressed: () {
                if (c_Operations_password.isEmpty || c_secret_email.isEmpty) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'error',
                    desc: 'Please, Enter required data',
                    btnOkOnPress: () {},
                    btnOkColor: Colors.blue,
                  )..show();
                } else {
                  if (emailValid(c_secret_email)) {
                    if (validatepassword(c_Operations_password)) {
                      FirebaseFirestore.instance.collection('User').add(Data);
                      updateinfo(email, c_secret_email, c_Operations_password);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return ImageUploadScreen(email);
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
                      desc: 'invalid mail',
                      btnOkOnPress: () {},
                      btnOkColor: Colors.blue,
                    )..show();
                  }
                }
                countDocuments();
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 280),
                child: Text("Next", style: TextStyle(fontSize: 22)),
              ))
        ],
      ),
    );
  }
}
