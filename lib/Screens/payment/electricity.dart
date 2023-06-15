import '../../helper/import.dart';
import '../passpayment.dart';

String User_Email = '';

class Electricity extends StatefulWidget {
  Electricity(String mail) {
    User_Email = mail;
  }

  @override
  State<Electricity> createState() => _ElectricityState();
}

final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('online payment');
Future<bool> checkUserIdExist(String company, String userid) async {
  final QuerySnapshot querySnapshot = await usersCollection
      .where('user id', isEqualTo: int.parse(userid))
      .where('type', isEqualTo: 'Electricity')
      .get();
  final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
  for (var value in documentSnapshots) {
    return (value['Company'] == company);
  }
  // return (value['Email'].toString() == Email) ;
  return false;
}

////////////////////////////////
late TextEditingController User_id = TextEditingController(text: '');

class _ElectricityState extends State<Electricity> {
  List<String> itemslist = [
    "North Cairo Electricity Bill",
    "South Cairo Electricity Bill",
    "Canal Electricity Bill",
    "Alexandrio Electricity Bill",
    "North Delta Electricity Bill",
    "South Delta Electricity Bill",
    "Middle Egypt Bill",
    "Upper Egypt Bill",
    "El Beheira Electricity",
    "Electricity Smart Meters",
  ];

  String? selectitem = "North Cairo Electricity Bill";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: appBar(title: "Electricity"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 120),
            child: txtStyle(text: "Electricity Company", font: 22),
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
                      return pas(User_Email, int.parse(userid), 'Electricity');
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
