import 'package:flutter_alarm_clock/app/data/enums.dart';
import 'package:flutter_alarm_clock/app/data/models/alarm_info.dart';
import 'package:flutter_alarm_clock/app/data/models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title: 'Часы', imageSource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm, title: 'Будильник', imageSource: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.timer, title: 'Таймер', imageSource: 'assets/timer_icon.png'),
  MenuInfo(MenuType.stopwatch, title: 'Секундомер', imageSource: 'assets/stopwatch_icon.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(hours: 1)), title: 'Офис', gradientColorIndex: 0),
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(hours: 2)), title: 'Спорт', gradientColorIndex: 1),
];
