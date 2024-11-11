class PaymentLengthEntity {
  final int id;
  final int duration;
  final String name;

  PaymentLengthEntity(
      {required this.id, required this.duration, required this.name});

  factory PaymentLengthEntity.fromJson(Map<String, dynamic> json) {
    return PaymentLengthEntity(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, 'duration': duration, "name": name};
  }
}

final paymentList = [
  PaymentLengthEntity(id: 0, duration: 1, name: "شهر واحد"),
  PaymentLengthEntity(id: 1, duration: 2, name: "شهرين"),
  PaymentLengthEntity(id: 2, duration: 3, name: "3 اشهر"),
  PaymentLengthEntity(id: 3, duration: 4, name: "4 اشهر"),
  PaymentLengthEntity(id: 4, duration: 5, name: "5 اشهر"),
  PaymentLengthEntity(id: 5, duration: 6, name: "6 اشهر"),
];
