import 'package:flutter/material.dart';

import 'package:project/generated/l10n.dart';

import 'package:project/models/medicine.dart';
import 'package:project/data/data.dart';
import 'package:project/screens/medicine_details.dart';
import 'package:project/widgets/tile.dart';

final List<Medicine> meds = [];

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({
    super.key,
    required this.category,
    required this.title,
    required this.onAddFavorite,
  });

  final String title;
  final Category category;
  final bool Function(Medicine medicine) onAddFavorite;

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Medicine> medicines = loadedMedicines
        .where(
            (medicine) => widget.category == medicine.category ? true : false)
        .toList();

    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).nothingFound,
            textAlign: TextAlign.center,
            style: const TextStyle().copyWith(
              fontSize: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).tryElse,
            textAlign: TextAlign.center,
            style: const TextStyle().copyWith(
              fontSize: 15,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );

    if (medicines.isNotEmpty) {
      content = ListView(
        children: [
          ...medicines.map(
            (medicine) => Tile(
              leading: Hero(
                tag: medicine.scientificName,
                child: Image.asset(
                  medicine.imagePath,
                ),
              ),
              title: Text(medicine.commName),
              subTitle: Row(
                children: [
                  const SizedBox(width: 8.0),
                  const Icon(Icons.price_change),
                  const SizedBox(width: 4.0),
                  Text(medicine.price.toInt().toString()),
                  const Spacer(),
                  const Icon(Icons.numbers_rounded),
                  const SizedBox(width: 4.0),
                  Text(medicine.amount.toString()),
                  const SizedBox(width: 16),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MedicineDetailsScreen(
                      medicine: medicine,
                      onAddFavorite: widget.onAddFavorite,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: content,
    );
  }
}
