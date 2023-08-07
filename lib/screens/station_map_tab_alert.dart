// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/select_train/select_train_notifier.dart';
import '../state/station_stamp/station_stamp_notifier.dart';
import 'station_map_alert.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class StationMapTabAlert extends ConsumerWidget {
  StationMapTabAlert({super.key});

  List<TabInfo> tabs = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final selectTrain = _ref.watch(selectTrainProvider);

    final trainMap = _ref.watch(stationStampProvider.select((value) => value.trainMap));

    makeTab();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            title: Text(
              trainMap[selectTrain]!,
              style: const TextStyle(fontSize: 12),
            ),

            centerTitle: true,

            backgroundColor: Colors.transparent,
            //-------------------------//これを消すと「←」が出てくる（消さない）
            leading: const Icon(
              Icons.check_box_outline_blank,
              color: Colors.transparent,
            ),
            //-------------------------//これを消すと「←」が出てくる（消さない）

            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.blueAccent,
              tabs: tabs.map((TabInfo tab) {
                return Tab(text: tab.label);
              }).toList(),
            ),

            flexibleSpace: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: tabs.map((tab) => tab.widget).toList(),
        ),
      ),
    );
  }

  ///
  void makeTab() {
    final selectTrain = _ref.watch(selectTrainProvider);

    final stationStampMap = _ref.watch(stationStampProvider.select((value) => value.stationStampMap));

    stationStampMap[selectTrain]?.forEach((element) {
      tabs.add(
        TabInfo(
          element.stationName,
          StationMapAlert(
            flag: MapCallPattern.spot,
            stationList: [element],
          ),
        ),
      );
    });
  }
}
