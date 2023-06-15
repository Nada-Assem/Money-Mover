import 'package:fingerprint/helper/import.dart';

Future<void> active_account(String email) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User');
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({"state": true});
    print(' updated successfully for user with email $email');
  }
}

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

String user_mail = "", user_url = "", user_ID = "";

class check extends StatelessWidget {
  check(String mail, String url, String userID) {
    user_mail = mail;
    user_url = url;
    user_ID = userID;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Check ID"),
      ),
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.network(
              user_url, // Replace with your image URL
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              children: [
                const Text(
                  'User ID:- ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user_ID,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          button(
            text: 'Approve',
            onTap: () {
              active_account(user_mail);
              print('active');
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('account activated: $user_mail')));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) {
                  return const Done();
                }),
              );
            },
          ),
          const SizedBox(height: 20),
          button(
            text: 'Reject',
            onTap: () {
              deleteAccountByEmail(user_mail);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('account deleted: $user_mail')));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) {
                  return const Done();
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
