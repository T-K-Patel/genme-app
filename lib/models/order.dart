class Order {
  late String id;
  late String clientName;
  late int itemsCount;
  late String status;
  late DateTime createdAt;
  late DateTime updatedAt;
  double? deliveryCharge;
  DateTime? deliveryDate;
  double? discount;

  Order({
    required this.id,
    required this.clientName,
    required this.itemsCount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deliveryCharge,
    this.deliveryDate,
    this.discount,
  });

  // Factory constructor to create an Order from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      clientName: json['client']['legal_name'] ?? 'Unknown Client',
      itemsCount: json['items_count'] as int,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deliveryCharge: json['delivery_charge'] != null
          ? double.tryParse(json['delivery_charge'].toString())
          : null,
      deliveryDate: json['delivery_date'] != null
          ? DateTime.tryParse(json['delivery_date'])
          : null,
      discount: json['discount'] != null
          ? double.tryParse(json['discount'].toString())
          : null,
    );
  }

  // Method to convert Order to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'itemsCount': itemsCount,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deliveryCharge': deliveryCharge?.toString(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'discount': discount?.toString(),
    };
  }

  @override
  String toString() {
    return 'Order(id: $id, clientName: $clientName, itemsCount: $itemsCount, '
        'status: $status, createdAt: $createdAt, updatedAt: $updatedAt, '
        'deliveryCharge: $deliveryCharge, deliveryDate: $deliveryDate, discount: $discount)';
  }
}
