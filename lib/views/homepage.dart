import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oygot/constants/theme_data.dart';
import 'package:oygot/models/menu_info.dart';
import 'package:oygot/views/alarm_page.dart';
import 'package:oygot/views/clock_page.dart';
import 'package:oygot/views/clock_view.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import '../enums.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
          const VerticalDivider(color: Colors.white54, width: 1),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child) {

                if (value.menuType == MenuType.clock) {
                  return ClockView( size: 320);
                }
                else if (value.menuType == MenuType.alarm) {
                  return const AlarmPage();
                }
                else {
                  return Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 20),
                        children: <TextSpan>[
                          const TextSpan(text: 'Upcoming Tutorial\n'),
                          TextSpan(
                            text: value.title ?? '',
                            style: const TextStyle(fontSize: 48),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        final isSelected = currentMenuInfo.menuType == value.menuType;
        return TextButton(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: isSelected
                ? CustomColors.menuBackgroundColor
                : Colors.transparent,
          ),
          onPressed: () {
            Provider.of<MenuInfo>(context, listen: false)
                .updateMenu(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(currentMenuInfo.imageSource, scale: 1.5),
              const SizedBox(height: 16),
              Text(
                currentMenuInfo.title ?? '',
                style: const TextStyle(
                  fontFamily: 'avenir',
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}