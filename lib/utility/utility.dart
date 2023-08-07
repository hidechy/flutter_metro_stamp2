// ignore_for_file: type_annotate_public_apis

import 'package:flutter/material.dart';

class Utility {
  ///
  void showError(String msg) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  /// 背景取得
  Widget getBackGround({context}) {
    return Image.asset(
      'assets/images/bg.png',
      fit: BoxFit.fitHeight,
      color: Colors.black.withOpacity(0.7),
      colorBlendMode: BlendMode.darken,
    );
  }

  ///
  Color getTrainColor({required String trainName}) {
    final trainColorMap = <String, Color>{
      '東京メトロ銀座線': const Color(0xFFF19A38),
      '東京メトロ丸ノ内線': const Color(0xFFE24340),
      '東京メトロ日比谷線': const Color(0xFFB5B5AD),
      '東京メトロ東西線': const Color(0xFF4499BB),
      '東京メトロ千代田線': const Color(0xFF54B889),
      '東京メトロ有楽町線': const Color(0xFFBDA577),
      '東京メトロ半蔵門線': const Color(0xFF8B76D0),
      '東京メトロ南北線': const Color(0xFF4DA99B),
      '東京メトロ副都心線': const Color(0xFF93613A),
    };

    return (trainColorMap[trainName] != null)
        ? trainColorMap[trainName]!.withOpacity(0.6)
        : Colors.black.withOpacity(0.3);
  }

  ///
  Color getYoubiColor({required DateTime date, required String youbiStr, required List<DateTime> holiday}) {
    var color = Colors.black.withOpacity(0.2);

    switch (youbiStr) {
      case 'Sunday':
        color = Colors.redAccent.withOpacity(0.2);
        break;

      case 'Saturday':
        color = Colors.blueAccent.withOpacity(0.2);
        break;

      default:
        color = Colors.black.withOpacity(0.2);
        break;
    }

    if (holiday.contains(date)) {
      color = Colors.greenAccent.withOpacity(0.2);
    }

    return color;
  }
}

class NavigationService {
  const NavigationService._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
