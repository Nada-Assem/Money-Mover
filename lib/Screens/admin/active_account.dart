import 'package:fingerprint/helper/import.dart';

Future<bool> isAccountNotExist(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('Email', isEqualTo: email)
      .get();
  return querySnapshot.docs.isEmpty;
}

Future<void> active(String email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({'state': true});
    print(' suspend the account and send message to mail $email');
  }
}

class active_accountt extends StatelessWidget {
  String User_mail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Activate Account"),
      ),
      backgroundColor: primaryColor,
      body: ListView(children: [
        // SizedBox(
        //   height: 200,
        // ),
        CustomImage(image: "activar", hight: 200),
        const SizedBox(height: 20),
        Column(
          children: const [
            Center(
              child: Text(
                "Please Enter The Email Of Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
            Center(
              child: Text(
                "You Want To Activate",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 50),
        CustomTextFormField(
          showtext: false,
          type: TextInputType.emailAddress,
          hintText: "Enter the Email",
          onChanged: (data) {
            User_mail = data;
          },
          labName: "Email",
        ),
        const SizedBox(height: 70),
        button(
          text: "Activate",
          onTap: () async {
            bool Exist = await isAccountNotExist(User_mail);
            if (User_mail.isNotEmpty) {
              if (!Exist) {
                active(User_mail);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('The account has been activated : $User_mail')));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return const Done();
                  }),
                );
              } else {
                // ignore: avoid_single_cascade_in_expression_statements, use_build_context_synchronously
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Error',
                  desc: 'Mail not Exist',
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
                desc: 'enter email',
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
