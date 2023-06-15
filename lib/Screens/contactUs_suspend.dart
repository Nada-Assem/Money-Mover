import '../helper/import.dart';
import 'loginPage.dart';

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

// ···
final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'money.mover.customer.service@gmail.com',
  query: encodeQueryParameters(<String, String>{
    'subject': 'Money Mover Customer Service',
  }),
);
Future<void> _launchUrl() async {
  if (!await launchUrl(emailLaunchUri)) {
    throw Exception('Could not launch $emailLaunchUri');
  }
}

class Contact_Suspend extends StatelessWidget {
  const Contact_Suspend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: appBar(title: "Contact Us"),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          CustomImage(image: "contactus", hight: 300),
          //const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: txtStyle(
                text:
                    "Dear customer, we are here to help you, if your account has been suspended send your e-mail in the message",
                font: 16),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: txtStyle(
              text:
                  "To get in touch with us, click on the Contact Us button and send an email with your question",
              font: 14,
            ),
          ),
          const SizedBox(height: 20),
          button(text: 'Contact Us', onTap: _launchUrl),
          // ElevatedButton(
          //   onPressed: _launchUrl,
          //   child: txtStyle(text: "Contact Us", font: 18),
          // ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15),
            child: txtStyle(
              text:
                  'If you Sent your E-mail, Wait Until an Admin Activate your acount then Login Again',
              font: 14,
            ),
          ),
          const SizedBox(height: 10),
          button(
            text: 'Login Again',
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => login_page()),
                  (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
