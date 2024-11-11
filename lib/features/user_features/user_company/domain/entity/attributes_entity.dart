class AttributesEntity {
  final int id;
  final String name;

  AttributesEntity({
    required this.id,
    required this.name,
  });

  factory AttributesEntity.fromJson(Map<String, dynamic> json) {
    return AttributesEntity(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
    };
  }
}

final attributes = [
  AttributesEntity(id: 1, name: "شحن جوى"),
  AttributesEntity(id: 2, name: "شحن سريع"),
  AttributesEntity(id: 3, name: "شحن برى"),
];


