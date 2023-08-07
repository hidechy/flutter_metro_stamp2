// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../model/station_stamp.dart';
import '../state/holiday/holiday_notifier.dart';
import '../state/station_stamp/station_stamp_notifier.dart';
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

    final holidayState = _ref.watch(holidayProvider);

    final dateStationStampMap = _ref.watch(stationStampProvider.select((value) => value.dateStationStampMap));

    final firstDate = DateTime(2022, 12, 3);

    final diff = DateTime(2023, 8, 5).difference(firstDate).inDays;

    for (var i = 0; i <= diff; i++) {
      final genDate = firstDate.add(Duration(days: i)).yyyymmdd;

      final youbi = firstDate.add(Duration(days: i)).youbiStr;

      final stationList = <StationStamp>[];
      final keepOrder = <int>[];
      dateStationStampMap[genDate]?.forEach((element) {
        if (!keepOrder.contains(element.stampGetOrder)) {
          stationList.add(element);
        }

        keepOrder.add(element.stampGetOrder);
      });

      stationList.sort((a, b) => a.stampGetOrder.compareTo(b.stampGetOrder));

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
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('$genDate (${youbi.substring(0, 3)})'),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  (stationList.isNotEmpty)
                      ? (stationList.length > 1)
                          ? '${stationList[0].stationName} 〜 ${stationList[stationList.length - 1].stationName}'
                          : stationList[0].stationName
                      : '',
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      Text((stationList.isNotEmpty) ? stationList.length.toString() : ''),
                      if (stationList.isNotEmpty) ...[
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            final stationList = getSamedateStation(
                              ref: _ref,
                              stampGetDate: genDate.replaceAll('-', '/'),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}
