import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../model/station_stamp.dart';
import '../utility/utility.dart';

class StationInfoAlert extends ConsumerWidget {
  StationInfoAlert({super.key, required this.stamp});

  final StationStamp? stamp;

  final Utility _utility = Utility();

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = (stamp != null)
        ? 'http://toyohide.work/BrainLog/station_stamp/${stamp!.imageFolder}/${stamp!.imageCode}.png'
        : '';

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),
                if (stamp != null) ...[
                  DefaultTextStyle(
                    style: TextStyle(
                      color: _utility.getTrainColor(trainName: stamp!.trainName),
                    ),
                    child: Row(
                      children: [
                        Text(stamp!.trainName),
                        const SizedBox(width: 20),
                        Text(stamp!.imageCode),
                      ],
                    ),
                  ),
                  Text(stamp!.stationName),
                  Divider(
                    color: Colors.white.withOpacity(0.4),
                    thickness: 2,
                  ),
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/no_image.png',
                    image: image,
                    imageErrorBuilder: (c, o, s) => Image.asset('assets/images/no_image.png'),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.4),
                    thickness: 2,
                  ),
                  Text(stamp!.posterPosition),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text('${stamp!.stampGetDate} 取得'),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
