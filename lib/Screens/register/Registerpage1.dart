import 'package:fingerprint/Screens/register/register2.dart';
import '../../helper/import.dart';
import 'package:intl/intl.dart';

// this class will be called, when their is change in textField
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

class RegisterPage1 extends StatefulWidget {
  static String? id = "registerPage";

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

bool isValidName(String name) {
  final nameRegExp = RegExp(r"^[A-Za-z\s'-]+$");
  return nameRegExp.hasMatch(name);
}

bool validatepassword(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool validateEgyptPhoneNumber(String phoneNumber) {
  const pattern = r'^(010|011|012|015)\d{8}$';
  final regExp = RegExp(pattern);
  return regExp.hasMatch(phoneNumber);
}

bool emailValid(String value) {
  String pattern =
      r"^[a-zA-Z][a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*@[a-zA-Z]+\.[a-zA-Z]+";
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

Future<bool> isAccountNotExist(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('Email', isEqualTo: email)
      .get();
  return querySnapshot.docs.isEmpty;
}

// final key = Key.fromUtf8('your encryption key');
// final iv = IV.fromUtf8('your initialization vector');
//////////////////////////////////////////////////////////////////////////////
//generate Random card number
Random random = new Random();
int firstDigit =
    random.nextInt(9) + 1; // generate a random integer between 1 and 9
int remainingDigits = (random.nextDouble() * 999999999999999)
    .toInt(); // generate a random integer between 0 and 9999999999999
String numString =
    '$firstDigit${remainingDigits.toString().padLeft(13, '0')}'; // combine the first digit and remaining digits
int cardnumber = int.parse(numString);

/////////////////////////////////////////////////////////////////////////////////////
class _RegisterPage1State extends State<RegisterPage1> {
  TextEditingController dateinput = TextEditingController();
  bool passwordVisible = true;
  String c_av_money = '',
      c_phone = '',
      c_name = '',
      c_id = '',
      c_email = '',
      c_date = '',
      c_address = '',
      c_Password = '',
      c_cardNumber = '';

  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
    passwordVisible = false;
  }

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Registration"),
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          CustomImage(image: "Register", hight: 300),
          const SizedBox(height: 20),
          CustomTextFormField(
            showtext: false,
            type: TextInputType.name,
            hintText: "Enter your Full Name here",
            labName: "Full Name",
            onChanged: (data) {
              c_name = data;
            },
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
              showtext: false,
              len: 14,
              type: const TextInputType.numberWithOptions(decimal: false),
              hintText: "Enter your National ID here",
              labName: "National ID",
              onChanged: (data) {
                c_id = data.toString();
              }),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
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
                fontSize: 16,
                color: Colors.white,
              ),
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterStyle: const TextStyle(color: Colors.blue),
                label: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Card Number",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14.5,
                    ),
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                hintText: "Enter your Card Number here",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
              showtext: false,
              len: 11,
              type: TextInputType.phone,
              hintText: "Enter your Phone Number here",
              labName: "Number",
              onChanged: (data) {
                c_phone = data.toString();
              }),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              controller: dateinput,
              //editing controller of this TextField
              decoration: InputDecoration(
                counterStyle: const TextStyle(color: Colors.blue),
                label: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Date of Birth",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                hintText: "Enter your Date of Birth here",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1800),
                    lastDate: DateTime(2024));

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate);
                  setState(() {
                    dateinput.text = formattedDate;
                    c_date = formattedDate.toString();
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
              showtext: false,
              type: TextInputType.streetAddress,
              hintText: "Enter your Address here",
              labName: "Address",
              onChanged: (data) {
                c_address = data;
              }),
          const SizedBox(height: 20),
          CustomTextFormField(
              showtext: false,
              type: TextInputType.number,
              hintText: "Enter your average monthly withdrawal here",
              labName: "Average Monthly Withdrawal",
              onChanged: (data) {
                c_av_money = data.toString();
              }),
          const SizedBox(height: 20),
          CustomTextFormField(
              showtext: false,
              type: TextInputType.emailAddress,
              hintText: "Enter your Email For Login",
              labName: "Email",
              onChanged: (data) {
                c_email = data;
              }),
          const SizedBox(height: 20),
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
              hintText: "Enter your Password For Login",
              labName: "Password",
              onChanged: (data) {
                c_Password = data;
              }),
          const SizedBox(height: 20),
          TextButton(
              onPressed: () async {
                print(c_cardNumber);
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return register2();
                // }));
                Map<String, dynamic> Data = {
                  'AV_money': int.parse(c_av_money),
                  'Address': c_address,
                  'Date': c_date,
                  'Email': c_email,
                  'ID': c_id,
                  'Name': c_name,
                  'Phone': c_phone,
                  'login_Password': c_Password,
                  'state': false,
                  'Money': 500,
                  'Card_Number': int.parse(c_cardNumber),
                  'number of operations': 0,
                  'spent money': 0,
                  'imageURL': ''
                };
                if (c_address.isEmpty ||
                    c_av_money.isEmpty ||
                    c_date.isEmpty ||
                    c_phone.isEmpty ||
                    c_email.isEmpty ||
                    c_id.isEmpty ||
                    c_name.isEmpty ||
                    c_address.isEmpty ||
                    c_Password.isEmpty ||
                    c_cardNumber.isEmpty) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Error',
                    desc: 'Please, Enter required data',
                    btnOkOnPress: () {},
                    btnOkColor: Colors.blue,
                  )..show();
                } else {
                  bool doesNotExist = await isAccountNotExist(c_email);
                  if (isValidName(c_name)) {
                    if (c_id.length == 14) {
                      if (validateEgyptPhoneNumber(c_phone)) {
                        if (emailValid(c_email)) {
                          if (validatepassword(c_Password)) {
                            if (doesNotExist) {
                              // FirebaseFirestore.instance.collection('User').add(
                              //     Data);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return register2(c_email, Data);
                              }));
                            } else {
                              //Account already exists
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.scale,
                                title: 'Error',
                                desc: 'Account already exists',
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
                              desc:
                                  'Please Choose A Strong Password Try A Mix Of Letters Numbers And Symbols',
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
                            desc: 'invalid mail',
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
                          desc: 'invalid phone number',
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
                        desc: 'invalid ID number',
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
                      desc: 'invalid name',
                      btnOkOnPress: () {},
                      btnOkColor: Colors.blue,
                    )..show();
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 290, bottom: 40),
                child: Text("Next", style: TextStyle(fontSize: 22)),
              ))
        ],
      ),
    );
  }
}
