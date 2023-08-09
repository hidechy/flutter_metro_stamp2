// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../model/walk_record.dart';
import 'walk_record_response_state.dart';

//////////////////////////////////////////////////////

final walkRecordProvider = StateNotifierProvider.autoDispose<WalkRecordNotifier, WalkRecordResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  return WalkRecordNotifier(
    const WalkRecordResponseState(),
    client,
  )..getWalkRecord();
});

class WalkRecordNotifier extends StateNotifier<WalkRecordResponseState> {
  WalkRecordNotifier(super.state, this.client);

  final HttpClient client;

  ///
  Future<void> getWalkRecord() async {
    await client.post(path: APIPath.getWalkRecord2).then((value) {
      final list = <WalkRecord>[];
      final map = <String, WalkRecord>{};

      for (var i = 0; i < value.length.toString().toInt(); i++) {
        final record = WalkRecord(
          date: '${value[i]['date']} 00:00:00'.toDateTime(),
          step: value[i]['step'].toString().toInt(),
          distance: value[i]['distance'].toString().toInt(),
          timeplace: value[i]['timeplace'].toString(),
          temple: value[i]['temple'].toString(),
          mercari: value[i]['mercari'].toString(),
          train: value[i]['train'].toString(),
          spend: value[i]['spend'].toString(),
        );

        list.add(record);

        map['${value[i]['date']} 00:00:00'.toDateTime().yyyymmdd] = record;
      }

      state = state.copyWith(walkRecordList: list, walkRecordMap: map);
    });
  }
}

//////////////////////////////////////////////////////
