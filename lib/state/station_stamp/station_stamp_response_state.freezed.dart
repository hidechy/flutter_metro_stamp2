// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station_stamp_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StationStampResponseState {
  Map<String, String> get trainMap => throw _privateConstructorUsedError;
  Map<String, List<StationStamp>> get stationStampMap =>
      throw _privateConstructorUsedError;
  Map<String, List<StationStamp>> get dateStationStampMap =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StationStampResponseStateCopyWith<StationStampResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationStampResponseStateCopyWith<$Res> {
  factory $StationStampResponseStateCopyWith(StationStampResponseState value,
          $Res Function(StationStampResponseState) then) =
      _$StationStampResponseStateCopyWithImpl<$Res, StationStampResponseState>;
  @useResult
  $Res call(
      {Map<String, String> trainMap,
      Map<String, List<StationStamp>> stationStampMap,
      Map<String, List<StationStamp>> dateStationStampMap});
}

/// @nodoc
class _$StationStampResponseStateCopyWithImpl<$Res,
        $Val extends StationStampResponseState>
    implements $StationStampResponseStateCopyWith<$Res> {
  _$StationStampResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainMap = null,
    Object? stationStampMap = null,
    Object? dateStationStampMap = null,
  }) {
    return _then(_value.copyWith(
      trainMap: null == trainMap
          ? _value.trainMap
          : trainMap // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      stationStampMap: null == stationStampMap
          ? _value.stationStampMap
          : stationStampMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<StationStamp>>,
      dateStationStampMap: null == dateStationStampMap
          ? _value.dateStationStampMap
          : dateStationStampMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<StationStamp>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StationStampResponseStateCopyWith<$Res>
    implements $StationStampResponseStateCopyWith<$Res> {
  factory _$$_StationStampResponseStateCopyWith(
          _$_StationStampResponseState value,
          $Res Function(_$_StationStampResponseState) then) =
      __$$_StationStampResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, String> trainMap,
      Map<String, List<StationStamp>> stationStampMap,
      Map<String, List<StationStamp>> dateStationStampMap});
}

/// @nodoc
class __$$_StationStampResponseStateCopyWithImpl<$Res>
    extends _$StationStampResponseStateCopyWithImpl<$Res,
        _$_StationStampResponseState>
    implements _$$_StationStampResponseStateCopyWith<$Res> {
  __$$_StationStampResponseStateCopyWithImpl(
      _$_StationStampResponseState _value,
      $Res Function(_$_StationStampResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainMap = null,
    Object? stationStampMap = null,
    Object? dateStationStampMap = null,
  }) {
    return _then(_$_StationStampResponseState(
      trainMap: null == trainMap
          ? _value._trainMap
          : trainMap // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      stationStampMap: null == stationStampMap
          ? _value._stationStampMap
          : stationStampMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<StationStamp>>,
      dateStationStampMap: null == dateStationStampMap
          ? _value._dateStationStampMap
          : dateStationStampMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<StationStamp>>,
    ));
  }
}

/// @nodoc

class _$_StationStampResponseState implements _StationStampResponseState {
  const _$_StationStampResponseState(
      {final Map<String, String> trainMap = const {},
      final Map<String, List<StationStamp>> stationStampMap = const {},
      final Map<String, List<StationStamp>> dateStationStampMap = const {}})
      : _trainMap = trainMap,
        _stationStampMap = stationStampMap,
        _dateStationStampMap = dateStationStampMap;

  final Map<String, String> _trainMap;
  @override
  @JsonKey()
  Map<String, String> get trainMap {
    if (_trainMap is EqualUnmodifiableMapView) return _trainMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_trainMap);
  }

  final Map<String, List<StationStamp>> _stationStampMap;
  @override
  @JsonKey()
  Map<String, List<StationStamp>> get stationStampMap {
    if (_stationStampMap is EqualUnmodifiableMapView) return _stationStampMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stationStampMap);
  }

  final Map<String, List<StationStamp>> _dateStationStampMap;
  @override
  @JsonKey()
  Map<String, List<StationStamp>> get dateStationStampMap {
    if (_dateStationStampMap is EqualUnmodifiableMapView)
      return _dateStationStampMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dateStationStampMap);
  }

  @override
  String toString() {
    return 'StationStampResponseState(trainMap: $trainMap, stationStampMap: $stationStampMap, dateStationStampMap: $dateStationStampMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StationStampResponseState &&
            const DeepCollectionEquality().equals(other._trainMap, _trainMap) &&
            const DeepCollectionEquality()
                .equals(other._stationStampMap, _stationStampMap) &&
            const DeepCollectionEquality()
                .equals(other._dateStationStampMap, _dateStationStampMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_trainMap),
      const DeepCollectionEquality().hash(_stationStampMap),
      const DeepCollectionEquality().hash(_dateStationStampMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StationStampResponseStateCopyWith<_$_StationStampResponseState>
      get copyWith => __$$_StationStampResponseStateCopyWithImpl<
          _$_StationStampResponseState>(this, _$identity);
}

abstract class _StationStampResponseState implements StationStampResponseState {
  const factory _StationStampResponseState(
          {final Map<String, String> trainMap,
          final Map<String, List<StationStamp>> stationStampMap,
          final Map<String, List<StationStamp>> dateStationStampMap}) =
      _$_StationStampResponseState;

  @override
  Map<String, String> get trainMap;
  @override
  Map<String, List<StationStamp>> get stationStampMap;
  @override
  Map<String, List<StationStamp>> get dateStationStampMap;
  @override
  @JsonKey(ignore: true)
  _$$_StationStampResponseStateCopyWith<_$_StationStampResponseState>
      get copyWith => throw _privateConstructorUsedError;
}
