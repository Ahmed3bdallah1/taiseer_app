class RequirementsEntity {
  final int id;
  final String requirement;

  RequirementsEntity({required this.requirement, required this.id});

  factory RequirementsEntity.fromJson(Map<String, dynamic> json) {
    return RequirementsEntity(
      id: json["id"],
      requirement: json['requirement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requirement': requirement,
    };
  }
}

final requirements = [
  RequirementsEntity(requirement: "صورة الهوية الشخصية", id: 1),
  RequirementsEntity(requirement: "كشف حساب بنكى", id: 2),
];
