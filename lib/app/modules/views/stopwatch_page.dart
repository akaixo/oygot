import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/app/data/theme_data.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  List<String> laps = [];

  void startStopwatch() {
    if (stopwatch.isRunning) return;

    stopwatch.start();

    timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      setState(() {});
    });
  }

  void stopStopwatch() {
    stopwatch.stop();
    timer?.cancel();

    setState(() {});
  }

  void resetStopwatch() {
    stopwatch.stop();
    stopwatch.reset();
    timer?.cancel();

    setState(() {
      laps.clear();
    });
  }

  void addLap() {
    if (stopwatch.isRunning) {
      setState(() {
        laps.insert(0, formatTime(stopwatch.elapsedMilliseconds));
      });
    }
  }

  String formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate() % 60;
    int hours = (milliseconds / (1000 * 60 * 60)).truncate();

    return "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}:"
        "${hundreds.toString().padLeft(2, '0')}";
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
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Секундомер',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: CustomColors.primaryTextColor,
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Container(
                width: 260,
                height: 260,
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
                    formatTime(stopwatch.elapsedMilliseconds),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
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
                  onTap: startStopwatch,
                ),
                buildActionButton(
                  title: 'Стоп',
                  icon: Icons.pause_rounded,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFFFC107)],
                  ),
                  onTap: stopStopwatch,
                ),
                buildActionButton(
                  title: 'Сброс',
                  icon: Icons.refresh_rounded,
                  gradient: LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFFF6E40)],
                  ),
                  onTap: resetStopwatch,
                ),
                buildActionButton(
                  title: 'Круг',
                  icon: Icons.flag_rounded,
                  gradient: LinearGradient(
                    colors: [Color(0xFF2979FF), Color(0xFF00B0FF)],
                  ),
                  onTap: addLap,
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: laps.isEmpty
                  ? Center(
                child: Text(
                  'Кругов пока нет',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white10,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Круг ${laps.length - index}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          laps[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}