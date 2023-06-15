import 'package:fingerprint/Screens/passWithdraw.dart';
import '../helper/import.dart';

class Withdraw extends StatelessWidget {
  @override
  String User_Email = '';

  Withdraw(String mail) {
    User_Email = mail;
  }

  double ssss = 0;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User');

  Future<bool> fetchUserData_Money(String Email, String Money_Amount) async {
    final QuerySnapshot querySnapshot =
        await usersCollection.where('Email', isEqualTo: Email).get();
    final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
    for (var value in documentSnapshots) {
      //ssss=value['Money'];
      return (value['Money'] >= double.parse(Money_Amount));
    }
    // return (value['Email'].toString() == Email) ;
    return false;
  }

  late TextEditingController money_amount = TextEditingController(text: '');

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(
          title: "Withdraw",
        ),
      ),
      body: ListView(
        children: [
          CustomImage(image: "withdraw", hight: 300),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: txtStyle(
                text: "Enter the amount you want to withdraw", font: 16),
          ),
          const SizedBox(height: 30),
          txtField(
            HintText: "Amount Of Money",
            Data: money_amount,
          ),
          const SizedBox(height: 50),
          button(
            text: "Submit",
            onTap: () async {
              print(money_amount.text);
              if (money_amount.text.toString().isNotEmpty &&
                  double.parse(money_amount.text.toString()) >= 1 &&
                  double.parse(money_amount.text.toString()) <= 6000) {
                if (await fetchUserData_Money(
                    User_Email, money_amount.text.toString())) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return Pass(
                          User_Email, double.parse(money_amount.text), -1);
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
                  desc: 'Please, Enter Amount Of Money[1-6000]',
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
