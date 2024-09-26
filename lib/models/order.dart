enum Status {
  preparing,
  sent,
  arrived
}

class Order {
  Order({
    required this.id,
    required this.cost,
    required this.status,
    required this.orderDate,
  });

  final int id;
  final Status status;
  final int cost;
  final String orderDate;
}
