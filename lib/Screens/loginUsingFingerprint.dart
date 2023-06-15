import '../helper/import.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LocalAuthentication auth = LocalAuthentication();
  late bool canCheckBiometric;
  late List<BiometricType> availableBiometric;
  String autherized = "Not autherized";

  //////Check
  Future<void> checkBiometric() async {
    late bool canCheck;
    try {
      canCheck = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      canCheckBiometric = canCheck;
    });
  }

  //this function will get all the available biometrics inside our device
  //it will return a list of objects, but for our example it will only
  //return the fingerprint biometric
  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> available;
    try {
      available = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      availableBiometric = available;
    });
  }

  //this function will open an authentication dialog
  // and it will check if we are authenticated or not
  // so we will add the major action here like moving to another activity
  // or just display a text that will tell us that we are authenticated
  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger print to authenticate",
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      autherized =
          authenticated ? "Autherized success" : "Failed to authenticate";
      if (authenticated) {
        authenticate();
      } else {
        defaultToast(text: "Please scan your finger", color: Colors.red);
        // toast("Please scan your finger", Colors.red);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    checkBiometric();
    getAvailableBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.fingerprint, size: 16),
              SizedBox(height: 5),
              const Text(
                "login",
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 2,
              ),
              const Text("titleLogin",
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              const Text(
                "subTitleLogin",
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 8,
              ),
              button(
                text: "authButton",
                onTap: () {
                  authenticate();
                },
              ),
              const SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}
