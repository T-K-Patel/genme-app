
class UserProfile{
  late String legal_name;
  late String? gstin;
  late String? pan_number;
  late String? dl_no;
  late String? address;
  late String? date_joined;
  late String? updated_at;
  late String? role;

  UserProfile({
    required this.legal_name,
    required this.gstin,
    required this.pan_number,
    required this.dl_no,
    required this.address,
    required this.date_joined,
    required this.updated_at,
    required this.role
  });

  @override
  String toString() {
    return 'UserProfile(legal_name: $legal_name,role: $role, gstin: $gstin, pan_number: $pan_number, dl_no: $dl_no, address: $address, date_joined: $date_joined, updated_at: $updated_at)';
  }

  UserProfile.fromJson(Map<String, dynamic> json) {
    legal_name = json['legal_name'];
    gstin = json['gstin'];
    pan_number = json['pan_number'];
    dl_no = json['dl_no'];
    address = json['address'];
    role = json['role'];
    date_joined = json['date_joined'];
    updated_at = json['updated_at'];
  }

}