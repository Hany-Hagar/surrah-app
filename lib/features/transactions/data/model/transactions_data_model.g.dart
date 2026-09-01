// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionsDataModelAdapter extends TypeAdapter<TransactionsDataModel> {
  @override
  final int typeId = 4;

  @override
  TransactionsDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionsDataModel(
      currentBalance: fields[0] as BalanceModel,
      transactions: (fields[1] as List).cast<TransactionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionsDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.currentBalance)
      ..writeByte(1)
      ..write(obj.transactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionsDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
