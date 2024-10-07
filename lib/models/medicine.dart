// medicine.dart
class Medicine {
  final String name;
  final String id;
  final String type;

  Medicine({required this.name,
  required this.id,
  required this.type
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'],
      type: json['type'],
      id:json['id']
    );
  }
}