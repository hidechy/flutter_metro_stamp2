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

  List<LatLng> polyLineList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    if (flag != MapCallPattern.spot) {
      _makeBounds();
    }

    _makeMarker();

    if (flag == MapCallPattern.date) {
      _makePolyline();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: polyLineList,
                        color: Colors.redAccent.withOpacity(0.6),
                        strokeWidth: 5,
                      ),
                    ],
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
  void _makeBounds() {
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
  void _makeMarker() {
    markerList = [];

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
                    backgroundColor: _getDatePatternBgColor(
                      stationName: stationList[i].stationName,
                      posterPosition: stationList[i].posterPosition,
                    ),
                    child: Text(
                      stationList[i].stampGetOrder.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: _utility.getTrainColor(trainName: stationList[i].trainName),
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
  void _makePolyline() {
    stationList.forEach((element) {
      polyLineList.add(LatLng(element.lat.toDouble(), element.lng.toDouble()));
    });
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(stationList[0].stampGetDate),
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 10),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.deepOrange.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                          child: const Text('特殊'),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                          child: const Text('改札外'),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                          child: const Text('改札内'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                          Expanded(child: Text(stationList[index].imageCode)),
                          Expanded(
                            flex: 3,
                            child: Text(stationList[index].stationName),
                          ),
                          Expanded(
                            flex: 2,
                            child: _displayTrainMark(station: stationList[index].stationName),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(stationList[index].stampGetDate),
                          ),
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
                          Expanded(
                            child: Text(stationList[index].stampGetOrder.toString()),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(stationList[index].stationName),
                          ),
                          Expanded(
                            flex: 2,
                            child: _displayTrainMark(station: stationList[index].stationName),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(stationList[index].stampGetDate),
                          ),
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
                          Expanded(child: Text(stationStampMap[selectTrain]![index].imageCode)),
                          Expanded(
                            flex: 3,
                            child: Text(stationStampMap[selectTrain]![index].stationName),
                          ),
                          Expanded(
                            flex: 2,
                            child: _displayTrainMark(station: stationStampMap[selectTrain]![index].stationName),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(stationStampMap[selectTrain]![index].stampGetDate),
                          ),
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

  ///
  Widget _displayTrainMark({required String station}) {
    final list = <Widget>[];

    final stationStampList = _ref.watch(stationStampProvider.select((value) => value.stationStampList));

    stationStampList.where((element) => element.stationName == station).toList().forEach((element) {
      list.add(
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _utility.getTrainColor(trainName: element.trainName),
          ),
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            padding: const EdgeInsets.all(4),
            child: Text(
              element.imageFolder,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      );
    });

    return Row(children: list);
  }

  ///
  Color _getDatePatternBgColor({required String posterPosition, required String stationName}) {
    final reg = RegExp('改札内');
    final reg2 = RegExp('改札外');

    final specialStation = <String>[
      '中目黒',
      '中野',
      '西船橋',
      '代々木上原',
      '和光市',
      '目黒',
    ];

    if (specialStation.contains(stationName)) {
      return Colors.deepOrange.withOpacity(0.4);
    } else if (reg.firstMatch(posterPosition) != null) {
      return Colors.pinkAccent.withOpacity(0.4);
    } else if (reg2.firstMatch(posterPosition) != null) {
      return Colors.indigo.withOpacity(0.4);
    } else {
      return Colors.black.withOpacity(0.4);
    }
  }
}
