import '../helper/import.dart';
import 'fingerAuth.dart';

String User_Emaill = '';
int user_id = 0;
String type = '';
late int payment_duemoney;

class pas extends StatefulWidget {
  pas(String mail, int userid, String t) {
    User_Emaill = mail;
    user_id = userid;
    type = t;
  }

  @override
  State<pas> createState() => _pasState();
}

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

Future<void> updateAVG(String email, double AVG) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User');
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({"AV_money": AVG});
    print(' updated  AVG successfully for user with email $email');
  }
}

Future<String> number_of_operations(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return value['number of operations'].toString();
  }
  return '-1';
}

Future<String> spent_money(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return value['spent money'].toString();
  }
  return '-1';
}

Future<String> user_AV_money(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return value['AV_money'].toString();
  }
  return '-1';
}

final CollectionReference usersCollectionpayment =
    FirebaseFirestore.instance.collection('online payment');
Future<int> payment_due(int userid) async {
  final QuerySnapshot querySnapshot =
      await usersCollectionpayment.where('user id', isEqualTo: userid).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    //ssss=value['Money'];
    return value['payment due'];
  }
  return -1;
}

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

Future<void> updateMoneyy(String email, double newMoney) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({
      'Money': value['Money'] - newMoney,
      'spent money': value['spent money'] + newMoney,
      'number of operations': value['number of operations'] + 1
    });
    print(' updated successfully for user with email $email');
  }
}

Future<void> updatepayment(String userid, String type) async {
  final QuerySnapshot querySnapshot = await usersCollectionpayment
      .where('user id', isEqualTo: int.parse(userid))
      .where('type', isEqualTo: type)
      .get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollectionpayment.doc(value.id);
    await docRef.update({'payment due': 0});
  }
}

Future<void> suspend(String email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({'state': false});
    print(' suspend the account and send message to mail $email');
  }
}

class _pasState extends State<pas> {
  bool passwordVisible = true;
  String user_password = '';
  bool ok = true;

  int counter = 0;

  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(title: "Password"),
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          CustomImage(image: "reg2", hight: 300),
          Container(
            padding: const EdgeInsets.only(left: 40),
            child: txtStyle(text: "Enter your Password", font: 18),
          ),
          const SizedBox(height: 30),
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
              hintText: "Enter your Password here",
              labName: "Password",
              onChanged: (data) {
                user_password = data;
              }),
          const SizedBox(height: 50),
          button(
              text: "Continue",
              onTap: () async {
                print(user_password);
                payment_duemoney = await payment_due(user_id);
                print(payment_duemoney);
                print(await fetchUserData_Money(
                    User_Emaill, payment_duemoney.toString()));
                if (user_password.isNotEmpty) {
                  if (await fetchUserData_Password(
                      User_Emaill, user_password)) {
                    if (await fetchUserData_Money(
                        User_Emaill, payment_duemoney.toString())) {
                      String spentMoneyValue = await spent_money(User_Emaill);
                      String number_of_operationss =
                          await number_of_operations(User_Emaill);
                      String avmoeny = await user_AV_money(User_Emaill);
                      if (ok) {
                        if ((double.parse(number_of_operationss) < 8 &&
                                double.parse(avmoeny) < payment_duemoney) ||
                            ((double.parse(number_of_operationss) % 8 != 0 &&
                                double.parse(avmoeny) < payment_duemoney))) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'This is unusual for normal , so for more security, go to the second security level.')));
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return FingerAuth('payment');
                          }));
                        } else if (double.parse(number_of_operationss) % 8 ==
                                0 &&
                            double.parse(number_of_operationss) != 0) {
                          await updateAVG(
                              User_Emaill,
                              double.parse(spentMoneyValue) /
                                  double.parse(number_of_operationss));
                          await updateMoneyy(User_Emaill,
                              double.parse(payment_duemoney.toString()));
                          await updatepayment(user_id.toString(), type);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return Done();
                          }));
                          if ((double.parse(spentMoneyValue) /
                                  double.parse(number_of_operationss)) <
                              payment_duemoney) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'This is unusual for normal , so for more security, go to the second security level.')));

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return FingerAuth('payment');
                            }));
                          }
                        }
                        ok = false;
                      } else {
                        updateMoneyy(User_Emaill,
                            double.parse(payment_duemoney.toString()));
                        updatepayment(user_id.toString(), type);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return const Done();
                        }));
                      }
                    } else {
                      // ignore: avoid_single_cascade_in_expression_statements, use_build_context_synchronously
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
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Error',
                    desc: 'enter password',
                    btnOkOnPress: () {},
                    btnOkColor: Colors.blue,
                  )..show();
                }

                if (counter >= 3) {
                  counter = 0;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return FingerAuth('payment');
                  }));
                }
              }),
        ],
      ),
    );
  }
}
