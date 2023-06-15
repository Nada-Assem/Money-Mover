import 'package:fingerprint/Screens/passWithdraw.dart';
import '../helper/import.dart';

class CreditCardNumberFormater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String enteredData = newValue.text; // get data enter by used in textField
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < enteredData.length; i++) {
      // add each character into String buffer
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 4 == 0 && enteredData.length != index) {
        // add space after 4th digit
        buffer.write(" ");
      }
    }

    return TextEditingValue(
        text: buffer.toString(), // final generated credit card number
        selection: TextSelection.collapsed(
            offset: buffer.toString().length) // keep the cursor at end
        );
  }
}

String c_cardNumber = "";

class Send extends StatelessWidget {
  String User_Email = '';

  Send(String mail) {
    User_Email = mail;
  }
  final TextEditingController _controller = TextEditingController();
  @override
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User');

  Future<bool> isCard_NumberExist(int Card_Number) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('Card_Number', isEqualTo: Card_Number)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> card_number_for_the_same_email(
      String Email, int Card_Number) async {
    final QuerySnapshot querySnapshot =
        await usersCollection.where('Email', isEqualTo: Email).get();
    final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
    for (var value in documentSnapshots) {
      return (value['Card_Number'] == Card_Number);
    }
    // return (value['Email'].toString() == Email) ;
    return false;
  }

  // Future<int> fetchUserData_Current_balance(String Email) async {
  late TextEditingController money_amount = TextEditingController(text: '');

  //late TextEditingController cardnum = TextEditingController(text: '0');

  Future<bool> fetchUserData_Money(String Email, String Money_Amount) async {
    final QuerySnapshot querySnapshot =
        await usersCollection.where('Email', isEqualTo: Email).get();
    final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
    for (var value in documentSnapshots) {
      return (value['Money'] >= double.parse(Money_Amount));
    }
    // return (value['Email'].toString() == Email) ;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Send Money"),
      ),
      backgroundColor: primaryColor,
      body: ListView(children: [
        const SizedBox(height: 15),
        CustomImage(image: "send", hight: 200),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
          child: txtStyle(text: "Send To", font: 18),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            onChanged: (data) {
              c_cardNumber = data;
              c_cardNumber = c_cardNumber.replaceAll(' ', '');
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CreditCardNumberFormater(),
            ],
            validator: (value) {
              if (value?.length != 19) {
                return 'Card Number consists of 16 number';
              }
              return null;
            },
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 14,
              ),
              hintText: 'Enter Card Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
          child: txtStyle(text: "Amount", font: 18),
        ),
        txtField(
          HintText: "Enter Amount of Money",
          Data: money_amount,
        ),
        const SizedBox(height: 50),
        button(
            text: "Send",
            onTap: () async {
              int Card_Number = int.parse(c_cardNumber);
              bool doesExist = await isCard_NumberExist(Card_Number);
              bool cardtosameemail =
                  await card_number_for_the_same_email(User_Email, Card_Number);
              print(doesExist);
              print(money_amount.text);
              print(User_Email);
              if (User_Email.isNotEmpty &&
                  money_amount.text.toString().isNotEmpty) {
                if (double.parse(money_amount.text.toString()) >= 1 &&
                    double.parse(money_amount.text.toString()) <= 6000) {
                  if (await fetchUserData_Money(
                      User_Email, money_amount.text.toString())) {
                    if (!cardtosameemail) {
                      if (doesExist) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) {
                            // not working and display admin page
                            return Pass(User_Email,
                                double.parse(money_amount.text), Card_Number);
                          }),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                                title: Text(
                                  "Error",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 25),
                                ),
                                content: Text("Card Number not Exist"));
                          },
                        );
                      }
                    } else {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                              title: Text(
                                "Error",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 25),
                              ),
                              content:
                                  Text("cant sent money to this Card Number"));
                        },
                      );
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                            title: Text(
                              "Error",
                              style: TextStyle(color: Colors.red, fontSize: 25),
                            ),
                            content: Text("not enough"));
                      },
                    );
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
              } else {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Error',
                  desc: 'Please, Enter required data',
                  btnOkOnPress: () {},
                  btnOkColor: Colors.blue,
                )..show();
              }
            }),
      ]),
    );
  }
}
