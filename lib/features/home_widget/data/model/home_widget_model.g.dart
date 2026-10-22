// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeWidgetModelAdapter extends TypeAdapter<HomeWidgetModel> {
  @override
  final int typeId = 5;

  @override
  HomeWidgetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeWidgetModel(
      balance: fields[1] as double,
      showBalance: fields[0] as bool,
      enableCard: fields[2] as bool,
      showIncomeButton: fields[3] as bool,
      showExpenseButton: fields[4] as bool,
      showAddCategoryButton: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HomeWidgetModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.showBalance)
      ..writeByte(1)
      ..write(obj.balance)
      ..writeByte(2)
      ..write(obj.enableCard)
      ..writeByte(3)
      ..write(obj.showIncomeButton)
      ..writeByte(4)
      ..write(obj.showExpenseButton)
      ..writeByte(5)
      ..write(obj.showAddCategoryButton);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeWidgetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
