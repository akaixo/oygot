import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oygot/constants/theme_data.dart';
import '../data.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              color: CustomColors.primaryTextColor,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>((alarm) {
                var alarmTime = DateFormat('hh:mm aa').format(alarm.alarmDateTime);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: alarm.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: alarm.gradientColors.last.withOpacity(
                                  0.4,
                                ),
                                blurRadius: 8,
                                spreadRadius: 4,
                                offset: Offset(4, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.label,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Office',
                                        style: TextStyle(
                                          fontFamily: 'avenir',
                                          // fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Switch(
                                    onChanged: (bool value) {},
                                    value: true,
                                    activeColor: Colors.white,
                                  ),
                                ],
                              ),
                              Text(
                                'Пн-Пт',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'avenir',
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '07:00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).followedBy([
                        if (alarms.length < 5)
                        DottedBorder(
                          options: RectDottedBorderOptions(
                            strokeWidth: 3,
                            color: CustomColors.clockoutline,
                            borderPadding: EdgeInsets.all(5),
                            dashPattern: [5, 4],
                            padding: EdgeInsets.all(10),
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: CustomColors.clockBG,
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16,
                              ),
                              ),
                              onPressed: () {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/add_alarm.png',
                                    scale: 1.5,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Добавить будильник',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Text('Разрешено использовать только 5 сигналов тревоги!'),
                  ]).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
