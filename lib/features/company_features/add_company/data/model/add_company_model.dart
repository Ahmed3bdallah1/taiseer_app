import 'package:taiseer/features/shared/auth/domain/entities/auth_entity.dart';
import '../../../../user_features/user_company/domain/entity/attributes_entity.dart';


class AddCompanyModel {
  final List<AttributesEntity>? attributes;
  final List<CountryEntity>? countries;

  AddCompanyModel({this.attributes, this.countries});

  factory AddCompanyModel.fromJson(Map<String, dynamic> json) {
    return AddCompanyModel(
      attributes: json["attributes"],
      countries: json["countries"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributes': attributes,
      "countries": countries,
    };
  }
}

final addCompanyModel =
    AddCompanyModel(attributes: attributes, countries: countries);
