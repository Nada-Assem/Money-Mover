import 'package:fingerprint/Screens/check_otp.dart';
import 'package:fingerprint/helper/import.dart';
import 'package:http/http.dart' as http;

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

Future<bool> isAccountNotExist(String email, String role) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(role)
      .where('Email', isEqualTo: email)
      .get();
  return querySnapshot.docs.isEmpty;
}

String generateOTP() {
  Random random = Random();
  String otp = '';

  for (int i = 0; i < 6; i++) {
    otp += random.nextInt(10).toString();
  }

  return otp;
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

String Role = "";

class ForgetPass extends StatefulWidget {
  ForgetPass(String role) {
    Role = role;
  }

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  String User_Email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Reset Password"),
      ),
      backgroundColor: primaryColor,
      body: ListView(children: [
        CustomImage(image: "forgot-password", hight: 300),
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            "Enter your Email to Reset your Password",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 40),
        CustomTextFormField(
          showtext: false,
          type: TextInputType.emailAddress,
          hintText: "Enter Email",
          onChanged: (data) {
            User_Email = data;
          },
          labName: "Email",
        ),
        const SizedBox(height: 70),
        GestureDetector(
          onTap: () async {
            String? name = '';
            if (Role != 'Admin')
              name = await getNameFromEmail(User_Email, Role);
            else
              name = 'Admin';
            print(name);
            bool doesNotExist = await isAccountNotExist(User_Email, Role);
            if (!doesNotExist) {


              String OTP = generateOTP();
              final statusCode = await sendEmaill(User_Email, OTP, name!);
              // addOTPToEmail(User_Email,OTP);
              print(OTP);
              if (statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('OTP sended to email :$User_Email')));
                print('Email sent successfully');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return checkotp(User_Email, OTP, Role);
                  }),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to send OTP.')));
                print('Failed to send OTP. ');
              }

            } else {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: 'Error',
                desc: 'Account not exist',
                btnOkOnPress: () {},
                btnOkColor: Colors.blue,
              )..show();
            }
            print('innnnnnn');
          },
          child: Center(
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
