// ignore_for_file: must_be_immutable, depend_on_referenced_packages, constant_pattern_never_matches_value_type

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../extensions/extensions.dart';
import '../model/station_stamp.dart';
import '../state/select_train/select_train_notifier.dart';
import '../state/station_stamp/station_stamp_notifier.dart';
import '../utility/utility.dart';

enum MapCallPattern { train, date, spot }

class StationMapAlert extends ConsumerWidget {
  StationMapAlert({super.key, required this.flag, required this.stationList});

  final MapCallPattern flag;
  final List<StationStamp> stationList;

  final Utility _utility = Utility();

  double boundsLatLngDiffSmall = 0;

  late double boundsInner;

  Map<String, double> boundsLatLngMap = {};

  List<Marker> markerList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    if (flag != MapCallPattern.spot) {
      makeBounds();
    }

    makeMarker();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _displayMapAlertHeader(),

            //---------------------------------------------
            Expanded(
              child: FlutterMap(
                options: (flag == MapCallPattern.spot)
                    ? MapOptions(
                        center: LatLng(stationList[0].lat.toDouble(), stationList[0].lng.toDouble()),
                        zoom: 16,
                        maxZoom: 17,
                        minZoom: 3,
                      )
                    : MapOptions(
                        bounds: LatLngBounds(
                          LatLng(
                            boundsLatLngMap['minLat']! - boundsInner,
                            boundsLatLngMap['minLng']! - boundsInner,
                          ),
                          LatLng(
                            boundsLatLngMap['maxLat']! + boundsInner,
                            boundsLatLngMap['maxLng']! + boundsInner,
                          ),
                        ),
                      ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(markers: markerList),
                ],
              ),
            ),
            //---------------------------------------------

            _displayMapAlertFooter(),
          ],
        ),
      ),
    );
  }

  ///
  void makeBounds() {
    final latList = <double>[];
    final lngList = <double>[];

    stationList.forEach((element) {
      latList.add(element.lat.toDouble());
      lngList.add(element.lng.toDouble());
    });

    final minLat = latList.reduce(min);
    final maxLat = latList.reduce(max);
    final minLng = lngList.reduce(min);
    final maxLng = lngList.reduce(max);

    final latDiff = maxLat - minLat;
    final lngDiff = maxLng - minLng;
    boundsLatLngDiffSmall = (latDiff < lngDiff) ? latDiff : lngDiff;
    boundsInner = boundsLatLngDiffSmall * 0.2;

    boundsLatLngMap = {
      'minLat': minLat,
      'maxLat': maxLat,
      'minLng': minLng,
      'maxLng': maxLng,
    };
  }

  ///
  void makeMarker() {
    markerList = [];

    final trainMap = _ref.watch(stationStampProvider.select((value) => value.trainMap));

    final keepGetOrder = <int>[];

    for (var i = 0; i < stationList.length; i++) {
      if (flag == MapCallPattern.date) {
        if (keepGetOrder.contains(stationList[i].stampGetOrder)) {
          continue;
        }
      }

      markerList.add(
        Marker(
          point: LatLng(
            stationList[i].lat.toDouble(),
            stationList[i].lng.toDouble(),
          ),
          builder: (context) {
            return (flag == MapCallPattern.date)
                ? CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: Text(
                      stationList[i].stampGetOrder.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: _utility.getTrainColor(trainName: trainMap[stationList[i].imageFolder]!),
                    child: Text(
                      stationList[i].imageCode,
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  );
          },
        ),
      );

      keepGetOrder.add(stationList[i].stampGetOrder);
    }
  }

  ///
  Widget _displayMapAlertHeader() {
    switch (flag) {
      case MapCallPattern.train:
        return Column(
          children: [
            Image.asset('assets/images/title-${stationList[0].imageFolder}.png'),
            const SizedBox(height: 5),
          ],
        );

      case MapCallPattern.date:
        return Column(
          children: [
            const SizedBox(height: 10),
            Text(stationList[0].stampGetDate),
            const SizedBox(height: 15),
          ],
        );

      case MapCallPattern.spot:
        return const SizedBox(height: 10);
    }
  }

  ///
  Widget _displayMapAlertFooter() {
    switch (flag) {
      case MapCallPattern.train:
        return Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(stationList[index].imageCode),
                              const SizedBox(width: 20),
                              Text(stationList[index].stationName),
                            ],
                          ),
                          Text(stationList[index].stampGetDate),
                        ],
                      ),
                    );
                  },
                  itemCount: stationList.length,
                ),
              ),
            ),
          ],
        );

      case MapCallPattern.date:
        return Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(stationList[index].stampGetOrder.toString()),
                              const SizedBox(width: 20),
                              Text(stationList[index].stationName),
                            ],
                          ),
                          Text(stationList[index].stampGetDate),
                        ],
                      ),
                    );
                  },
                  itemCount: stationList.length,
                ),
              ),
            ),
          ],
        );

      case MapCallPattern.spot:
        final selectTrain = _ref.watch(selectTrainProvider);

        final stationStampMap = _ref.watch(stationStampProvider.select((value) => value.stationStampMap));

        return Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(stationStampMap[selectTrain]![index].imageCode),
                              const SizedBox(width: 20),
                              Text(stationStampMap[selectTrain]![index].stationName),
                            ],
                          ),
                          Text(stationStampMap[selectTrain]![index].stampGetDate),
                        ],
                      ),
                    );
                  },
                  itemCount: stationStampMap[selectTrain]!.length,
                ),
              ),
            ),
          ],
        );
    }
  }
}
