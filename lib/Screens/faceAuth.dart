import 'package:fingerprint/Screens/passDeposite.dart';
import 'package:fingerprint/Screens/passDonation.dart';
import 'package:fingerprint/Screens/passWithdraw.dart';
import 'package:fingerprint/Screens/passpayment.dart';
import 'package:fingerprint/helper/import.dart';

import 'contactUs_suspend.dart';

int counter = 0;
String Rolee = "";

class FaceAuth extends StatelessWidget {
  FaceAuth(String role) {
    Rolee = role;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 90),
                  child: Text(
                    'Scan Your Face',
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
            CustomImage(image: "face-scanner", hight: 300),
            const SizedBox(
              height: 50,
            ),
            Positioned(
              bottom: 50,
              right: 120,
              child: Container(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                    maximumSize:
                        MaterialStateProperty.all<Size>(Size(200, 100)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  // onPressed: _authenticate,
                  onPressed: () async {
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
                        updateMoneyydonation(Department,
                            double.parse(donation_money.toString()));
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return const Done();
                        }));
                      }
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Authentication failed.'),
                        ),
                      );
                      counter++;
                      if (counter >= 3) {
                        counter = 0;
                        // ignore: avoid_single_cascade_in_expression_statements, use_build_context_synchronously

                        if (Rolee == 'deposit') {
                          suspend(User_Emailll);
                        } else if (Rolee == 'withdraw') {
                          suspend(User_Email);
                        } else if (Rolee == 'payment') {
                          suspend(User_Emaill);
                        } else if (Rolee == 'donation') {
                          suspenddd(donation_User_email);
                        }

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.scale,
                          title: 'Error',
                          desc:
                              'You have got all the chances, So your account has been suspended. You can contact us to solve this problem',
                          btnOkOnPress: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Contact_Suspend()),
                                (Route<dynamic> route) => false);
                          },
                          btnOkColor: Colors.blue,
                        )..show();
                      }
                    }
                  },
                  child: txtStyle(text: 'Scan', font: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
