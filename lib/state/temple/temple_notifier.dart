// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../model/temple.dart';
import 'temple_response_state.dart';

//////////////////////////////////////////////////////

final templeAllProvider = StateNotifierProvider.autoDispose<TempleAllNotifier, TempleResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  return TempleAllNotifier(
    const TempleResponseState(),
    client,
  )..getAllTemple();
});

class TempleAllNotifier extends StateNotifier<TempleResponseState> {
  TempleAllNotifier(super.state, this.client);

  final HttpClient client;

  ///
  Future<void> getAllTemple() async {
    await client.post(path: APIPath.getAllTemple).then((value) {
      final map = <String, Temple>{};

      for (var i = 0; i < int.parse(value['list'].length.toString()); i++) {
        final val = Temple.fromJson(value['list'][i] as Map<String, dynamic>);

        map[val.date.yyyymmdd] = val;
      }

      state = state.copyWith(dateTempleMap: map);
    });
  }
}

//////////////////////////////////////////////////////
