import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/auth/auth.dart';

import 'package:project/generated/l10n.dart';

import 'package:project/data/data.dart';
import 'package:project/models/order.dart';
import 'package:project/widgets/tile.dart';
import 'package:project/models/medicine.dart';
import 'package:project/widgets/input_field.dart';
import 'package:project/screens/medicine_details.dart';

final url = Uri.parse('http://192.168.43.246:8000/api/order');
//final url = Uri.parse('http://127.0.0.1:8000/api/order');
//

class OrdersScreeen extends StatefulWidget {
  const OrdersScreeen({super.key, required this.onAddFavorite});

  final bool Function(Medicine medicine) onAddFavorite;

  @override
  State<OrdersScreeen> createState() => _OrdersScreeenState();
}

class _OrdersScreeenState extends State<OrdersScreeen> {
  final Map<Medicine, int> medicines = {};
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    String? medicineName;
    String? quantity;
    final formKey = GlobalKey<FormState>();
    final cats = category(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).orders),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          InputField(
                            minLen: 0,
                            text: S.of(context).medName,
                            validate: 'Wrong Input',
                            icon: const Icon(Icons.science_outlined),
                            onSaved: (enteredMed) {
                              medicineName = enteredMed;
                            },
                            inputType: TextInputType.text,
                            obscureText: false,
                          ),
                          const SizedBox(height: 16),
                          InputField(
                            minLen: 1,
                            text: S.of(context).quantity,
                            validate: S.of(context).wrongInput,
                            icon: const Icon(Icons.numbers),
                            onSaved: (enteredQuantity) {
                              quantity = enteredQuantity;
                            },
                            inputType: TextInputType.number,
                            obscureText: false,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(S.of(context).cancel),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    String content = '';
                                    final med = medicineName!.toLowerCase();
                                    print(loadedMedicines);
                                    for (final medicine in loadedMedicines) {
                                      final temp =
                                          medicine.commName.toLowerCase();

                                      print(temp);
                                      if (med == temp &&
                                          int.parse(quantity!) > 0 &&
                                          int.parse(quantity!) <=
                                              medicine.amount) {
                                        setState(() {
                                          if (medicines.containsKey(medicine)) {
                                            final oldOrder = medicines.entries
                                                .firstWhere((order) =>
                                                    order.key == medicine);
                                            medicines.update(
                                              medicine,
                                              (value) =>
                                                  int.parse(quantity!) +
                                                  oldOrder.value,
                                            );
                                          } else {
                                            medicines.addAll({
                                              medicine: int.parse(quantity!)
                                            });
                                          }
                                        });
                                        Navigator.of(context).pop();
                                        content = '';
                                        break;
                                      } else if (med == temp &&
                                          int.parse(quantity!) >
                                              medicine.amount) {
                                        content = S.of(context).invaildQuantity;
                                      } else {
                                        content = S.of(context).cantFind;
                                      }
                                    }
                                    if (content != '') {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            S.of(context).somethingWrong,
                                          ),
                                          content: Text(content),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(S.of(context).ok),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(S.of(context).addOrder),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
          loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    if (medicines.isEmpty) {
                      return;
                    } else {
                      setState(() {
                        loading = true;
                      });
                      final keys = medicines.keys.toList();
                      final values = medicines.values.toList();
                      final meds = [
                        for (int i = 0; i < values.length; i++)
                          {
                            'id': keys[i].id,
                            'amount': values[i],
                          },
                      ];
                      print(meds);
                      print(
                          '1111111111111111111111111111111111111111111111111111111111111');
                      final response = await http.post(
                        url,
                        headers: {
                          'Content-Type': 'application/json',
                          'Authorization': 'Bearer ${Auth.token}'
                        },
                        body: json.encode({
                          'meds': meds,
                        }),
                      );
                      print(response.statusCode);
                      if (response.statusCode == 200) {
                        final order = json.decode(response.body)['order'];
                        print(order);
                        final status = order['status'] == 'Preparing'
                            ? Status.preparing
                            : order['status'] == 'Sent'
                                ? Status.sent
                                : Status.arrived;
                        Navigator.of(context).pop(
                          Order(
                            id: order['id'],
                            cost: order['total_cost'],
                            status: status,
                            orderDate: order['created_at'],
                          ),
                        );
                      }
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                  icon: const Icon(Icons.task_alt_rounded))
        ],
      ),
      body: medicines.isEmpty
          ? Center(
              child: Text(
                S.of(context).tryAdding,
                style: const TextStyle().copyWith(
                    color: Theme.of(context).colorScheme.primary, fontSize: 20),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  ...medicines.entries.map(
                    (medicine) => Tile(
                      leading: Image.asset(
                        medicine.key.imagePath,
                      ),
                      title: Text(medicine.key.commName),
                      subTitle: Row(
                        children: [
                          const Icon(Icons.category_outlined),
                          const SizedBox(width: 4.0),
                          SizedBox(
                            width: 60,
                            child: Text(
                              cats
                                  .firstWhere((cat) =>
                                      cat.category == medicine.key.category)
                                  .name,
                              softWrap: true,
                              maxLines: 1,
                              style: const TextStyle()
                                  .copyWith(overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(Icons.price_change),
                          const SizedBox(width: 4.0),
                          Text(medicine.key.price.toInt().toString()),
                          /*const Spacer(),
                          const Icon(Icons.numbers_rounded),
                          const SizedBox(width: 4.0),
                          Text(medicine.key.amount.toString()),
                          const SizedBox(width: 16),*/
                          const Spacer(),
                          const Icon(Icons.shopping_cart),
                          const SizedBox(width: 4.0),
                          Text(medicine.value.toString()),
                          const SizedBox(width: 12),
                        ],
                      ),
                      trailing: InkWell(
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(
                              100,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.cancel_outlined,
                              size: 16,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            medicines.remove(medicine.key);
                          });
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MedicineDetailsScreen(
                              medicine: medicine.key,
                              onAddFavorite: widget.onAddFavorite,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
