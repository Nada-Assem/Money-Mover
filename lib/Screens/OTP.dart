import '../helper/import.dart';

class otpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OTP(),
    );
  }
}

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  late CountdownTimer _timer;
  int first = Random().nextInt(9);
  int second = Random().nextInt(9);
  int third = Random().nextInt(9);
  int fourth = Random().nextInt(9);

  void Timer() {
    _timer = CountdownTimer(
      secondsRemaining: 59,
      onTimerUpdate: (int seconds) {
        setState(() {});
      },
      onTimerComplete: () {},
    );
  }

  @override
  void initState() {
    _timer = CountdownTimer(
      secondsRemaining: 59,
      onTimerUpdate: (int seconds) {
        setState(() {});
      },
      onTimerComplete: () {},
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Center(
          child: Container(
            height: 460,
            width: 380,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.491, 1.084),
                end: Alignment(2.122, -2.474),
                colors: <Color>[Color(0x005d5ffc), Color(0xff47e975)],
                stops: <double>[0, 1],
              ),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Text(
                  '${_timer.secondsRemaining ~/ 60} : ${(_timer.secondsRemaining % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 50, color: Colors.white),
                ),
                const Text(
                  "Type This Verification Code on The ATM",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    const SizedBox(width: 45),
                    otpBox(num: "$first"),
                    otpBox(num: "$second"),
                    otpBox(num: "$third"),
                    otpBox(num: "$fourth"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          first = Random().nextInt(9);

                          second = Random().nextInt(9);

                          third = Random().nextInt(9);

                          fourth = Random().nextInt(9);
                          Timer();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 29, 51, 73),
                      ),
                      child: const Text(
                        "Send again",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 260),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const Done();
                      }));
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
