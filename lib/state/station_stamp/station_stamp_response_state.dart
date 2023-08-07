import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/station_stamp.dart';

part 'station_stamp_response_state.freezed.dart';

@freezed
class StationStampResponseState with _$StationStampResponseState {
  const factory StationStampResponseState({
    @Default({}) Map<String, String> trainMap,
    @Default([]) List<StationStamp> stationStampList,
    @Default({}) Map<String, List<StationStamp>> stationStampMap,
    @Default({}) Map<String, List<StationStamp>> dateStationStampMap,
  }) = _StationStampResponseState;
}
