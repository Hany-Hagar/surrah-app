import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 10)
class CategoryModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int color;

  @HiveField(3)
  final String iconId;

  @HiveField(4)
  final bool isIncome;

  @HiveField(5)
  final bool isDeleted;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.iconId,
    required this.isIncome,
    this.isDeleted = false,
  });

  // Copy with 
CategoryModel copyWith({
    String? id,
    String? name,
    int? color,
    String? iconId,
    bool? isIncome,
    bool? isDeleted,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      iconId: iconId ?? this.iconId,
      isIncome: isIncome ?? this.isIncome,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
