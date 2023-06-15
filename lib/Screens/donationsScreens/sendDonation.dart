import 'package:fingerprint/helper/import.dart';
import '../passDonation.dart';

class send_D extends StatelessWidget {
  send_D({required this.App_text, required this.User_Email});

  String? App_text;
  String User_Email = '', money_amount = '';
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User');

  Future<bool> fetchUserData_Money(String Email, String Money_Amount) async {
    final QuerySnapshot querySnapshot =
        await usersCollection.where('Email', isEqualTo: Email).get();
    final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
    for (var value in documentSnapshots) {
      //ssss=value['Money'];
      return (value['Money'] >= double.parse(Money_Amount) &&
          double.parse(Money_Amount) > 0);
    }
    // return (value['Email'].toString() == Email) ;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          App_text!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 100),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Amount",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              onChanged: (data) {
                money_amount = data;
              },
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text(
                  "Amount",
                  style: TextStyle(fontSize: 18),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                hintText: "Add amount range from 10 to 6000 LE",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xff369be9),
                )),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 70),
          button(
            //color: const Color(0xff369beb),
            text: "Submit",
            onTap: () async {
              if (money_amount.isNotEmpty) {
                if (await fetchUserData_Money(User_Email, money_amount)) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) {
                      // not working and display admin page
                      return donation_pas(
                          User_Email, double.parse(money_amount), App_text!);
                    }),
                  );
                } else {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Error',
                    desc: 'not enough',
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
                  desc: 'Please, Enter Amount Of Money',
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
