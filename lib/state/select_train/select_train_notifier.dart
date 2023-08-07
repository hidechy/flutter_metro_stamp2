import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectTrainProvider = StateNotifierProvider.autoDispose<SelectTrainStateNotifier, String>((ref) {
  return SelectTrainStateNotifier();
});

class SelectTrainStateNotifier extends StateNotifier<String> {
  SelectTrainStateNotifier() : super('');

  ///
  Future<void> setTrain({required String train}) async {
    state = train;
  }
}
