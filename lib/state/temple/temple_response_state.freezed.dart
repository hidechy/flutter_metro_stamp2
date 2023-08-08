// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temple_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TempleResponseState {
  Map<String, Temple> get dateTempleMap => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempleResponseStateCopyWith<TempleResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempleResponseStateCopyWith<$Res> {
  factory $TempleResponseStateCopyWith(
          TempleResponseState value, $Res Function(TempleResponseState) then) =
      _$TempleResponseStateCopyWithImpl<$Res, TempleResponseState>;
  @useResult
  $Res call({Map<String, Temple> dateTempleMap});
}

/// @nodoc
class _$TempleResponseStateCopyWithImpl<$Res, $Val extends TempleResponseState>
    implements $TempleResponseStateCopyWith<$Res> {
  _$TempleResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTempleMap = null,
  }) {
    return _then(_value.copyWith(
      dateTempleMap: null == dateTempleMap
          ? _value.dateTempleMap
          : dateTempleMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Temple>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TempleResponseStateCopyWith<$Res>
    implements $TempleResponseStateCopyWith<$Res> {
  factory _$$_TempleResponseStateCopyWith(_$_TempleResponseState value,
          $Res Function(_$_TempleResponseState) then) =
      __$$_TempleResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, Temple> dateTempleMap});
}

/// @nodoc
class __$$_TempleResponseStateCopyWithImpl<$Res>
    extends _$TempleResponseStateCopyWithImpl<$Res, _$_TempleResponseState>
    implements _$$_TempleResponseStateCopyWith<$Res> {
  __$$_TempleResponseStateCopyWithImpl(_$_TempleResponseState _value,
      $Res Function(_$_TempleResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTempleMap = null,
  }) {
    return _then(_$_TempleResponseState(
      dateTempleMap: null == dateTempleMap
          ? _value._dateTempleMap
          : dateTempleMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Temple>,
    ));
  }
}

/// @nodoc

class _$_TempleResponseState implements _TempleResponseState {
  const _$_TempleResponseState(
      {final Map<String, Temple> dateTempleMap = const {}})
      : _dateTempleMap = dateTempleMap;

  final Map<String, Temple> _dateTempleMap;
  @override
  @JsonKey()
  Map<String, Temple> get dateTempleMap {
    if (_dateTempleMap is EqualUnmodifiableMapView) return _dateTempleMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dateTempleMap);
  }

  @override
  String toString() {
    return 'TempleResponseState(dateTempleMap: $dateTempleMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TempleResponseState &&
            const DeepCollectionEquality()
                .equals(other._dateTempleMap, _dateTempleMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_dateTempleMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TempleResponseStateCopyWith<_$_TempleResponseState> get copyWith =>
      __$$_TempleResponseStateCopyWithImpl<_$_TempleResponseState>(
          this, _$identity);
}

abstract class _TempleResponseState implements TempleResponseState {
  const factory _TempleResponseState(
      {final Map<String, Temple> dateTempleMap}) = _$_TempleResponseState;

  @override
  Map<String, Temple> get dateTempleMap;
  @override
  @JsonKey(ignore: true)
  _$$_TempleResponseStateCopyWith<_$_TempleResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
