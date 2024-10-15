class UserProfile {
  late String legalName;
  late String? gstin;
  late String? panNumber;
  late String? dlNo;
  late String? address;
  late String? dateJoined;
  late String? updatedAt;
  late String? role;
  late String? userId;
  late String? username;

  UserProfile({
    required this.legalName,
    required this.gstin,
    required this.panNumber,
    required this.dlNo,
    required this.address,
    required this.dateJoined,
    required this.updatedAt,
    required this.role,
    required this.userId,
    required this.username,
  });

  @override
  String toString() {
    return 'UserProfile(legalName: $legalName, role: $role, gstin: $gstin, panNumber: $panNumber, dlNo: $dlNo, address: $address, dateJoined: $dateJoined, updatedAt: $updatedAt, userId: $userId, username: $username)';
  }

  UserProfile.fromJson(Map<String, dynamic> json) {
    // Handle nested 'user' object
    userId = json['user']?['id'];
    username = json['user']?['username'];

    legalName = json['legal_name'] ?? '';
    gstin = json['gstin'];
    panNumber = json['pan_number'];
    dlNo = json['dl_no'];
    address = json['address'];
    role = json['role'];
    dateJoined = json['date_joined']; // Optional field
    updatedAt = json['updated_at']; // Optional field
  }
}
