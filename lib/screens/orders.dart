import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:project/generated/l10n.dart';

import 'package:project/auth/auth.dart';
import 'package:project/models/medicine.dart';
import 'package:project/models/order.dart';
import 'package:project/screens/order_details.dart';
import 'package:project/screens/adding_order.dart';
import 'package:project/widgets/tile.dart';

final kFormatter = DateFormat.yMd();

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key, required this.onAddFavorite});

  final bool Function(Medicine medicine) onAddFavorite;

  @override
  State<OrdersScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrdersScreen> {
  final List<Order> _orders = [];
  bool loading = false, cancelOrder = false;

  String orderStatus(Status status) {
    return status == Status.preparing
        ? S.of(context).preparing
        : status == Status.sent
            ? S.of(context).sent
            : S.of(context).arrived;
  }

  void onDeleteOrder(Order order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            S.of(context).deleteOrder,
            style: const TextStyle().copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: Text(
            S.of(context).deleteOrderContent,
            style: const TextStyle().copyWith(
              color: Theme.of(context).colorScheme.primary.withOpacity(.5),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).cancel,
                style: const TextStyle().copyWith(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.7),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  cancelOrder = true;
                });
                final url = Uri.parse('http://192.168.43.246:8000/api/cancel_order');

                final response = await http.delete(
                  url,
                  headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ${Auth.token}'
                  },
                  body: json.encode({'id': order.id}),
                );

                print(response.statusCode);
                if (response.statusCode == 200) {
                  setState(() {
                    _orders.remove(order);
                  });
                } else {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).somethingWrong),
                    ),
                  );
                }
                Navigator.of(context).pop();
              },
              child: cancelOrder
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      S.of(context).deleteOrder,
                      style: const TextStyle().copyWith(color: Colors.red),
                    ),
            ),
          ],
        );
      },
    );
    setState(() {
      cancelOrder = false;
    });
  }

  void _loadOrders() async {
    setState(() {
      loading = true;
    });
    final url = Uri.parse('http://192.168.43.246:8000/api/show_user_orders');
    //final url = Uri.parse('http://127.0.0.1:8000/api/show_user_orders');
    final resopnse = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Auth.token}'
    });

    final orders = json.decode(resopnse.body)['orders'];
    for (final order in orders) {
      final status = order['status'] == 'Preparing'
          ? Status.preparing
          : order['status'] == 'Sent'
              ? Status.sent
              : Status.arrived;
      _orders.add(
        Order(
          id: order['id'],
          status: status,
          orderDate: order['created_at'],
          cost: order['total_cost'],
        ),
      );
    }

    print(resopnse.body);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _loadOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: CircularProgressIndicator(),
    );

    if (!loading) {
      content = _orders.isEmpty
          ? Center(
              child: Text(
                S.of(context).nothingFound,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 30,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  ..._orders.map(
                    (order) {
                      return Tile(
                        leading: Image.asset(
                          'assets/images/order.png',
                          width: 45,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        title: Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.watch_later_outlined),
                            const SizedBox(width: 8.0),
                            Text(orderStatus(order.status)),
                            const SizedBox(width: 16.0),
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 8.0),
                            SizedBox(
                              width: 100,
                              child: Text(
                                order.orderDate,
                                softWrap: true,
                                maxLines: 1,
                                style: const TextStyle()
                                    .copyWith(overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                        subTitle: Row(
                          children: [
                            const SizedBox(width: 16),
                            Text(
                              'ID: ${order.id}       ${S.of(context).price}: ${order.cost}', // replace id with meds //
                            ),
                          ],
                        ),
                        trailing: order.status == Status.preparing
                            ? InkWell(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    size: 16,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                                onTap: () {
                                  onDeleteOrder(order);
                                })
                            : null,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return OrderDetails(
                                  id: order.id,
                                  onAddFavorite: widget.onAddFavorite,
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).orders),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.6),
        child: const Icon(Icons.add),
        onPressed: () async {
          final returnedValue = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return OrdersScreeen(onAddFavorite: widget.onAddFavorite);
              },
            ),
          );

          if (returnedValue != null) {
            setState(() {
              _orders.add(returnedValue);
            });
          }
        },
      ),
      body: content,
    );
  }
}
