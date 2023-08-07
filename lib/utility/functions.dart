import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/station_stamp.dart';
import '../state/station_stamp/station_stamp_notifier.dart';

///
List<StationStamp> getSamedateStation({required WidgetRef ref, String? stampGetDate}) {
  final list2 = <StationStamp>[];
  final keepOrder = <int>[];

  ref
      .watch(stationStampProvider.select((value) => value.stationStampList))
      .where((element) => element.stampGetDate == stampGetDate)
      .toList()
      .forEach((element) {
    if (!keepOrder.contains(element.stampGetOrder)) {
      list2.add(element);
    }

    keepOrder.add(element.stampGetOrder);
  });

  return list2;
}
