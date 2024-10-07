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
    dateJoined = json['date_joined'];  // Optional field
    updatedAt = json['updated_at'];    // Optional field
  }
}



// class UserProfile{
//   late String legal_name;
//   late String? gstin;
//   late String? pan_number;
//   late String? dl_no;
//   late String? address;
//   late String? date_joined;
//   late String? updated_at;
//   late String? role;

//   UserProfile({
//     required this.legal_name,
//     required this.gstin,
//     required this.pan_number,
//     required this.dl_no,
//     required this.address,
//     required this.date_joined,
//     required this.updated_at,
//     required this.role
//   });

//   @override
//   String toString() {
//     return 'UserProfile(legal_name: $legal_name,role: $role, gstin: $gstin, pan_number: $pan_number, dl_no: $dl_no, address: $address, date_joined: $date_joined, updated_at: $updated_at)';
//   }

//   UserProfile.fromJson(Map<String, dynamic> json) {
//     legal_name = json['legal_name'];
//     gstin = json['gstin'];
//     pan_number = json['pan_number'];
//     dl_no = json['dl_no'];
//     address = json['address'];
//     role = json['role'];
//     date_joined = json['date_joined'];
//     updated_at = json['updated_at'];
//   }

// }
