import 'package:fingerprint/Screens/account.dart';
import 'package:fingerprint/Screens/passDeposite.dart';
import 'package:fingerprint/Screens/send.dart';
import '../helper/import.dart';
import 'check_otpforsecrtpass.dart';
import 'package:http/http.dart' as http;

final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('User');

Future<String> fetchUserData_name(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    //ssss=value['Money'];
    return value['Name'];
  }
  return 'nullll';
}

Future<String> fetchUserData_Card_Number(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    //ssss=value['Money'];
    return value['Card_Number'].toString();
  }
  return 'nullll';
}

Future<String> fetchUserData_money(String Email) async {
  final QuerySnapshot querySnapshot =
      await usersCollection.where('Email', isEqualTo: Email).get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    //ssss=value['Money'];
    return value['Money'].toString();
  }
  return 'nullll';
}

String userName = '', userCardNumber = '', userMoney = '';
Future<void> getUserData(String userEmail) async {
  userName = await fetchUserData_name(userEmail);
  userCardNumber = await fetchUserData_Card_Number(userEmail);
  userMoney = await fetchUserData_money(userEmail);

  // Do something with the fetched data
  // For example, print it to the console
  print('User Name: $userName');
  print('User Card Number: $userCardNumber');
  print('User Money: $userMoney');
}

Future<String?> getNameFromEmail(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('Email', isEqualTo: email)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    final QueryDocumentSnapshot documentSnapshot = querySnapshot.docs[0];
    final String name = documentSnapshot['Name'];
    return name;
  }
  return null; // Return null if email not found
}

Future<String?> getsecretmailFromEmail(String email) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('User')
      .where('Email', isEqualTo: email)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    final QueryDocumentSnapshot documentSnapshot = querySnapshot.docs[0];
    final String name = documentSnapshot['secret email'];
    return name;
  }
  return null; // Return null if email not found
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
  final response = await http.post(emailJSUri,
      headers: {'origin': 'http:localhost', 'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': 'service_jhfq3a2', // Replace with your EmailJS service ID
        'template_id':
            'template_5apk0kg', // Replace with your EmailJS template ID
        'user_id': 'qm0nHHKounwgGmyNA', // Replace with your EmailJS user ID
        'template_params': {
          'name': name,
          'subject': 'Forgot Operations password  - OTP Request',
          'user_email': email,
          'message': message,
        }
      }));
  return response.statusCode;
}

class Home extends StatelessWidget {
  String User_Email = '';
  Home(String mail) {
    User_Email = mail;
    getUserData(User_Email);
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: appBar(title: "Home"),
        backgroundColor: primaryColor,
        leading: const BackButton(color: Colors.white),
      ),
      endDrawer: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
        child: Drawer(
            backgroundColor: primaryColor,
            child: ListView(
              children: [
                Center(
                  child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: primaryColor,
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      // username & user email return from firebase(full name & email(login))
                      accountName: txtStyle(text: userName, font: 16),
                      accountEmail: txtStyle(text: User_Email, font: 16)),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return Account(
                              userName, userCardNumber, userMoney, User_Email);
                        },
                      ),
                    );
                  },
                  child: Card(
                    color: primaryColor,
                    child: ListTile(
                      title: txtStyle(text: "My Account", font: 18),
                      trailing: const Icon(
                        Icons.account_circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const questions();
                    }));
                  },
                  child: Card(
                    color: primaryColor,
                    child: ListTile(
                      title: txtStyle(text: "FAQ's", font: 18),
                      trailing: const Icon(
                        Icons.question_answer,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const contactUs();
                    }));
                  },
                  //20175110444570
                  child: Card(
                    color: primaryColor,
                    child: ListTile(
                      title: txtStyle(text: "Contact US", font: 18),
                      trailing: const Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String? name = userName;
                    String? secret_User_Email =
                        await getsecretmailFromEmail(User_Email);
                    print(name);
                    String OTP = generateOTP();
                    final statusCode =
                        await sendEmaill(secret_User_Email!, OTP, name);
                    print(OTP);
                    if (statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('OTP sended to email :$secret_User_Email')));
                      print('Email sent successfully');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) {
                          return checkotpforrestsecret(
                              User_Email, OTP, userName);
                        }),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to send OTP')));
                      print('Failed to send email. Status code: $statusCode');
                    }
                  },
                  //20175110444570
                  child: Card(
                    color: primaryColor,
                    child: ListTile(
                      title: txtStyle(text: "Reset Operation Pass", font: 18),
                      trailing: const Icon(
                        Icons.password,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // When the user logs out
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', false);

                    // Navigate back to the login screen
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => Page2()),
                        (Route<dynamic> route) => false);
                  },
                  child: Card(
                    color: primaryColor,
                    child: ListTile(
                      title: txtStyle(text: "Log Out", font: 18),
                      trailing: const Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          const SizedBox(height: 40),
          const logo(),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Text(
              'Services',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 1.5,
                fontStyle: FontStyle.italic,
                color: Color(0xffffffff),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return Withdraw(User_Email);
                        }));
                      },
                      child: servicesButton(
                          text: "Withdraw", image: "assets/image/Withdraw.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return Send(User_Email);
                        }));
                      },
                      child: servicesButton(
                          text: "Send", image: "assets/image/Send Money.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return payment(User_Email);
                        }));
                      },
                      child: servicesButton(
                          text: "Payment", image: "assets/image/Payment.png"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 65),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return Donations(User_Email);
                            },
                          ),
                        );
                      },
                      child: servicesButton(
                          text: "Donations",
                          image: "assets/image/donation.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return PassDeposite(User_Email);
                            },
                          ),
                        );
                      },
                      child: servicesButton(
                          text: "Deposit",
                          image: "assets/image/Deposit Money.png"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
