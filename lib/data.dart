
import 'package:flutter/cupertino.dart';
import 'package:oygot/constants/theme_data.dart';
import 'package:oygot/enums.dart';
import 'package:oygot/models/alarm_info.dart';
import 'package:oygot/models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(
    MenuType.clock,
    title: 'Clock',
    imageSource: 'assets/icons/clock_icon.png',
  ),
  MenuInfo(
    MenuType.alarm,
    title: 'Alarm',
    imageSource: 'assets/icons/alarm_icon.png',
  ),
  MenuInfo(
    MenuType.timer,
    title: 'Timer',
    imageSource: 'assets/icons/timer_icon.png',
  ),
  MenuInfo(
    MenuType.stopwatch,
    title: 'Stopwatch',
    imageSource: 'assets/icons/stopwatch_icon.png',
  ),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
    DateTime.now().add(Duration(hours: 1)),
    description: 'Office',
    gradientColors: GradientColors.sky,
    isActive: true,
  ),
  AlarmInfo(
    DateTime.now().add(Duration(hours: 2)),
    description: 'Sport',
    gradientColors: GradientColors.sunset,
    isActive: true,
  ),
];
