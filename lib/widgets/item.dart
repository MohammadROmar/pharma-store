import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:project/screens/medicine_details.dart';
import 'package:project/screens/medicines.dart';
import 'package:project/models/medicine.dart';

final kFormatter = DateFormat.yM();

class Item extends StatelessWidget {
  const Item(
      {super.key,
      required this.text,
      required this.image,
      required this.category,
      required this.height,
      this.medicine,
      required this.onAddFavorite,
      this.onRemoveFavorite});

  final String text;
  final String image;
  final Category category;
  final double height;
  final Medicine? medicine;
  final bool Function(Medicine medicine) onAddFavorite;
  final List<Item> Function()? onRemoveFavorite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => medicine != null
              ? MedicineDetailsScreen(
                  medicine: medicine!,
                  onAddFavorite: onAddFavorite,
                  onRemoveFavorite: onRemoveFavorite,
                )
              : MedicinesScreen(
                  category: category,
                  title: text,
                  onAddFavorite: onAddFavorite,
                ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: Image.asset(
                  image,
                  height: height,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ).image,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  color: Theme.of(context).colorScheme.primary.withOpacity(.8),
                  child: Column(
                    children: [
                      Text(
                        text,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      medicine == null
                          ? const SizedBox(height: 12)
                          : Row(
                              children: [
                                const Icon(
                                  Icons.date_range_rounded,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  medicine!.expiryDate,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.medical_information_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(medicine!.company),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
