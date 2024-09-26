import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/auth/auth.dart';
import 'package:intl/intl.dart';
import 'package:project/data/data.dart';
import 'package:project/models/category_item.dart';

import 'package:project/models/medicine.dart';
import 'package:project/screens/main.dart';
import 'package:project/screens/medicine_details.dart';
import 'package:project/widgets/tile.dart';

final kFormatter = DateFormat.yMd();

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    super.key,
    required this.id,
    required this.onAddFavorite,
  });

  final int id;
  final bool Function(Medicine medicine) onAddFavorite;
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final List<Medicine> orderMeds = [];
  bool loading = false;

  void loadMeds() async {
    setState(() {
      loading = true;
    });
    final url =
    Uri.parse('http://192.168.43.246:8000/api/show_order_details/${widget.id}');
    //final url =
        //Uri.parse('http://127.0.0.1:8000/api/show_order_details/${widget.id}');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Auth.token}'
      },
    );

    final meds = json.decode(response.body)['data'];
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      for (final med in meds) {
        orderMeds.add(
          Medicine(
            id: med['id'],
            imagePath: categories[med['id']].imagePath,
            scientificName: med['sname'],
            price: med['cost'],
            expiryDate: med['edate'] ??
                kFormatter.format(
                  DateTime(
                    DateTime.now().year,
                  ),
                ),
            company: med['manufacturer'],
            commName: med['cname'],
            category: categories[med['id'] - 1].category,
            amount: med['remain'],
          ),
        );
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loadMeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryItem> cats = category(context);
    Widget content = const Center(
      child: CircularProgressIndicator(),
    );

    if (!loading) {
      content = ListView(
        children: [
          ...orderMeds.map(
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
                  Text(
                    cats
                        .firstWhere((cat) => cat.category == medicine.category)
                        .name,
                  ),
                  const Spacer(),
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
          title: const Text(''),
        ),
        body: content);
  }
}
