import '../helper/import.dart';
import 'fingerAuth.dart';

String User_Email = '';
double moneyy = 0;
int Card_Number = 0;

final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('User');

Future<void> updateMoneytocardnumber(int card_number, double newMoney) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Card_Number', isEqualTo: card_number).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    final DocumentReference docRef = usersCollection.doc(value.id);
    await docRef.update({'Money': value['Money'] + newMoney});
    print(' updated successfully for user with card_number $card_number');
  }
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

Future<void> updateMoney(String email, double newMoney) async {
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

class Pass extends StatefulWidget {
  Pass(String mail, double money, int card_number) {
    User_Email = mail;
    moneyy = money;
    Card_Number = card_number;
  }

  @override
  State<Pass> createState() => _PassState();
}

class _PassState extends State<Pass> {
  bool passwordVisible = true;
  bool ok = true;
  String user_password = '';

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
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(left: 40),
            child: txtStyle(text: "Enter your Password", font: 17),
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
          const SizedBox(height: 60),
          button(
              text: "Continue",
              onTap: () async {
                print(user_password);
                if (user_password.isNotEmpty) {
                  if (Card_Number == -1) //whithdraw
                  {
                    if (await fetchUserData_Password(
                        User_Email, user_password)) {
                      String spentMoneyValue = await spent_money(User_Email);
                      String number_of_operationss =
                          await number_of_operations(User_Email);
                      String avmoeny = await user_AV_money(User_Email);
                      //number_of_operationss<8 &&avg<mony || number_of_operationss%8==0 &&(spentMoneyValue/number_of_operationss)
                      if (ok) {
                        if ((double.parse(number_of_operationss) < 8 &&
                                double.parse(avmoeny) < moneyy) ||
                            ((double.parse(number_of_operationss) % 8 != 0 &&
                                double.parse(avmoeny) < moneyy))) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'This is unusual for normal , so for more security, go to the second security level.')));
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return FingerAuth('withdraw');
                          }));
                        } else if (double.parse(number_of_operationss) % 8 ==
                                0 &&
                            double.parse(number_of_operationss) != 0) {
                          await updateAVG(
                              User_Email,
                              double.parse(spentMoneyValue) /
                                  double.parse(number_of_operationss));
                          await updateMoney(User_Email, moneyy);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return Done();
                          }));
                          if ((double.parse(spentMoneyValue) /
                                  double.parse(number_of_operationss)) <
                              moneyy) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'This is unusual for normal , so for more security, go to the second security level.')));

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return FingerAuth('withdraw');
                            }));
                          }
                        }
                        ok = false;
                      } else {
                        updateMoney(User_Email, moneyy);

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return Done();
                        }));
                      }
                    } else {
                      counter++;
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
                    if (await fetchUserData_Password(
                        User_Email, user_password)) {
                      String spentMoneyValue = await spent_money(User_Email);
                      String number_of_operationss =
                          await number_of_operations(User_Email);
                      String avmoeny = await user_AV_money(User_Email);
                      //number_of_operationss<8 &&avg<mony || number_of_operationss%8==0 &&(spentMoneyValue/number_of_operationss)
                      if (ok) {
                        if ((double.parse(number_of_operationss) < 8 &&
                                double.parse(avmoeny) < moneyy) ||
                            ((double.parse(number_of_operationss) % 8 != 0 &&
                                double.parse(avmoeny) < moneyy))) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'This is unusual for normal , so for more security, go to the second security level.')));
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return FingerAuth('withdraw');
                          }));
                        } else if (double.parse(number_of_operationss) % 8 ==
                                0 &&
                            double.parse(number_of_operationss) != 0) {
                          await updateAVG(
                              User_Email,
                              double.parse(spentMoneyValue) /
                                  double.parse(number_of_operationss));
                          await updateMoneytocardnumber(Card_Number, moneyy);
                          await updateMoney(User_Email, moneyy);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return Done();
                          }));
                          if ((double.parse(spentMoneyValue) /
                                  double.parse(number_of_operationss)) <
                              moneyy) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'This is unusual for normal , so for more security, go to the second security level.')));

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return FingerAuth('withdraw');
                            }));
                          }
                        }
                        ok = false;
                      }
                      await updateMoneytocardnumber(Card_Number, moneyy);
                      await updateMoney(User_Email, moneyy);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return Done();
                      }));
                    } else {
                      counter++;
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
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Error',
                    desc: 'suspend the account and send message to mail',
                    btnOkOnPress: () {},
                    btnOkColor: Colors.blue,
                  )..show();
                  counter = 0;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return FingerAuth('withdraw');
                  }));
                }
              }),
        ],
      ),
    );
  }
}
