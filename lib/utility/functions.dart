// ignore_for_file: cascade_invocations

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/station_stamp.dart';
import '../state/station_stamp/station_stamp_notifier.dart';

///
List<StationStamp> getSamedateStation({required WidgetRef ref, String? stampGetDate}) {
  final list2 = <StationStamp>[];
  final keepOrder = <int>[];

  final getData = ref.watch(stationStampProvider.select((value) => value.stationStampList));

  final filteredData = getData.where((element) => element.stampGetDate == stampGetDate).toList();

  filteredData.forEach((element) {
    if (!keepOrder.contains(element.stampGetOrder)) {
      list2.add(element);
    }

    keepOrder.add(element.stampGetOrder);
  });

  return list2;
}
