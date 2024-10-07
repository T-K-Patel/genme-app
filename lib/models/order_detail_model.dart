// lib/models/order_item_model.dart



class OrderItem {
  final String id;
  final String product;
  final int quantity;
  final String? batchNumber;
  final String? company;
  final String? expiryDate;
  final double? mrp;
  final double? price;
  final String? hsn;
  final bool? supplied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String order;

  OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.batchNumber,
    this.company,
    this.expiryDate,
    this.mrp,
    this.price,
    this.hsn,
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
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      hsn: json['hsn'],
      supplied: json['supplied'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      order: json['order'],
    );
  }
}


class OrderDetailModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItem> items;
  final String status;
  final double total;
  final double deliveryCharge;
  final double discount;
  final DateTime? deliveryDate;
  final Client client;
  final Distributer distributer;
  final Invoice? invoice;

  OrderDetailModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.status,
    required this.total,
    required this.deliveryCharge,
    required this.discount,
    this.deliveryDate,
    required this.client,
    required this.distributer,
    required this.invoice,
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
      distributer: Distributer.fromJson(json['distributer']),
      invoice: Invoice.fromJson(json['invoice']),
      // invoice: null,
    );
  }
}



class Invoice {
  final String id;
  final String invoiceDate;
  final String url;

  Invoice({
    required this.id,
    required this.invoiceDate,
    required this.url,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      invoiceDate: json['invoice_date'],
      url: json['url'],
    );
  }
}

class Client {
  final String id;
  final String username;
  final String role;
  final String legalName;
  final String panNumber;
  final String gstin;
  final String dlNo;
  final String address;

  Client({
    required this.id,
    required this.username,
    required this.role,
    required this.legalName,
    required this.panNumber,
    required this.gstin,
    required this.dlNo,
    required this.address,
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
  final String user;
  final String role;
  final String legalName;
  final String panNumber;
  final String gstin;
  final String dlNo;
  final String address;

  Distributer({
    required this.user,
    required this.role,
    required this.legalName,
    required this.panNumber,
    required this.gstin,
    required this.dlNo,
    required this.address,
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


// // lib/models/order_detail_model.dart

// class OrderDetailModel {
//   final String id;
//   final String date;
//   final String total;
//   final String status;

//   OrderDetailModel({
//     required this.id,
//     required this.date,
//     required this.total,
//     required this.status,
//   });

//   factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
//     return OrderDetailModel(
//       id: json['id'],
//       date: json['date'],
//       total: json['total'],
//       status: json['status'],
//     );
//   }
// }


// class OrderDetailModel {
//   final String id;
//   final String date;
//   final String total;
//   final String status;

//   OrderDetailModel({
//     required this.id,
//     required this.date,
//     required this.total,
//     required this.status,
//   });

//   factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
//     return OrderDetailModel(
//       id: json['id'],
//       date: json['date'],
//       total: json['total'],
//       status: json['status'],
//     );
//   }
// }
