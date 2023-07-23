// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pressure_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PressureItem {
  String? get uuid => throw _privateConstructorUsedError;
  int? get maxPressure => throw _privateConstructorUsedError;
  int? get minPressure => throw _privateConstructorUsedError;
  int? get pulse => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PressureItemCopyWith<PressureItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PressureItemCopyWith<$Res> {
  factory $PressureItemCopyWith(
          PressureItem value, $Res Function(PressureItem) then) =
      _$PressureItemCopyWithImpl<$Res, PressureItem>;
  @useResult
  $Res call({String? uuid, int? maxPressure, int? minPressure, int? pulse});
}

/// @nodoc
class _$PressureItemCopyWithImpl<$Res, $Val extends PressureItem>
    implements $PressureItemCopyWith<$Res> {
  _$PressureItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? maxPressure = freezed,
    Object? minPressure = freezed,
    Object? pulse = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPressure: freezed == maxPressure
          ? _value.maxPressure
          : maxPressure // ignore: cast_nullable_to_non_nullable
              as int?,
      minPressure: freezed == minPressure
          ? _value.minPressure
          : minPressure // ignore: cast_nullable_to_non_nullable
              as int?,
      pulse: freezed == pulse
          ? _value.pulse
          : pulse // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PressureItemCopyWith<$Res>
    implements $PressureItemCopyWith<$Res> {
  factory _$$_PressureItemCopyWith(
          _$_PressureItem value, $Res Function(_$_PressureItem) then) =
      __$$_PressureItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? uuid, int? maxPressure, int? minPressure, int? pulse});
}

/// @nodoc
class __$$_PressureItemCopyWithImpl<$Res>
    extends _$PressureItemCopyWithImpl<$Res, _$_PressureItem>
    implements _$$_PressureItemCopyWith<$Res> {
  __$$_PressureItemCopyWithImpl(
      _$_PressureItem _value, $Res Function(_$_PressureItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? maxPressure = freezed,
    Object? minPressure = freezed,
    Object? pulse = freezed,
  }) {
    return _then(_$_PressureItem(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPressure: freezed == maxPressure
          ? _value.maxPressure
          : maxPressure // ignore: cast_nullable_to_non_nullable
              as int?,
      minPressure: freezed == minPressure
          ? _value.minPressure
          : minPressure // ignore: cast_nullable_to_non_nullable
              as int?,
      pulse: freezed == pulse
          ? _value.pulse
          : pulse // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_PressureItem implements _PressureItem {
  const _$_PressureItem(
      {this.uuid, this.maxPressure, this.minPressure, this.pulse});

  @override
  final String? uuid;
  @override
  final int? maxPressure;
  @override
  final int? minPressure;
  @override
  final int? pulse;

  @override
  String toString() {
    return 'PressureItem(uuid: $uuid, maxPressure: $maxPressure, minPressure: $minPressure, pulse: $pulse)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PressureItem &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.maxPressure, maxPressure) ||
                other.maxPressure == maxPressure) &&
            (identical(other.minPressure, minPressure) ||
                other.minPressure == minPressure) &&
            (identical(other.pulse, pulse) || other.pulse == pulse));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, maxPressure, minPressure, pulse);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PressureItemCopyWith<_$_PressureItem> get copyWith =>
      __$$_PressureItemCopyWithImpl<_$_PressureItem>(this, _$identity);
}

abstract class _PressureItem implements PressureItem {
  const factory _PressureItem(
      {final String? uuid,
      final int? maxPressure,
      final int? minPressure,
      final int? pulse}) = _$_PressureItem;

  @override
  String? get uuid;
  @override
  int? get maxPressure;
  @override
  int? get minPressure;
  @override
  int? get pulse;
  @override
  @JsonKey(ignore: true)
  _$$_PressureItemCopyWith<_$_PressureItem> get copyWith =>
      throw _privateConstructorUsedError;
}
