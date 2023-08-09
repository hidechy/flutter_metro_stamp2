import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/walk_record.dart';

part 'walk_record_response_state.freezed.dart';

@freezed
class WalkRecordResponseState with _$WalkRecordResponseState {
  const factory WalkRecordResponseState({
    @Default([]) List<WalkRecord> walkRecordList,
    @Default({}) Map<String, WalkRecord> walkRecordMap,
  }) = _WalkRecordResponseState;
}
