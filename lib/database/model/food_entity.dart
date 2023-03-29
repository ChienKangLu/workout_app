import '../schema.dart';
import 'base_entity.dart';

class FoodEntity extends BaseEntity {
  FoodEntity({
    required this.id,
    required this.brandName,
    required this.name,
    required this.energy,
    required this.fat,
    required this.carbohydrate,
    required this.protein,
    required this.sodium,
  });

  FoodEntity.create({
    String brandName = "",
    required String name,
    double energy = 0,
    double fat = 0,
    double carbohydrate = 0,
    double protein = 0,
    double sodium = 0,
  }) : this(
          id: ignored,
          brandName: brandName,
          name: name,
          energy: energy,
          fat: fat,
          carbohydrate: carbohydrate,
          protein: protein,
          sodium: sodium,
        );

  FoodEntity.update({
    required int id,
    required String brandName,
    required String name,
    required double energy,
    required double fat,
    required double carbohydrate,
    required double protein,
    required double sodium,
  }) : this(
          id: id,
          brandName: brandName,
          name: name,
          energy: energy,
          fat: fat,
          carbohydrate: carbohydrate,
          protein: protein,
          sodium: sodium,
        );

  FoodEntity.fromMap(Map<String, dynamic> map)
      : this(
          id: map[FoodTable.columnFoodId],
          brandName: map[FoodTable.columnFoodBrandName],
          name: map[FoodTable.columnFoodName],
          energy: map[FoodTable.columnFoodEnergy],
          fat: map[FoodTable.columnFoodFat],
          carbohydrate: map[FoodTable.columnFoodCarbohydrate],
          protein: map[FoodTable.columnFoodProtein],
          sodium: map[FoodTable.columnFoodSodium],
        );

  final int id;
  final String brandName;
  final String name;
  final double energy;
  final double fat;
  final double carbohydrate;
  final double protein;
  final double sodium;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != ignored) {
      map[FoodTable.columnFoodId] = id;
    }
    map[FoodTable.columnFoodBrandName] = brandName;
    map[FoodTable.columnFoodName] = name;
    map[FoodTable.columnFoodEnergy] = energy;
    map[FoodTable.columnFoodFat] = fat;
    map[FoodTable.columnFoodCarbohydrate] = carbohydrate;
    map[FoodTable.columnFoodProtein] = protein;
    map[FoodTable.columnFoodSodium] = sodium;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          brandName == other.brandName &&
          name == other.name &&
          energy == other.energy &&
          fat == other.fat &&
          carbohydrate == other.carbohydrate &&
          protein == other.protein &&
          sodium == other.sodium;

  @override
  int get hashCode =>
      id.hashCode ^
      brandName.hashCode ^
      name.hashCode ^
      energy.hashCode ^
      fat.hashCode ^
      carbohydrate.hashCode ^
      protein.hashCode ^
      sodium.hashCode;
}
