// lib/models/category_model.dart
import 'dart:ui';

class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final Color color;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

// lib/models/service_model.dart
class ServiceModel {
  final String id;
  final String name;
  final double price;
  final String categoryId;
  final String description;
  final double rating;

  ServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    required this.description,
    required this.rating,
  });
}