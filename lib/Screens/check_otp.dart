import 'dart:async';

import 'package:fingerprint/helper/import.dart';
import 'newpass.dart';
import 'package:http/http.dart' as http;

String User_mail = "", OTP = "", Role = "";

class checkotp extends StatefulWidget {
  checkotp(String usermail, String otp, String role) {
    User_mail = usermail;
    OTP = otp;
    Role = role;
  }

  @override
  State<checkotp> createState() => _checkotpState();
}

String generateOTP() {
  Random random = Random();
  String OTP = '';

  for (int i = 0; i < 6; i++) {
    OTP += random.nextInt(10).toString();
  }

  return OTP;
}

Future<String?> getNameFromEmail(String email, String role) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(role)
      .where('Email', isEqualTo: email)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final QueryDocumentSnapshot documentSnapshot = querySnapshot.docs[0];
    final String name = documentSnapshot['Name'];
    return name;
  }

  return null; // Return null if email not found
}

Future sendEmaill(String email, String message, String name) async {
  final Uri emailJSUri =
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  if (Role == 'Admin') email = 'money.mover.customer.service@gmail.com';
  final response = await http.post(emailJSUri,
      headers: {'origin': 'http:localhost', 'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': 'service_jhfq3a2', // Replace with your EmailJS service ID
        'template_id':
            'template_5apk0kg', // Replace with your EmailJS template ID
        'user_id': 'qm0nHHKounwgGmyNA', // Replace with your EmailJS user ID
        'template_params': {
          'name': name,
          'subject': 'Forgot Password - OTP Request',
          'user_email': email,
          'message': message,
        }
      }));
  return response.statusCode;
}

class _checkotpState extends State<checkotp> {
  String otp = '';
  bool isInputEnabled = true;
  int timerDuration = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timerDuration == 0) {
        setState(() {
          isInputEnabled = false;
        });
        timer.cancel();
      } else {
        setState(() {
          timerDuration--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Check OTP"),
      ),
      backgroundColor: primaryColor,
      body: ListView(children: [
        CustomImage(image: "o", hight: 280),
        const Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "Check your E-mail and type the OTP you received",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Timer :  ",
              style: TextStyle(
                fontSize: 25,
                color: Colors.teal,
              ),
            ),
            Text(
              timerDuration.toString(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          showtext: false,
          len: 6,
          type: TextInputType.emailAddress,
          hintText: "OTP",
          onChanged: (data) {
            otp = data;
          },
          labName: "OTP",
          enabled: isInputEnabled,
        ),
        const SizedBox(height: 30),
        button(
          text: "Check",
          onTap: () async {
            if (otp.isNotEmpty) {
              if (otp == OTP) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return newpass(User_mail, Role);
                }));
              } else {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Error',
                  desc: 'Invalid OTP',
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
                desc: 'Enter OTP',
                btnOkOnPress: () {},
                btnOkColor: Colors.blue,
              )..show();
            }
          },
        ),
        SizedBox(height: 20),
        Center(
          child: button(
              text: "Resend",
              onTap: () async {
                print('aa');
                String? name = '';
                if (Role != 'Admin')
                  name = await getNameFromEmail(User_mail, Role);
                else
                  name = 'Admin';
                OTP = generateOTP();
                final statusCode = await sendEmaill(User_mail, OTP, name!);
                print(OTP);
                setState(() {
                  isInputEnabled = true;
                  timerDuration = 60;
                });

                startTimer();

                if (statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('OTP sended to email :$User_mail')));
                  print('OTP sent successfully');
                } else {
                  print('Failed to send OTP.');
                }
              }),
        ),
      ]),
    );
  }
}
