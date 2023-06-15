//Magdi Yacoub-Mecical Equiment
import 'package:fingerprint/helper/import.dart';
import '../passDonation.dart';

String money_amount = '';

const List<String> list = <String>[
  'Mecical Equiment 300 EGP',
  'Mecical Equiment 600 EGP',
  'Mecical Equiment 800 EGP',
  'Mecical Equiment 1200 EGP',
  'Mecical Equiment 1500 EGP',
];

class MecicalEquiment extends StatelessWidget {
  String User_Email = '';
  String depart = "";
  MecicalEquiment(String mail, String part) {
    User_Email = mail;
    depart = part;
  }

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User');

  Future<bool> fetchUserData_Money(String Email, String Money_Amount) async {
    final QuerySnapshot querySnapshot =
        await usersCollection.where('Email', isEqualTo: Email).get();
    final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;
    for (var value in documentSnapshots) {
      //ssss=value['Money'];
      return (value['Money'] >= double.parse(Money_Amount));
    }
    // return (value['Email'].toString() == Email) ;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          'Mecical Equiment',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: 50, width: 300, child: const DropdownButtonExample()),
          button(
            text: "Submit",
            onTap: () async {
              if (money_amount.isNotEmpty) {
                if (await fetchUserData_Money(User_Email, money_amount)) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) {
                      // not working and display admin page
                      return donation_pas(
                          User_Email, double.parse(money_amount), depart);
                    }),
                  );
                } else {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Error',
                    desc: 'not enough',
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
                  desc: 'Please, Select Amount Of Money',
                  btnOkOnPress: () {},
                  btnOkColor: Colors.blue,
                )..show();
              }
            },
          ),
        ],
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: primaryColor,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      //elevation: 50,

      isExpanded: true,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      underline: Container(
        height: 2,
        color: Colors.red,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          if (dropdownValue.contains(300.toString()))
            money_amount = '300';
          else if (dropdownValue.contains(600.toString()))
            money_amount = '600';
          else if (dropdownValue.contains(800.toString()))
            money_amount = '800';
          else if (dropdownValue.contains(1200.toString()))
            money_amount = '1200';
          else if (dropdownValue.contains(1500.toString()))
            money_amount = '1500';
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
