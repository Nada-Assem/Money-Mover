import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'Screens/loginPage.dart';
import 'helper/import.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Program());
}

Future<bool> checkIfLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

class Program extends StatelessWidget {
  // This widget is the root of your application.
  FirebaseAuth firebase_Auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '/Home()',
      routes: {
        // '/Home()': (context) => Home('ahmed@gmail.com'),
        Page2.id!: (context) => Page2(),
        login_page.id!: (context) => login_page(),
        RegisterPage1.id!: (context) => RegisterPage1(),
        // register2.id!: (context) => register2("ahmed",),
        AdminPage.id!: (context) => AdminPage(),
      },
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Page2()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              "assets/image/log.png",
              //height: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            if (defaultTargetPlatform == TargetPlatform.android)
              const CupertinoActivityIndicator(
                color: Colors.black,
                radius: 20,
              )
            else
              const CircularProgressIndicator(
                color: Colors.black,
              )
          ],
        ),
      ),
    );
  }
}
