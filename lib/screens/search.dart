import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:project/generated/l10n.dart';
import 'package:project/models/category_item.dart';

import 'package:project/models/medicine.dart';
import 'package:project/data/data.dart';
import 'package:project/screens/medicine_details.dart';
import 'package:project/widgets/tile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onAddFavorite});

  final bool Function(Medicine medicine) onAddFavorite;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<CategoryItem> categories = [];
  String? _searchText;
  int _currentIndex = 0;
  List<Medicine> _searchResult = [];
  Category _selectedCategory = Category.antibiotics;

  @override
  Widget build(BuildContext context) {
    categories = category(context);

    List<Medicine> medicines = loadedMedicines
        .where((medicine) => _selectedCategory == medicine.category)
        .toList();

    if (_searchText != null && _searchText!.trim().isNotEmpty) {
      medicines = loadedMedicines
          .where((medicine) => _selectedCategory == medicine.category &&
                  medicine.commName
                      .toLowerCase()
                      .contains(_searchText!.toLowerCase())
              ? true
              : false)
          .toList();
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size(
              double.infinity, Intl.getCurrentLocale() == 'en' ? 300 : 315),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  Align(
                    alignment: Intl.getCurrentLocale() == 'en'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Text(
                      S.of(context).search,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SearchBar(
                    hintText: S.of(context).type,
                    leading: const Icon(Icons.search),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value.toLowerCase();
                        if (_searchText == null ||
                            _searchText!.trim().isEmpty) {
                          _searchResult = [];
                          return;
                        }
                        if (!(_searchText!.isEmpty ||
                            _searchText!.trim().isEmpty)) {
                          _searchResult = loadedMedicines.where((medicine) {
                            final commName = medicine.commName.toLowerCase();
                            return (commName.contains(_searchText!)) &&
                                    medicine.category == _selectedCategory
                                ? true
                                : false;
                          }).toList();
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Intl.getCurrentLocale() == 'en'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Text(
                      '${S.of(context).category} : ',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SalomonBottomBar(
                          currentIndex: _currentIndex,
                          curve: Curves.fastOutSlowIn,
                          onTap: (index) {
                            setState(() {
                              _currentIndex = index;
                              _selectedCategory =
                                  categories[_currentIndex].category;
                              _searchResult = [];
                            });
                          },
                          itemShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          items: [
                            ...categories.map(
                              (category) => SalomonBottomBarItem(
                                icon: Row(
                                  children: [
                                    SizedBox(
                                      width:
                                          _selectedCategory == category.category
                                              ? 10
                                              : 0,
                                    ),
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 30,
                                          child:
                                              Image.asset(category.imagePath),
                                        ),
                                        Text(
                                          category.category.name,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                title: const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ((_searchResult.isEmpty &&
                    medicines.isEmpty &&
                    (_searchText != null && _searchText!.trim().isNotEmpty)) ||
                _searchResult.isEmpty && medicines.isEmpty)
            ? Center(
                child: Text(
                  S.of(context).nothingFound,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              )
            : ListView(
                children: [
                  ...(_searchResult.isEmpty ? medicines : _searchResult).map(
                    (medicine) => Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(.4),
                          Theme.of(context).colorScheme.primary.withOpacity(.1),
                        ]),
                      ),
                      child: Tile(
                        leading: Image.asset(
                          medicine.imagePath,
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
                                  onAddFavorite: widget.onAddFavorite,
                                  medicine: medicine),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ));
  }
}
