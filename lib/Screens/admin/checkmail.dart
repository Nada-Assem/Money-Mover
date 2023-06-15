import 'package:fingerprint/helper/import.dart';

Future<bool> isAccountNotExist(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('Email', isEqualTo: email)
      .get();
  return querySnapshot.docs.isEmpty;
}

Future<String> fetchUserData_url(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return value['imageURL'];
  }
  return 'nullll';
}

Future<String> fetchUserData_userID(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return value['ID'];
  }
  return 'nullll';
}

class checkmail extends StatelessWidget {
  String User_mail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Control User"),
      ),
      backgroundColor: primaryColor,
      body: ListView(children: [
        CustomImage(image: "check", hight: 200),
        const SizedBox(height: 20),
        Column(
          children: const [
            Center(
              child: Text(
                "Enter the email for user",
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
                "to approve or reject",
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
          text: "Check E-mail",
          onTap: () async {
            bool Exist = await isAccountNotExist(User_mail);
            if (User_mail.isNotEmpty) {
              if (!Exist) {
                String url = await fetchUserData_url(User_mail);
                String user_Id = await fetchUserData_userID(User_mail);
                print(user_Id);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                  return check(User_mail, url, user_Id);
                }));
              } else {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Error',
                  desc: 'account Not Exist',
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
                desc: 'Enter Email',
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
