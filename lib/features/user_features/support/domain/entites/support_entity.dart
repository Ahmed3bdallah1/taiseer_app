// class SupportEntity {
//   final String phoneNumber;
//   final String email;
//
//   SupportEntity({
//     required this.phoneNumber,
//     required this.email,
//   });
// }

class SupportEntity {
  final String address;
  final String phone;
  final String fax;
  final String mobile;
  final String email;
  final String workingTime;

  SupportEntity({
    required this.address,
    required this.phone,
    required this.fax,
    required this.mobile,
    required this.email,
    required this.workingTime,
  });

  factory SupportEntity.fromJson(Map<String, dynamic> json) => SupportEntity(
    address: json["address"],
    phone: json["phone"],
    fax: json["fax"],
    mobile: json["mobile"],
    email: json["email"],
    workingTime: json["working_time"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "phone": phone,
    "fax": fax,
    "mobile": mobile,
    "email": email,
    "working_time": workingTime,
  };
}


// final support =
//     SupportEntity(phoneNumber: "01095478665", email: "support@taysir.com");
