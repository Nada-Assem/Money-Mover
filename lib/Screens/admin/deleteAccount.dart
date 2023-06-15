import 'package:fingerprint/helper/import.dart';

Future<void> deleteAccountByEmail(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('Email', isEqualTo: email)
      .get();

  final List<QueryDocumentSnapshot> docs = querySnapshot.docs;

  for (final doc in docs) {
    await doc.reference.delete();
  }
}

Future<bool> isAccountNotExist(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('Email', isEqualTo: email)
      .get();
  return querySnapshot.docs.isEmpty;
}

class DeleteAccount extends StatelessWidget {
  String User_mail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Delete Account"),
      ),
      backgroundColor: primaryColor,
      body: ListView(children: [
        // SizedBox(
        //   height: 200,
        // ),
        CustomImage(image: "deleteAccount", hight: 200),
        const SizedBox(height: 20),
        Column(
          children: const [
            Center(
              child: Text(
                "Please enter the email for user",
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
                "you want to delete",
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
          text: "Delete",
          onTap: () async {
            bool doesNotExist = await isAccountNotExist(User_mail);
            if (User_mail.isNotEmpty) {
              if (!doesNotExist) {
                await deleteAccountByEmail(User_mail);
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
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Error',
                  desc: 'Account not found',
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
                desc: 'Please, Enter Email',
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
