import 'package:http/http.dart' as http;
import 'package:fingerprint/helper/import.dart';

String User_mail = "";

class ImageUploadScreen extends StatefulWidget {
  ImageUploadScreen(String mail) {
    User_mail = mail;
  }
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('User');

  Future<void> _selectImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future sendEmaill(String email) async {
    final Uri emailJSUri =
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(emailJSUri,
        headers: {
          'origin': 'http:localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'service_id':
              'service_jhfq3a2', // Replace with your EmailJS service ID
          'template_id':
              'template_zcnfggd', // Replace with your EmailJS template ID
          'user_id': 'qm0nHHKounwgGmyNA', // Replace with your EmailJS user ID
          'template_params': {
            'message': email,
          }
        }));
    return response.statusCode;
  }

  Future<void> _uploadImage(String email) async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Select image')));
      return;
    }

    final Reference storageRef = FirebaseStorage.instance.ref().child(
        'images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg');

    await storageRef.putFile(_imageFile!);
    final String downloadURL = await storageRef.getDownloadURL();

    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await getUserStream(email).first;

      await userDoc.reference.update({'imageURL': downloadURL});
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Image uploaded and URL saved in Firestore for user: $email')));
      sendEmaill(User_mail);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const doneReg();
      }));
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String email) {
    return FirebaseFirestore.instance
        .collection('User')
        .where('Email', isEqualTo: email)
        .limit(1)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first;
      } else {
        throw Exception('User document not found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(title: "Upload ID Card"),
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 200,
                  )
                : const Icon(
                    Icons.image,
                    size: 100,
                  ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _selectImage,
              child: Center(
                child: Container(
                  height: 70,
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        txtStyle(text: 'Select Your', font: 18),
                        txtStyle(
                          text: 'National ID Card',
                          font: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            button(
              text: 'Upload',
              onTap: () {
                final String email =
                    User_mail; // Replace with the specific email you want to check against
                _uploadImage(email);
              },
            )
          ],
        ),
      ),
    );
  }
}
