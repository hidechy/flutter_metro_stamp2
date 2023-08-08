import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/temple.dart';

part 'temple_response_state.freezed.dart';

@freezed
class TempleResponseState with _$TempleResponseState {
  const factory TempleResponseState({
    @Default({}) Map<String, Temple> dateTempleMap,
  }) = _TempleResponseState;
}
