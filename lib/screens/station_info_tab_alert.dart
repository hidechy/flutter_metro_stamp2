// ignore_for_file: must_be_immutable, depend_on_referenced_packages, cascade_invocations

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/select_train/select_train_notifier.dart';
import '../state/station_stamp/station_stamp_notifier.dart';
import 'station_info_alert.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class StationInfoTabAlert extends HookConsumerWidget {
  StationInfoTabAlert({super.key, required this.index});

  final int index;

  List<TabInfo> tabs = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeTab();

    // 最初に開くタブを指定する
    final tabController = useTabController(initialLength: tabs.length);
    tabController.index = index;
    // 最初に開くタブを指定する

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            //-------------------------//これを消すと「←」が出てくる（消さない）
            leading: const Icon(
              Icons.check_box_outline_blank,
              color: Colors.transparent,
            ),
            //-------------------------//これを消すと「←」が出てくる（消さない）

            bottom: TabBar(
              //================================//
              controller: tabController,
              //================================//

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
          //================================//
          controller: tabController,
          //================================//

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
          StationInfoAlert(
            stamp: element,
          ),
        ),
      );
    });
  }
}
