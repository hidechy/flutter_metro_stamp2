// ignore_for_file: must_be_immutable

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../model/station_stamp.dart';
import '../state/station_stamp/station_stamp_notifier.dart';
import '../utility/utility.dart';
import 'station_info_alert.dart';
import 'station_map_alert.dart';
import 'station_stamp_dialog.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Station Stamp'),
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_train.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
            ),
          ],
        ),
      ),
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

    if (selectTrain == '') {
      return Container();
    }

    final trainMap = _ref.watch(stationStampProvider.select((value) => value.trainMap));

    final stationStampMap = _ref.watch(stationStampProvider.select((value) => value.stationStampMap));

    return Column(
      children: [
        Stack(
          children: [
            Image.asset('assets/images/title-$selectTrain.png'),
            Container(
              width: double.infinity,
              height: 30,
              color: Colors.black.withOpacity(0.2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Container(
                  margin: const EdgeInsets.only(top: 3, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      StationStampDialog(
                        context: _context,
                        widget: StationMapAlert(
                          flag: 'train',
                          stationList: stationStampMap[selectTrain]!,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.train,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              final latlng =
                  '${stationStampMap[selectTrain]?[index].lat} / ${stationStampMap[selectTrain]?[index].lng}';

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
                                      GestureDetector(
                                        onTap: () {
                                          final stationList = _getStation(
                                            imageFolder: stationStampMap[selectTrain]?[index].imageFolder,
                                            imageCode: stationStampMap[selectTrain]?[index].imageCode,
                                          );

                                          StationStampDialog(
                                            context: _context,
                                            widget: StationMapAlert(
                                              flag: 'spot',
                                              stationList: [stationList],
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: Colors.white.withOpacity(0.6),
                                        ),
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
                                        GestureDetector(
                                          onTap: () {
                                            final stationList = _getSamedateStation(
                                              stampGetDate: stationStampMap[selectTrain]?[index].stampGetDate,
                                            );

                                            StationStampDialog(
                                              context: _context,
                                              widget: StationMapAlert(
                                                flag: 'date',
                                                stationList: stationList,
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            size: 14,
                                            color: Colors.white.withOpacity(0.4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  StationStampDialog(
                                    context: _context,
                                    widget: StationInfoAlert(stamp: stationStampMap[selectTrain]?[index]),
                                  );
                                },
                                child: SizedBox(
                                  width: 40,
                                  child: Opacity(
                                    opacity: 0.6,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/no_image.png',
                                      image:
                                          'http://toyohide.work/BrainLog/station_stamp/${stationStampMap[selectTrain]?[index].imageFolder}/${stationStampMap[selectTrain]?[index].imageCode}.png',
                                      imageErrorBuilder: (c, o, s) => Image.asset('assets/images/no_image.png'),
                                    ),
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

  ///
  List<StationStamp> _getSamedateStation({String? stampGetDate}) {
    final list = <StationStamp>[];

    _ref.watch(stationStampProvider.select((value) => value.stationStampList)).forEach((element) {
      if (element.stampGetDate == stampGetDate!) {
        list.add(element);
      }
    });

    return list;
  }

  ///
  StationStamp _getStation({String? imageFolder, String? imageCode}) {
    final stationStampList = _ref.watch(stationStampProvider.select((value) => value.stationStampList));

    final train = stationStampList.where((element) => element.imageFolder == imageFolder).toList();

    final stationStamp = train.firstWhere((e) => e.imageCode == imageCode);

    return stationStamp;
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
