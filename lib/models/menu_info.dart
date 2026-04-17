import 'package:flutter/cupertino.dart';
import 'package:oygot/enums.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String title;
  String imageSource;

  MenuInfo(MenuType menuType, {required this.title, required this.imageSource})
      : menuType = menuType;

  updateMenu(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}