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

class Unlock extends StatelessWidget {
  String User_Email = '';

  Unlock(String mail) {
    User_Email = mail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/image/fing.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 50,
            right: 120,
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
                  bool isAuthenticated = await AuthService.authenticateUser();
                  if (isAuthenticated) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => Home(User_Email)),
                        (Route<dynamic> route) => false);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Authentication failed.'),
                      ),
                    );
                  }
                  //...
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
