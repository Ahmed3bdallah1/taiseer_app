class ProgramModel {
  int? id;
  int? value;
  String? description;
  int? programTypeId;
  String? calender;
  String? interest;
  List<ContractModel>? contract;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  ProgramTypeModel? programType;
  List<PeriodModel>? periods;
  List<Fields>? fields;

  ProgramModel(
      {this.id,
      this.value,
      this.description,
      this.programTypeId,
      this.calender,
      this.interest,
      this.contract,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.programType,
      this.periods,
      this.fields});

  ProgramModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    description = json['description'];
    programTypeId = json['program_type_id'];
    calender = json['calender'];
    interest = json['interest'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    programType = json['program_type'] != null
        ? ProgramTypeModel.fromJson(json['program_type'])
        : null;
    if (json['periods'] != null) {
      periods = <PeriodModel>[];
      json['periods'].forEach((v) {
        periods!.add(PeriodModel.fromJson(v));
      });
    }
    if (json['contracts'] != null) {
      contract = <ContractModel>[];
      json['contracts'].forEach((v) {
        contract!.add(ContractModel.fromJson(v));
      });
    }
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['description'] = description;
    data['program_type_id'] = programTypeId;
    data['calender'] = calender;
    data['interest'] = interest;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (programType != null) {
      data['program_type'] = programType!.toJson();
    }
    if (periods != null) {
      data['periods'] = periods!.map((v) => v.toJson()).toList();
    }
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PeriodModel {
  int? id;
  int? programId;
  int? periodGlobelId;
  num? percent;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  PeriodDetailsModel? period;

  PeriodModel(
      {this.id,
      this.programId,
      this.periodGlobelId,
      this.percent,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.period});

  PeriodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    programId = json['program_id'];
    periodGlobelId = json['period_globel_id'];
    percent = json['percent'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    period = json['period'] != null
        ? PeriodDetailsModel.fromJson(json['period'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['program_id'] = programId;
    data['period_globel_id'] = periodGlobelId;
    data['percent'] = percent;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (period != null) {
      data['period'] = period!.toJson();
    }
    return data;
  }
}

class PeriodDetailsModel {
  int? id;
  String? title;
  int? numMonths;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  PeriodDetailsModel(
      {this.id,
      this.title,
      this.numMonths,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  PeriodDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    numMonths = json['num_months'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['num_months'] = numMonths;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Fields {
  int? id;
  int? programId;
  int? fieldId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Field? field;

  Fields(
      {this.id,
      this.programId,
      this.fieldId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.field});

  Fields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    programId = json['program_id'];
    fieldId = json['field_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    field = json['field'] != null ? Field.fromJson(json['field']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['program_id'] = programId;
    data['field_id'] = fieldId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (field != null) {
      data['field'] = field!.toJson();
    }
    return data;
  }
}

class Field {
  int? id;
  String? title;
  String? createdAt;
  String? updatedAt;

  Field({this.id, this.title, this.createdAt, this.updatedAt});

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ContractModel {
  final int? id;
  final String? title;
  ContractModel({this.title, this.id});

  factory ContractModel.fromJson(Map<String, dynamic> data) {
    return ContractModel(
      id: data['id'],
      title: data['title'],
    );
  }
}

class FilterModel {
  final List<StatusModel> status;
  final List<ProgramTypeModel> programType;

  FilterModel({required this.status, required this.programType});

  factory FilterModel.fromJson(Map<String, dynamic> data) {
    return FilterModel(
      status:
          (data['status'] as List).map((e) => StatusModel.fromJson(e)).toList(),
      programType: (data['program_type'] as List)
          .map((e) => ProgramTypeModel.fromJson(e))
          .toList(),
    );
  }
}

class OrderModel {
  int? id;
  num? total;
  num? subtotal;
  num? interest;
  String? programDetails;
  String? fullAccountName;
  String? accountNumber;
  int? customerId;
  int? orderStatus;
  int? peroidGloble;
  int? bankId;
  int? programTypeId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  PeriodModel? period;
  StatusModel? status;
  BankModel? bank;
  ProgramTypeModel? programType;

  OrderModel(
      {this.id,
      this.total,
      this.subtotal,
      this.interest,
      this.programDetails,
      this.fullAccountName,
      this.accountNumber,
      this.customerId,
      this.orderStatus,
      this.peroidGloble,
      this.bankId,
      this.programTypeId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.period,
      this.status,
      this.bank,
      this.programType});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    subtotal = json['subtotal'];
    interest = json['interest'];
    programDetails = json['program_details'];
    fullAccountName = json['full_account_name'];
    accountNumber = json['account_number'];
    customerId = json['customer_id'];
    orderStatus = json['order_status'];
    peroidGloble = json['peroid_globle'];
    bankId = json['bank_id'];
    programTypeId = json['program_type_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    period =
        json['period'] != null ? PeriodModel.fromJson(json['period']) : null;
    status =
        json['status'] != null ? StatusModel.fromJson(json['status']) : null;
    bank = json['bank'] != null ? BankModel.fromJson(json['bank']) : null;
    programType = json['program_type'] != null
        ? ProgramTypeModel.fromJson(json['program_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total'] = total;
    data['subtotal'] = subtotal;
    data['interest'] = interest;
    data['program_details'] = programDetails;
    data['full_account_name'] = fullAccountName;
    data['account_number'] = accountNumber;
    data['customer_id'] = customerId;
    data['order_status'] = orderStatus;
    data['peroid_globle'] = peroidGloble;
    data['bank_id'] = bankId;
    data['program_type_id'] = programTypeId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (period != null) {
      data['period'] = period!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (bank != null) {
      data['bank'] = bank!.toJson();
    }
    if (programType != null) {
      data['program_type'] = programType!.toJson();
    }
    return data;
  }
}

class StatusModel {
  int? id;
  String? title;
  num? persage;
  String? backgroudColor;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  StatusModel(
      {this.id,
      this.title,
      this.persage,
      this.backgroudColor,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    persage = json['persage'];
    backgroudColor = json['backgroud_color'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['persage'] = persage;
    data['backgroud_color'] = backgroudColor;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BankModel {
  int? id;
  String? title;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  BankModel(
      {this.id, this.title, this.deletedAt, this.createdAt, this.updatedAt});

  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProgramTypeModel {
  int? id;
  String? title;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ProgramTypeModel(
      {this.id, this.title, this.deletedAt, this.createdAt, this.updatedAt});

  ProgramTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
