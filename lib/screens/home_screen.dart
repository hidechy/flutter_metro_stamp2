// ignore_for_file: must_be_immutable

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../state/station_stamp/station_stamp_notifier.dart';
import '../utility/utility.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.screenSize.width * 0.2,
                  child: _displayTrainMark(),
                ),
                Expanded(
                  child: _displayStationList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget _displayTrainMark() {
    final list = <Widget>[const SizedBox(height: 20)];

    _ref.watch(stationStampProvider).trainMap.forEach(
      (key, value) {
        list.add(
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  _ref.watch(selectTrainProvider.notifier).setTrain(train: key);
                },
                child: CircleAvatar(
                  backgroundColor: _utility.getTrainColor(trainName: value),
                  radius: 22,
                  child: CircleAvatar(radius: 20, child: Text(key)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  ///
  Widget _displayStationList() {
    final selectTrain = _ref.watch(selectTrainProvider);

    final trainMap = _ref.watch(stationStampProvider.select((value) => value.trainMap));

    final stationStampMap = _ref.watch(stationStampProvider.select((value) => value.stationStampMap));

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(trainMap[selectTrain] ?? ''),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              final latlng =
                  '${stationStampMap[selectTrain]?[index].lat} / ${stationStampMap[selectTrain]?[index].lng}';

              final image =
                  'http://toyohide.work/BrainLog/station_stamp/${stationStampMap[selectTrain]?[index].imageFolder}/${stationStampMap[selectTrain]?[index].imageCode}.png';

              return DefaultTextStyle(
                style: const TextStyle(fontSize: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: (trainMap[selectTrain] == null)
                              ? Colors.transparent
                              : _utility.getTrainColor(trainName: trainMap[selectTrain]!),
                          child: CircleAvatar(
                            radius: 16,
                            child: Text(
                              stationStampMap[selectTrain]?[index].imageCode ?? '',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Bubble(
                                  margin: const BubbleEdges.only(top: 10),
                                  alignment: Alignment.topLeft,
                                  nipWidth: 8,
                                  nipHeight: 24,
                                  nip: BubbleNip.leftTop,
                                  color: (trainMap[selectTrain] == null)
                                      ? Colors.transparent
                                      : _utility.getTrainColor(trainName: trainMap[selectTrain]!).withOpacity(0.4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        stationStampMap[selectTrain]?[index].stationName ?? '',
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(width: 20),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(stationStampMap[selectTrain]?[index].posterPosition ?? ''),
                                    const SizedBox(height: 5),
                                    Text(latlng),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('取得日：${stationStampMap[selectTrain]?[index].stampGetDate}'),
                                        Icon(
                                          Icons.calendar_today,
                                          size: 14,
                                          color: Colors.white.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 40,
                                child: Opacity(
                                  opacity: 0.6,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/no_image.png',
                                    image: image,
                                    imageErrorBuilder: (c, o, s) => Image.asset('assets/images/no_image.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Container(),
            itemCount: stationStampMap[selectTrain]?.length ?? 0,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

////////////////////////////////////////////////////////////
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
