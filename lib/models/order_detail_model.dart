class OrderItem {
  final String id;
  final String product;
  final int? quantity;
  final String? batchNumber;
  final String? company;
  final String? expiryDate;
  final double? mrp;
  final double? price;
  final String? hsn;
  final double? sgst;
  final double? cgst;
  final bool? supplied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String order;

  OrderItem({
    required this.id,
    required this.product,
    this.quantity,
    this.batchNumber,
    this.company,
    this.expiryDate,
    this.mrp,
    this.price,
    this.hsn,
    this.sgst,
    this.cgst,
    this.supplied,
    required this.createdAt,
    required this.updatedAt,
    required this.order,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      product: json['product'],
      quantity: json['quantity'],
      batchNumber: json['batch_number'],
      company: json['company'],
      expiryDate: json['expiry_date'],
      mrp: json['mrp'] != null ? double.tryParse(json['mrp'].toString()) : null,
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      hsn: json['hsn'],
      sgst: json['sgst'] != null
          ? double.tryParse(json['sgst'].toString())
          : null,
      cgst: json['cgst'] != null
          ? double.tryParse(json['cgst'].toString())
          : null,
      supplied: json['supplied'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      order: json['order'],
    );
  }
}

class OrderDetailModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<OrderItem> items;
  final String? status;
  final double? total;
  final double? deliveryCharge;
  final double? discount;
  final DateTime? deliveryDate;
  final Client client;
  final Distributer? distributer;
  final Invoice? invoice;

  OrderDetailModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.items,
    this.status,
    this.total,
    this.deliveryCharge,
    this.discount,
    this.deliveryDate,
    required this.client,
    required this.distributer,
    this.invoice,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    double calculatedTotal = 0.0;
    if (json['items'] != null) {
      for (var item in json['items']) {
        double itemPrice = item['price'] != null
            ? double.tryParse(item['price'].toString()) ?? 0.0
            : 0.0;
        calculatedTotal += item['quantity'] * itemPrice;
      }
    }

    return OrderDetailModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      status: json['status'] ?? 'Unknown',
      total: json['total'] != null
          ? double.tryParse(json['total'].toString()) ?? calculatedTotal
          : calculatedTotal,
      deliveryCharge: json['delivery_charge'] != null
          ? double.tryParse(json['delivery_charge'].toString()) ?? 0.0
          : 0.0,
      discount: json['discount'] != null
          ? double.tryParse(json['discount'].toString()) ?? 0.0
          : 0.0,
      deliveryDate: json['delivery_date'] != null
          ? DateTime.tryParse(json['delivery_date'])
          : null,
      client: Client.fromJson(json['client']),
      distributer: json['distributer'] != null
          ? Distributer.fromJson(json['distributer'])
          : null, // Handle nullable distributer
      invoice: json['invoice'] != null
          ? Invoice.fromJson(json['invoice'])
          : null, // Handle nullable invoice
    );
  }
}

class Invoice {
  final String? id;
  final String? invoiceNumber;
  final String? invoiceDate;
  final String? url;

  Invoice({
    this.id,
    this.invoiceNumber,
    this.invoiceDate,
    this.url,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      invoiceNumber: json['invoice_number'],
      invoiceDate: json['invoice_date'],
      url: json['url'],
    );
  }
}

class Client {
  final String? id;
  final String? username;
  final String? role;
  final String? legalName;
  final String? panNumber;
  final String? gstin;
  final String? dlNo;
  final String? address;

  Client({
    this.id,
    this.username,
    this.role,
    this.legalName,
    this.panNumber,
    this.gstin,
    this.dlNo,
    this.address,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['user']['id'],
      username: json['user']['username'],
      role: json['role'],
      legalName: json['legal_name'],
      panNumber: json['pan_number'],
      gstin: json['gstin'],
      dlNo: json['dl_no'],
      address: json['address'],
    );
  }
}

class Distributer {
  final String? user;
  final String? role;
  final String? legalName;
  final String? panNumber;
  final String? gstin;
  final String? dlNo;
  final String? address;

  Distributer({
    this.user,
    this.role,
    this.legalName,
    this.panNumber,
    this.gstin,
    this.dlNo,
    this.address,
  });

  factory Distributer.fromJson(Map<String, dynamic> json) {
    return Distributer(
      user: json['user'],
      role: json['role'],
      legalName: json['legal_name'],
      panNumber: json['pan_number'],
      gstin: json['gstin'],
      dlNo: json['dl_no'],
      address: json['address'],
    );
  }
}
