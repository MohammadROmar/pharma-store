import 'package:project/models/medicine.dart';

class CategoryItem {
  CategoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
  });

  final int id;
  final Category category;
  final String name;
  final String imagePath;
}
