import '../helper/import.dart';

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

class contactUs extends StatelessWidget {
  const contactUs({super.key});

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
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15),
            child: txtStyle(
                text:
                    "Dear customer, we are here to help you if you have any problem and neet to contact with us",
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
          Padding(
              padding: const EdgeInsets.only(right: 60),
              child: txtStyle(
                  text: "Inquiries are answered within 24 hours", font: 14)),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _launchUrl,
            child: txtStyle(text: "Contact Us", font: 18),
          ),
        ],
      ),
    );
  }
}
