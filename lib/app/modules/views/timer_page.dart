import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/app/data/theme_data.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  int totalSeconds = 60;
  int currentSeconds = 60;

  Timer? timer;
  bool isRunning = false;

  void updateTotalSeconds() {
    totalSeconds = (hours * 3600) + (minutes * 60) + seconds;

    if (!isRunning) {
      currentSeconds = totalSeconds;
    }
  }

  void startTimer() {
    if (isRunning) return;

    if (currentSeconds <= 0) {
      updateTotalSeconds();
    }

    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentSeconds > 0) {
        setState(() {
          currentSeconds--;
        });
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
      updateTotalSeconds();
    });
  }

  String formatTime(int total) {
    int hrs = total ~/ 3600;
    int mins = (total % 3600) ~/ 60;
    int secs = total % 60;

    return "${hrs.toString().padLeft(2, '0')}:"
        "${mins.toString().padLeft(2, '0')}:"
        "${secs.toString().padLeft(2, '0')}";
  }

  Widget buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white24,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget buildTimeColumn({
    required int value,
    required String label,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildControlButton(icon: Icons.add, onTap: onAdd),
        SizedBox(height: 10),
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.white70)),
        SizedBox(height: 10),
        buildControlButton(icon: Icons.remove, onTap: onRemove),
      ],
    );
  }

  Widget buildActionButton({
    required String title,
    required IconData icon,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'avenir',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateTotalSeconds();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Таймер',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: CustomColors.primaryTextColor,
              ),
            ),

            SizedBox(height: 30),

            // TIME PICKERS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimeColumn(
                  value: hours,
                  label: 'час',
                  onAdd: () {
                    if (!isRunning && hours < 23) {
                      setState(() {
                        hours++;
                        updateTotalSeconds();
                      });
                    }
                  },
                  onRemove: () {
                    if (!isRunning && hours > 0) {
                      setState(() {
                        hours--;
                        updateTotalSeconds();
                      });
                    }
                  },
                ),
                SizedBox(width: 30),
                buildTimeColumn(
                  value: minutes,
                  label: 'мин',
                  onAdd: () {
                    if (!isRunning && minutes < 59) {
                      setState(() {
                        minutes++;
                        updateTotalSeconds();
                      });
                    }
                  },
                  onRemove: () {
                    if (!isRunning && minutes > 0) {
                      setState(() {
                        minutes--;
                        updateTotalSeconds();
                      });
                    }
                  },
                ),
                SizedBox(width: 30),
                buildTimeColumn(
                  value: seconds,
                  label: 'сек',
                  onAdd: () {
                    if (!isRunning && seconds < 59) {
                      setState(() {
                        seconds++;
                        updateTotalSeconds();
                      });
                    }
                  },
                  onRemove: () {
                    if (!isRunning && seconds > 0) {
                      setState(() {
                        seconds--;
                        updateTotalSeconds();
                      });
                    }
                  },
                ),
              ],
            ),

            SizedBox(height: 40),

            // TIMER CIRCLE
            Center(
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6D5DF6),
                      Color(0xFF46C2FF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    formatTime(currentSeconds),
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            // BUTTONS
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                buildActionButton(
                  title: 'Старт',
                  icon: Icons.play_arrow_rounded,
                  gradient: LinearGradient(
                    colors: [Color(0xFF00C853), Color(0xFF69F0AE)],
                  ),
                  onTap: startTimer,
                ),
                buildActionButton(
                  title: 'Пауза',
                  icon: Icons.pause_rounded,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFFFC107)],
                  ),
                  onTap: stopTimer,
                ),
                buildActionButton(
                  title: 'Сброс',
                  icon: Icons.refresh_rounded,
                  gradient: LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFFF6E40)],
                  ),
                  onTap: resetTimer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}