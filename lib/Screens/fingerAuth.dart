import 'package:fingerprint/Screens/passDonation.dart';
import 'package:fingerprint/Screens/passWithdraw.dart';
import 'package:fingerprint/Screens/passpayment.dart';
import 'package:fingerprint/helper/import.dart';

class AuthService {
  static Future<bool> authenticateUser() async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    bool isAuthenticated = false;
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(
              biometricOnly: true, useErrorDialogs: true, stickyAuth: true
              //sensitiveTransaction:
              ),
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return isAuthenticated;
  }
}

int counter = 0;
String Rolee = '';

class FingerAuth extends StatelessWidget {
  FingerAuth(String role) {
    Rolee = role;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 90, left: 1),
                child: Text(
                  'Enter Your FingerPrint',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'To Authenticate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Center(child: CustomImage(image: "fingerprint-scanner", hight: 300)),
          const SizedBox(
            height: 50,
          ),
          Positioned(
            bottom: 50,
            right: 150,
            child: Container(
              height: 50,
              width: 150,
              child: ElevatedButton(
                style: ButtonStyle(
                  maximumSize: MaterialStateProperty.all<Size>(Size(200, 100)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                // onPressed: _authenticate,
                onPressed: () async {
                  print(Rolee);
                  bool isAuthenticated = await AuthService.authenticateUser();
                  if (isAuthenticated) {
                    // ignore: use_build_context_synchronously

                    if (Rolee == 'deposit') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => OTP()),
                      );
                    } else if (Rolee == 'withdraw') {
                      if (Card_Number == -1) //whithdraw
                      {
                        updateMoney(User_Email, moneyy);
                      } else {
                        updateMoneytocardnumber(Card_Number, moneyy);
                        updateMoney(User_Email, moneyy);
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Done()),
                      );
                    } else if (Rolee == 'payment') {
                      updateMoneyy(User_Emaill,
                          double.parse(payment_duemoney.toString()));
                      updatepayment(user_id.toString(), type);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Done()),
                      );
                    } else if (Rolee == 'donation') {
                      updateMoneyDonation(donation_User_email,
                          double.parse(donation_money.toString()));
                      updateMoneyydonation(
                          Department, double.parse(donation_money.toString()));
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return const Done();
                      }));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Authentication failed.'),
                      ),
                    );
                    counter++;
                    if (counter >= 3) {
                      counter = 0;
                      // ignore: use_build_context_synchronously, avoid_single_cascade_in_expression_statements
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        title: 'Error',
                        desc:
                            'You have entered the FingerPrint wrong for 3 times, For more secure get the third level of security',
                        btnOkOnPress: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return FaceAuth(Rolee);
                          }));
                        },
                        btnOkColor: Colors.blue,
                      )..show();
                    }
                  }
                },
                child: txtStyle(text: 'Enter', font: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
