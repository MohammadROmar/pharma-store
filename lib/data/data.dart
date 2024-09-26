import 'package:flutter/material.dart';

import 'package:project/generated/l10n.dart';

import 'package:project/models/category_item.dart';
import 'package:project/models/medicine.dart';

List<Medicine> loadedMedicines = [];

void addMeds(List<Medicine> meds) {
  for (final medicine in meds) {
    loadedMedicines.add(medicine);
  }
}

void clearMeds() {
  loadedMedicines = [];
}

List<Medicine> loadedFavorites = [];

void addFavs(List<Medicine> meds) {
  for (final medicine in meds) {
    loadedFavorites.add(medicine);
  }
}

void addFav(Medicine medicine) {
  loadedFavorites.add(medicine);
}

void removeFav(Medicine medicine) {
  loadedFavorites.remove(medicine);
}

void clearFavorite() {
  loadedFavorites = [];
}

List<CategoryItem> category(BuildContext context) {
  final List<CategoryItem> cats = [
    CategoryItem(
      id: 1,
      name: S.of(context).antibiotics,
      category: Category.antibiotics,
      imagePath: 'assets/images/antibiotics.png',
    ),
    CategoryItem(
      id: 2,
      name: S.of(context).obesity,
      category: Category.obesity,
      imagePath: 'assets/images/obesity.png',
    ),
    CategoryItem(
      id: 3,
      name: S.of(context).antidiabetic,
      category: Category.antidiabetic,
      imagePath: 'assets/images/antidiabetic.png',
    ),
    CategoryItem(
      id: 4,
      name: S.of(context).cardiovascular,
      category: Category.cardiovascular,
      imagePath: 'assets/images/cardiovascular.png',
    ),
    CategoryItem(
      id: 5,
      name: S.of(context).neurologicalPsychlogical,
      category: Category.neurologicalPsychlogical,
      imagePath: 'assets/images/neurologicalPsychlogical.png',
    ),
    CategoryItem(
      id: 6,
      name: S.of(context).nsaidsAnalgesicsAntipyretic,
      category: Category.nsaidsAnalgesicsAntipyretic,
      imagePath: 'assets/images/nsaidsAnalgesicsAntipyretic.png',
    ),
    CategoryItem(
      id: 7,
      name: S.of(context).gastrointestinal,
      category: Category.gastrointestinal,
      imagePath: 'assets/images/gastrointestinal.png',
    ),
    CategoryItem(
      id: 8,
      name: S.of(context).respiratory,
      category: Category.respiratory,
      imagePath: 'assets/images/respiratory.png',
    ),
    CategoryItem(
      id: 9,
      name: S.of(context).musculoskeletal,
      category: Category.musculoskeletal,
      imagePath: 'assets/images/musculoskeletal.png',
    ),
    CategoryItem(
      id: 10,
      name: S.of(context).urological,
      category: Category.urological,
      imagePath: 'assets/images/urological.png',
    ),
    CategoryItem(
      id: 11,
      name: S.of(context).dermatological,
      category: Category.dermatological,
      imagePath: 'assets/images/dermatological.png',
    ),
    CategoryItem(
      id: 12,
      name: S.of(context).vitaminsMinerals,
      category: Category.vitaminsMinerals,
      imagePath: 'assets/images/vitaminsMinerals.png',
    ),
    CategoryItem(
      id: 13,
      name: S.of(context).foodSupplement,
      category: Category.foodSupplement,
      imagePath: 'assets/images/foodSupplement.png',
    ),
  ];

  return cats;
}

final List<String> categoryNames = [
  "Antibiotics",
  "Obesity Drugs",
  "Antidiabetic Drugs",
  "Cardiovascular Drugs",
  "Neurological & Psychological Drugs",
  "NSAIDs & Analgesics & Antipyretic Drugs",
  "Gastrointestinal Drugs",
  "Respiratory Tact Drugs",
  "Musculoskeletal Drugs",
  "Urological Drugs",
  "Dermatological Drugs",
  "Vitamins & Minerals",
  "Food Supplements",
];
/*
 assets/images/antibiotics.png
 assets/images/obesity.png
 assets/images/antidiabetic.png
 assets/images/cardiovascular.png
 assets/images/neurologicalPsychlogical.png
 assets/images/nsaidsAnalgesicsAntipyretic.png
 assets/images/gastrointestinal.png
 assets/images/respiratory.png
 assets/images/musculoskeletal.png
 assets/images/urological.png
 assets/images/dermatological.png
 assets/images/vitaminsMinerals.png
 assets/images/foodSupplement.png
  */