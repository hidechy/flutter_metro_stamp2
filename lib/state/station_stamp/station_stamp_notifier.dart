// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../model/station_stamp.dart';
import '../../utility/utility.dart';
import 'station_stamp_response_state.dart';

////////////////////////////////////////////////
final stationStampProvider = StateNotifierProvider.autoDispose<StationStampNotifier, StationStampResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return StationStampNotifier(const StationStampResponseState(), client, utility)..getStationStamp();
});

class StationStampNotifier extends StateNotifier<StationStampResponseState> {
  StationStampNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getStationStamp() async {
    await client.post(path: APIPath.getStationStamp).then((value) {
      final trainMap = <String, String>{};
      final stationStampMap = <String, List<StationStamp>>{};
      final dateStationStampMap = <String, List<StationStamp>>{};
      final stationStampList = <StationStamp>[];

      final keepTrain = <String>[];
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final val = StationStamp.fromJson(value['data'][i] as Map<String, dynamic>);

        stationStampMap[val.imageFolder] = [];
        dateStationStampMap[val.stampGetDate.replaceAll('/', '-')] = [];

        if (!keepTrain.contains(val.imageFolder)) {
          trainMap[val.imageFolder] = val.trainName;
        }

        keepTrain.add(val.imageFolder);
      }

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final val = StationStamp.fromJson(value['data'][i] as Map<String, dynamic>);

        stationStampList.add(val);

        stationStampMap[val.imageFolder]?.add(val);

        dateStationStampMap[val.stampGetDate.replaceAll('/', '-')]?.add(val);
      }

      state = state.copyWith(
        trainMap: trainMap,
        stationStampMap: stationStampMap,
        dateStationStampMap: dateStationStampMap,
        stationStampList: stationStampList,
      );
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
