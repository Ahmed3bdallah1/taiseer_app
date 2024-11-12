import 'package:taiseer/features/user_features/home/domain/entities/requirements_entity.dart';
import '../../../../../models/program_model.dart';

class LoanDetailsEntity {
  final double? fund;
  final int? programId;
  final String? fundType;
  final String? length;

  final String? percent;
  final int id;
  final String? description;
  final List<PeriodModel>? periods;
  final List<ContractModel>? contracts;
  final List<Fields>? fields;

  LoanDetailsEntity(
      {required this.fund,
      required this.programId,
      required this.contracts,
      required this.fundType,
      required this.length,
      required this.percent,
      required this.id,
      required this.description,
      required this.periods,
      required this.fields});

  factory LoanDetailsEntity.fromProgram(ProgramModel prog) {
    return LoanDetailsEntity(
      contracts: prog.contract,
      fund: prog.value!.toDouble(),
      programId: prog.id,
      fundType: prog.programType?.title,
      length: prog.calender,
      percent: prog.interest,
      description: prog.description,
      id: prog.id!,
      periods: prog.periods,
      fields: prog.fields,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'length': length,
      'description': description,
      "requirements": requirements,
      'percent': percent,
      "program_id": programId,
      "calender": length,
      "fund": fund,
      "fund_type": fundType,
      "fields": fields,
    };
  }
}
