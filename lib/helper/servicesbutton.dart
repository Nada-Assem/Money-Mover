import 'import.dart';

class servicesButton extends StatelessWidget {
  servicesButton({required this.text, required this.image});
  String? text;
  String? image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        width: 120,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment(-1.491, 2.084),
            end: Alignment(2.122, -2.474),
            colors: <Color>[Color(0xff5d5ffc), Color(0xff47e975)],
            stops: <double>[0, 1],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Image.asset(
                image!,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              text!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 2,
                fontStyle: FontStyle.italic,
                color: Color(0xffffffff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
