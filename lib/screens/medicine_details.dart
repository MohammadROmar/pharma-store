import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:project/auth/auth.dart';
import 'package:project/data/data.dart';

import 'package:project/generated/l10n.dart';
import 'package:project/models/category_item.dart';

import 'package:project/widgets/detail.dart';
import 'package:project/models/medicine.dart';

final kFormatter = DateFormat.yM();

class MedicineDetailsScreen extends StatefulWidget {
  const MedicineDetailsScreen({
    super.key,
    required this.medicine,
    this.onRemoveFavorite,
    required this.onAddFavorite,
  });

  final Medicine medicine;
  final void Function()? onRemoveFavorite;
  final bool Function(Medicine medicine) onAddFavorite;

  @override
  State<MedicineDetailsScreen> createState() => _NewDetailsState();
}

class _NewDetailsState extends State<MedicineDetailsScreen> {
  String? quantity;
  bool loading = false;

  String getFormattedNumber(int num) {
    String strNum = num.toString();
    String temp = '';
    for (int i = 1; i < strNum.length + 1; i++) {
      if (i % 3 == 0 && i != strNum.length) {
        temp += strNum[strNum.length - i];
        temp += ',';
      } else {
        temp += strNum[strNum.length - i];
      }
    }
    strNum = '';
    for (int i = 0; i < temp.length; i++) {
      strNum += temp[temp.length - i - 1];
    }
    return strNum;
  }

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> cats = category(context);

    final isEnglish = Intl.getCurrentLocale() == 'en';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(S.of(context).details),
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.medicine.commName,
            child: Image.asset(
              widget.medicine.imagePath,
              height: 230,
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_information_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.medicine.commName,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 38),
                Align(
                  alignment:
                      isEnglish ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 50,
                    height: 55,
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(isEnglish ? 10 : 0),
                        bottomRight: Radius.circular(isEnglish ? 0 : 10),
                        topLeft: Radius.circular(isEnglish ? 10 : 0),
                        topRight: Radius.circular(isEnglish ? 0 : 10),
                      ),
                    ),
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              final containMed =
                                  loadedFavorites.contains(widget.medicine);
                              final url = Uri.parse(containMed
                                  ? 'http://192.168.43.246:8000/api/favourite/delete/${widget.medicine.id}'
                                  : 'http://192.168.43.246:8000/api/favourite/add/${widget.medicine.id}');
                              final response = containMed
                                  ? await http.delete(
                                      url,
                                      headers: {
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer ${Auth.token}'
                                      },
                                    )
                                  : await http.post(
                                      url,
                                      headers: {
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer ${Auth.token}'
                                      },
                                    );

                              print(response.statusCode);
                              print(response.body);
                              setState(() {
                                final wasAdded =
                                    widget.onAddFavorite(widget.medicine);
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    content: Text(
                                      wasAdded
                                          ? S.of(context).added
                                          : S.of(context).removed,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                );
                                if (widget.onRemoveFavorite != null) {
                                  widget.onRemoveFavorite!();
                                }
                              });
                              setState(() {
                                loading = false;
                              });
                            },
                            icon: Icon(
                              loadedFavorites.contains(widget.medicine)
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 38.0),
                Detail(
                  medicine: widget.medicine,
                  icon: Icons.category_outlined,
                  name: S.of(context).category,
                  detail: cats
                      .firstWhere(
                          (cat) => cat.category == widget.medicine.category)
                      .name,
                ),
                const SizedBox(height: 16),
                Detail(
                  medicine: widget.medicine,
                  icon: Icons.science,
                  name: S.of(context).scientificName,
                  detail: widget.medicine.scientificName,
                ),
                const SizedBox(height: 16),
                Detail(
                  medicine: widget.medicine,
                  icon: Icons.factory,
                  name: S.of(context).company,
                  detail: widget.medicine.company,
                ),
                const SizedBox(height: 16),
                Detail(
                  medicine: widget.medicine,
                  icon: Icons.date_range_rounded,
                  name: S.of(context).expiryDate,
                  detail: widget.medicine.expiryDate,
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 8.0),
                    Text(
                      getFormattedNumber(widget.medicine.price.toInt()),
                      style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              isEnglish ? ' S.P' : ' ل.س',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Text(
                              ' ${S.of(context).perItem}',
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '   ${S.of(context).available}: ${widget.medicine.amount}.',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: isEnglish ? 84 : 77.5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
