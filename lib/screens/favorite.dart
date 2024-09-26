import 'package:flutter/material.dart';
import 'package:project/data/data.dart';

import 'package:project/generated/l10n.dart';
import 'package:project/models/category_item.dart';

import 'package:project/screens/medicine_details.dart';
import 'package:project/models/medicine.dart';
import 'package:project/widgets/tile.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    required this.onAddFavorite,
    super.key,
  });

  final bool Function(Medicine medicine) onAddFavorite;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<CategoryItem> cats = [];

  void onRemoveFavorite() {
    setState(() {});
  }

  List<Tile> favorites() {
    List<Tile> favoriteList = [];

    setState(() {
      favoriteList = [
        ...loadedFavorites.map(
          (medicine) => Tile(
            leading: Image.asset(
              medicine.imagePath,
            ),
            title: Text(medicine.commName),
            subTitle: Row(
              children: [
                const SizedBox(width: 8.0),
                const Icon(Icons.category_outlined),
                const SizedBox(width: 4.0),
                SizedBox(
                  width: 80,
                  child: Text(
                    cats
                        .firstWhere((cat) => cat.category == medicine.category)
                        .name,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle()
                        .copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.price_change),
                const SizedBox(width: 4.0),
                Text(medicine.price.toInt().toString()),
                const Spacer(),
                const Icon(Icons.numbers_rounded),
                const SizedBox(width: 4.0),
                Text(medicine.amount.toString()),
                const Spacer(),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MedicineDetailsScreen(
                    onAddFavorite: widget.onAddFavorite,
                    onRemoveFavorite: onRemoveFavorite,
                    medicine: medicine,
                  ),
                ),
              );
            },
          ),
        ),
      ];
    });
    return favoriteList;
  }

  @override
  Widget build(BuildContext context) {
    cats = category(context);

    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).nothingFound,
            textAlign: TextAlign.center,
            style: const TextStyle().copyWith(
              fontSize: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).tryAdd,
            textAlign: TextAlign.center,
            style: const TextStyle().copyWith(
              fontSize: 15,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );

    if (loadedFavorites.isNotEmpty) {
      content = Center(
        child: ListView(
          children: [
            ...favorites(),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PharmaStore'),
        ),
        body: content,
      ),
    );
  }
}
