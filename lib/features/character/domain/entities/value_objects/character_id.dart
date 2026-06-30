import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class CharacterId {
  final int value;

  const CharacterId(this.value);

  /// Un ID es válido si es un entero positivo.
  bool get isValid => value > 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CharacterId &&
              runtimeType == other.runtimeType &&
              value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();
}