import 'dart:ui';

class AlarmInfo {
  DateTime alarmDateTime;
  String description;
  bool isActive;
  List<Color> gradientColors;

  AlarmInfo( this.alarmDateTime, {required this.description, required this.gradientColors, required this.isActive});
}