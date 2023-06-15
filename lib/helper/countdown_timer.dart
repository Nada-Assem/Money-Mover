import 'dart:async';

class CountdownTimer {
  int secondsRemaining;
  late Timer _timer;
  Function(int) onTimerUpdate;
  Function()? onTimerComplete;

  CountdownTimer({
    required this.secondsRemaining,
    required this.onTimerUpdate,
    this.onTimerComplete,
  }) {
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  void _tick(Timer timer) {
    secondsRemaining--;
    if (secondsRemaining <= 0) {
      _timer.cancel();
      onTimerComplete?.call();
    } else {
      onTimerUpdate.call(secondsRemaining);
    }
  }

  void dispose() {
    _timer.cancel();
  }
}
