import 'import.dart';

class logo extends StatelessWidget {
  const logo({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(18 * fem),
      gradient: const LinearGradient(
        begin: Alignment(-1.491, 2.084),
        end: Alignment(2.122, -2.474),
        colors: <Color>[Color(0xff5d5ffc), Color(0xff47e975)],
        stops: <double>[0, 1],
      ),
    );
    var textStyle = TextStyle(
      fontSize: 20 * ffem,
      fontWeight: FontWeight.w700,
      height: 1.5 * ffem / fem,
      fontStyle: FontStyle.italic,
      color: const Color(0xffffffff),
    );
    return Container(
      width: 200,
      height: 175 * fem,
      decoration: boxDecoration,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(90),
                      bottomRight: Radius.circular(90)),
                  color: primaryColor,
                ),
                margin: const EdgeInsets.only(top: 10),
                height: 175,
                width: 140,
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/image/log.png"),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              children: [
                //const Padding(padding: EdgeInsets.only(top: 20)),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 5),
                  child: Row(
                    children: [
                      Text(
                        "Transfer",
                        style: TextStyle(
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.w900,
                          height: 1.5 * ffem / fem,
                          fontStyle: FontStyle.italic,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        " and",
                        style: textStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Text(
                        "Withdraw ",
                        style: TextStyle(
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.w900,
                          height: 1.5 * ffem / fem,
                          fontStyle: FontStyle.italic,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Money",
                        style: TextStyle(
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.w900,
                          height: 1.5 * ffem / fem,
                          fontStyle: FontStyle.italic,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Text(
                        "safely ",
                        style: textStyle,
                      ),
                      Text(
                        "and easily",
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: const [
                      Text(
                        "To Anyone from Anywhere 24/7 ",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
