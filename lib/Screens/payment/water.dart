import '../../helper/import.dart';
import '../passpayment.dart';

String User_Email = '';

class Water extends StatefulWidget {
  Water(String mail) {
    User_Email = mail;
  }

  @override
  State<Water> createState() => _WaterState();
}

final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('online payment');
Future<bool> checkUserIdExist(String company, String userid) async {
  final QuerySnapshot querySnapshot = await usersCollection
      .where('user id', isEqualTo: int.parse(userid))
      .where('type', isEqualTo: 'Water')
      .get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return (value['Company'] == company);
  }
  return false;
}

late TextEditingController User_id = TextEditingController(text: '');

class _WaterState extends State<Water> {
  List<String> itemslist = [
    "Qalyubia Water Bill",
    "General Authority Water Bill",
    "Fayoum Water Bill",
    "Dakahlia  Water Bill",
    "North Cairo Water Bill",
    "Alexandria Water Bill",
  ];

  String? selectitem = "Qalyubia Water Bill";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Water"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 170),
            child: txtStyle(text: "Water Company", font: 22),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 380,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 3,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 3,
                        ))),
                dropdownColor: primaryColor,
                iconEnabledColor: Colors.white,
                value: selectitem,
                items: itemslist
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            (item),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))
                    .toList(),
                onChanged: (item) => setState(() {
                  selectitem = item;
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 290, bottom: 20),
            child: txtStyle(text: "User ID", font: 22),
          ),
          txtField(
            HintText: "User Id",
            Data: User_id,
          ),
          const SizedBox(height: 30),
          button(
              text: "Submit",
              onTap: () async {
                String userid = User_id.text.toString();
                if (userid.isNotEmpty) {
                  if (await checkUserIdExist(selectitem!, userid)) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                      // not working and display admin page
                      return pas(User_Email, int.parse(userid), 'Water');
                    }));
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.scale,
                      title: 'Error',
                      desc: 'user ID not Exist',
                      btnOkOnPress: () {},
                      btnOkColor: Colors.blue,
                    )..show();
                  }
                } else {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Error',
                    desc: 'Please, Enter user ID',
                    btnOkOnPress: () {},
                    btnOkColor: Colors.blue,
                  )..show();
                }
              })
        ],
      ),
    );
  }
}
