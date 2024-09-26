import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:project/auth/auth.dart';
import 'package:project/data/data.dart';
import 'package:project/generated/l10n.dart';
import 'package:project/models/category_item.dart';
import 'package:project/screens/medicine_details.dart';
import 'package:project/widgets/item.dart';
import 'package:project/models/user.dart';
import 'package:project/models/medicine.dart';
import 'package:project/widgets/tile.dart';

List<Medicine> meds = [];
List<CategoryItem> categories = [];
final kFormatter = DateFormat.yMd();

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool loading = false;
  String show = 'Categories';

  bool onAddFavorite(Medicine medicine) {
    final isFavorites = loadedFavorites.contains(medicine);
    setState(() {
      if (isFavorites) {
        removeFav(medicine);
      } else {
        addFav(medicine);
      }
    });
    return !isFavorites;
  }

  void loadFavorite() async {
    final List<Medicine> favList = [];
    setState(() {
      loading = true;
    });
    final url = Uri.parse('http://192.168.43.246:8000/api/favourite');
    //final url = Uri.parse('http://127.0.0.1:8000/api/favourite');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Auth.token}'
      },
    );
    print('faaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaav');
    print(response.statusCode);
    final List<dynamic> favorites = json.decode(response.body)['favs'];
    print(favorites);

    for (final favorite in favorites) {
      for (final med in favorite) {
        favList.add(
          Medicine(
            id: med['id'],
            imagePath: categories[med['id'] - 1].imagePath,
            scientificName: med['sname'],
            price: med['cost'],
            expiryDate: med['edate'] ??
                kFormatter.format(DateTime(DateTime.now().year + 1)),
            company: med['manufacturer'],
            commName: med['cname'],
            category: categories[med['id'] - 1].category,
            amount: med['remain'],
          ),
        );
      }
    }
    addFavs(favList);
    setState(() {
      loading = false;
    });
  }

  void medicine() async {
    setState(() {
      loading = true;
    });
    //final url = Uri.parse('http://127.0.0.1:8000/api/all');
    final url = Uri.parse('http://192.168.43.246:8000/api/all');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Auth.token}'
    });
    if (response.statusCode < 300) {
      final medicines = json.decode(response.body)['meds'];
      print(response.statusCode);
      print(response.body);
      for (final medicine in medicines) {
        meds.add(
          Medicine(
            id: medicine['id'],
            imagePath: categories[medicine['category_id'] - 1].imagePath,
            scientificName: medicine['sname'],
            price: medicine['cost'],
            expiryDate: medicine['edate'] ??
                kFormatter.format(DateTime(DateTime.now().year + 1)),
            company: medicine['manufacturer'],
            commName: medicine['cname'],
            category: categories[medicine['category_id'] - 1].category,
            amount: medicine['remain'],
          ),
        );
      }
      addMeds(meds);
      meds = [];
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    medicine();
    loadFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryItem> cats = category(context);

    categories = category(context);
    show = S.of(context).cats;

    Widget content = const Center(
      child: CircularProgressIndicator(),
    );

    if (!loading) {
      content = show == S.of(context).cats
          ? GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                ...categories.map(
                  (category) => Item(
                    text: category.name,
                    image: category.imagePath,
                    category: category.category,
                    height: double.infinity,
                    onAddFavorite: onAddFavorite,
                  ),
                ),
              ],
            )
          : ListView(
              children: [
                ...loadedMedicines.map(
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
                                .firstWhere(
                                    (cat) => cat.category == medicine.category)
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
                            onAddFavorite: onAddFavorite,
                            medicine: medicine,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
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
