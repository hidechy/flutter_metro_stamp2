// ignore_for_file: must_be_immutable, literal_only_boolean_expressions

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../model/station_stamp.dart';
import '../state/holiday/holiday_notifier.dart';
import '../state/station_stamp/station_stamp_notifier.dart';
import '../state/temple/temple_notifier.dart';
import '../utility/functions.dart';
import '../utility/utility.dart';
import 'station_map_alert.dart';
import 'station_stamp_dialog.dart';

class StationDateListAlert extends ConsumerWidget {
  StationDateListAlert({super.key});

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Expanded(child: _displayDateList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayDateList() {
    final list = <Widget>[];

    final dateTempleMap = _ref.watch(templeAllProvider.select((value) => value.dateTempleMap));

    final holidayState = _ref.watch(holidayProvider);

    final dateStationStampMap = _ref.watch(stationStampProvider.select((value) => value.dateStationStampMap));

    final firstDate = DateTime(2022, 12, 3);

    final diff = DateTime(2023, 8, 5).difference(firstDate).inDays;

    for (var i = 0; i <= diff; i++) {
      final genDate = firstDate.add(Duration(days: i));

      final youbi = firstDate.add(Duration(days: i)).youbiStr;

      final stationList = <StationStamp>[];
      final keepOrder = <int>[];
      dateStationStampMap[genDate.yyyymmdd]?.forEach((element) {
        if (!keepOrder.contains(element.stampGetOrder)) {
          stationList.add(element);
        }

        keepOrder.add(element.stampGetOrder);
      });

      stationList.sort((a, b) => a.stampGetOrder.compareTo(b.stampGetOrder));

      final templeList = <String>[];
      if (dateTempleMap[genDate.yyyymmdd] != null && stationList.isNotEmpty) {
        templeList.add('${dateTempleMap[genDate.yyyymmdd]?.temple}');

        if ('${dateTempleMap[genDate.yyyymmdd]?.memo}' != '') {
          templeList.add('${dateTempleMap[genDate.yyyymmdd]?.memo}');
        }
      }

      list.add(
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            color: _utility.getYoubiColor(
              date: firstDate.add(Duration(days: i)),
              youbiStr: youbi,
              holiday: holidayState.data,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${genDate.yyyymmdd} (${youbi.substring(0, 3)})',
                    style: TextStyle(color: (stationList.isNotEmpty) ? Colors.white : Colors.grey),
                  ),
                  Container(
                    child: (stationList.isNotEmpty)
                        ? Row(
                            children: [
                              Text((stationList.isNotEmpty) ? stationList.length.toString() : ''),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  final stationList = getSamedateStation(
                                    ref: _ref,
                                    stampGetDate: genDate.yyyymmdd.replaceAll('-', '/'),
                                  )..sort((a, b) => a.stampGetOrder.compareTo(b.stampGetOrder));

                                  StationStampDialog(
                                    context: _context,
                                    widget: StationMapAlert(
                                      flag: MapCallPattern.date,
                                      stationList: stationList,
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors.white.withOpacity(0.4),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (stationList.isNotEmpty)
                              ? (stationList.length > 1)
                                  ? '${stationList[0].stationName} 〜 ${stationList[stationList.length - 1].stationName}'
                                  : stationList[0].stationName
                              : '',
                        ),
                        if (dateTempleMap[genDate.yyyymmdd] != null && stationList.isNotEmpty)
                          Text(
                            templeList.join('、'),
                            style: const TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(children: list),
      ),
    );
  }
}
