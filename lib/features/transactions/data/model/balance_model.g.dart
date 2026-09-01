// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BalanceModelAdapter extends TypeAdapter<BalanceModel> {
  @override
  final int typeId = 3;

  @override
  BalanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BalanceModel(
      balance: fields[0] as double,
      totalIncome: fields[2] as double,
      totalExpense: fields[3] as double,
      percentage: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BalanceModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.percentage)
      ..writeByte(2)
      ..write(obj.totalIncome)
      ..writeByte(3)
      ..write(obj.totalExpense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BalanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
