import '../helper/import.dart';
import 'fingerAuth.dart';

String donation_User_email = '';
double donation_money = 0;
String Department = '';

class donation_pas extends StatefulWidget {
  donation_pas(String mail, double money, String t) {
    donation_User_email = mail;
    donation_money = money;
    Department = t;
  }
  @override
  State<donation_pas> createState() => _donation_pasState();
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

Future<void> updateMoneyDonation(String email, double newMoney) async {
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

final CollectionReference usersCollectionCharity =
    FirebaseFirestore.instance.collection('Charity_foundations');
Future<void> updateMoneyydonation(String depart, double newMoney) async {
  final QuerySnapshot querySnapshot =
      await usersCollectionCharity.where('Department', isEqualTo: depart).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollectionCharity.doc(value.id);
    await docRef.update({
      'money': value['money'] + newMoney,
    });
    print(' updated successfully for donation with Department $depart');
  }
}

Future<void> suspenddd(String email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({'state': false});
    print(' suspend the account and send message to mail $email');
  }
}

class _donation_pasState extends State<donation_pas> {
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
              text: "Continue",
              onTap: () async {
                print(user_password);
                if (user_password.isNotEmpty) {
                  if (await fetchUserData_Password(
                      donation_User_email, user_password)) {
                    if (await fetchUserData_Money(
                        donation_User_email, donation_money.toString())) {
                      String spentMoneyValue =
                          await spent_money(donation_User_email);
                      String number_of_operationss =
                          await number_of_operations(donation_User_email);
                      String avmoeny = await user_AV_money(donation_User_email);
                      if (ok) {
                        if ((double.parse(number_of_operationss) < 8 &&
                                double.parse(avmoeny) < donation_money) ||
                            ((double.parse(number_of_operationss) % 8 != 0 &&
                                double.parse(avmoeny) < donation_money))) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'This is unusual for normal , so for more security, go to the second security level.')));
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return FingerAuth('donation');
                          }));
                        } else if (double.parse(number_of_operationss) % 8 ==
                                0 &&
                            double.parse(number_of_operationss) != 0) {
                          await updateAVG(
                              donation_User_email,
                              double.parse(spentMoneyValue) /
                                  double.parse(number_of_operationss));

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return Done();
                          }));
                          if ((double.parse(spentMoneyValue) /
                                  double.parse(number_of_operationss)) <
                              donation_money) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'This is unusual for normal , so for more security, go to the second security level.')));

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return FingerAuth('donation');
                            }));
                          }
                        }
                        ok = false;
                      } else {
                        updateMoneyDonation(donation_User_email,
                            double.parse(donation_money.toString()));
                        updateMoneyydonation(Department,
                            double.parse(donation_money.toString()));
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
                    return FingerAuth('donation');
                  }));
                }
              }),
        ],
      ),
    );
  }
}
