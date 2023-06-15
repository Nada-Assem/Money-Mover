import '../helper/import.dart';

class questions extends StatelessWidget {
  const questions({super.key});

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.blue, width: 2),
    );
    const textStyle = TextStyle(fontSize: 16, color: Colors.white);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Questions"),
      ),
      body: ListView(
        children: [
          //Question 1
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text(
                    "1. What is the different from any other E-wallet application?",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "In this app, we provide a high level of secure with your fingerprint, face and password you generate.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          //Question 2
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text(
                    "2. Is my personal and financial information safe in my e-wallet?",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Yes, all your information is encrypted and stored in a secure place. ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          //Question 3
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text(
                    "3. Can I make transactions without an internet connection?",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "No, any transaction in this app needs to provide internet.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          //Question 4
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text(
                    "4. What happens if I lose my phone or device with my e-wallet app installed?",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "No one can do anything or access your info, as the app is locked and the only way to open is your fingerprint. Also, before complete any process it’s necessary to enter password.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          //Question 5
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text(
                    "5. What should I know before using the app?      ",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "You have only 3 times to enter your fingerprint, face, password. After that your account will be blocked.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          //Question 6
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text(
                    "6. What should I do if I had blocked?                  ",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "You must contact us to help you in the process of recovery the account.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          //Question 7
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text(
                    "7. Can I open my account on another mobile?  ",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Yes, you can contact us and send your serial number of your phone to allow you access your account from another phone.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          //Question 8
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text(
                    "8. How can I get my serial number of my phone?",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                        "The method for finding the serial number (also known as the IMEI) of your phone may vary depending on the operating system of your device.",
                        style: textStyle),
                  ),
                  SizedBox(height: 10),
                  Text(
                      "For Android devices:                                            ",
                      style: textStyle),
                  const SizedBox(height: 5),
                  Text("1-Open the 'Settings' app on your phone.",
                      style: textStyle),
                  Text("2- Scroll down and tap on About Phone  ",
                      style: textStyle),
                  Text(" or About Device                                    ",
                      style: textStyle),
                  Text("3- Look for IMEI or Serial Number and     ",
                      style: textStyle),
                  Text("tap on it to reveal the number          ",
                      style: textStyle),
                  SizedBox(height: 10),
                  Text(
                      "For iPhones:                                                                ",
                      style: textStyle),
                  const SizedBox(height: 5),
                  Text(
                    "1- Open the 'Settings' app on your             ",
                    style: textStyle,
                  ),
                  Text(
                    "phone.                                           ",
                    style: textStyle,
                  ),
                  Text(
                    "2- Tap on 'General'.                                           ",
                    style: textStyle,
                  ),
                  Text(
                    "3- Tap on 'About'.                                               ",
                    style: textStyle,
                  ),
                  Text(
                    "4- Look for 'IMEI' or 'Serial Number' and ",
                    style: textStyle,
                  ),
                  Text(
                    "tap on it to reveal the number.       ",
                    style: textStyle,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
