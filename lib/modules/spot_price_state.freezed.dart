// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'spot_price_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpotPriceState {
  List<ElectricityPrice> get electricityPrices =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpotPriceStateCopyWith<SpotPriceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotPriceStateCopyWith<$Res> {
  factory $SpotPriceStateCopyWith(
          SpotPriceState value, $Res Function(SpotPriceState) then) =
      _$SpotPriceStateCopyWithImpl<$Res, SpotPriceState>;
  @useResult
  $Res call({List<ElectricityPrice> electricityPrices, bool isLoading});
}

/// @nodoc
class _$SpotPriceStateCopyWithImpl<$Res, $Val extends SpotPriceState>
    implements $SpotPriceStateCopyWith<$Res> {
  _$SpotPriceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? electricityPrices = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      electricityPrices: null == electricityPrices
          ? _value.electricityPrices
          : electricityPrices // ignore: cast_nullable_to_non_nullable
              as List<ElectricityPrice>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpotPriceStateCopyWith<$Res>
    implements $SpotPriceStateCopyWith<$Res> {
  factory _$$_SpotPriceStateCopyWith(
          _$_SpotPriceState value, $Res Function(_$_SpotPriceState) then) =
      __$$_SpotPriceStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ElectricityPrice> electricityPrices, bool isLoading});
}

/// @nodoc
class __$$_SpotPriceStateCopyWithImpl<$Res>
    extends _$SpotPriceStateCopyWithImpl<$Res, _$_SpotPriceState>
    implements _$$_SpotPriceStateCopyWith<$Res> {
  __$$_SpotPriceStateCopyWithImpl(
      _$_SpotPriceState _value, $Res Function(_$_SpotPriceState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? electricityPrices = null,
    Object? isLoading = null,
  }) {
    return _then(_$_SpotPriceState(
      electricityPrices: null == electricityPrices
          ? _value._electricityPrices
          : electricityPrices // ignore: cast_nullable_to_non_nullable
              as List<ElectricityPrice>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SpotPriceState implements _SpotPriceState {
  _$_SpotPriceState(
      {required final List<ElectricityPrice> electricityPrices,
      required this.isLoading})
      : _electricityPrices = electricityPrices;

  final List<ElectricityPrice> _electricityPrices;
  @override
  List<ElectricityPrice> get electricityPrices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_electricityPrices);
  }

  @override
  final bool isLoading;

  @override
  String toString() {
    return 'SpotPriceState(electricityPrices: $electricityPrices, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpotPriceState &&
            const DeepCollectionEquality()
                .equals(other._electricityPrices, _electricityPrices) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_electricityPrices), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpotPriceStateCopyWith<_$_SpotPriceState> get copyWith =>
      __$$_SpotPriceStateCopyWithImpl<_$_SpotPriceState>(this, _$identity);
}

abstract class _SpotPriceState implements SpotPriceState {
  factory _SpotPriceState(
      {required final List<ElectricityPrice> electricityPrices,
      required final bool isLoading}) = _$_SpotPriceState;

  @override
  List<ElectricityPrice> get electricityPrices;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_SpotPriceStateCopyWith<_$_SpotPriceState> get copyWith =>
      throw _privateConstructorUsedError;
}
