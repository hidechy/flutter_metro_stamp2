// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../extensions/extensions.dart';
import '../model/station_stamp.dart';
import '../state/station_stamp/station_stamp_notifier.dart';
import '../utility/utility.dart';

class StationMapAlert extends ConsumerWidget {
  StationMapAlert({super.key, required this.flag, required this.stationList});

  final String flag;
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

    if (flag != 'spot') {
      makeBounds();
    }

    makeMarker();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------------------------------------
            Expanded(
              child: FlutterMap(
                options: (flag == 'spot')
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
      if (flag == 'date') {
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
            return (flag == 'date')
                ? CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: Text(
                      stationList[i].stampGetOrder.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: _utility.getTrainColor(trainName: trainMap[stationList[i].imageFolder]!),
                    child: Text(
                      (i + 1).toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  );
          },
        ),
      );

      keepGetOrder.add(stationList[i].stampGetOrder);
    }
  }
}
