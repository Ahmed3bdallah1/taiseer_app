class CalenderHistoryModel {
  int? id;
  String? piadDate;
  num? value;
  int? status;
  int? orderId;
  int? parentId;
  int? type;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  CalenderHistoryModel(
      {this.id,
      this.piadDate,
      this.value,
      this.status,
      this.orderId,
      this.parentId,
      this.type,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  CalenderHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    piadDate = json['piad_date'];
    value = json['value'];
    status = json['status'];
    orderId = json['order_id'];
    parentId = json['parent_id'];
    type = json['type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['piad_date'] = piadDate;
    data['value'] = value;
    data['status'] = status;
    data['order_id'] = orderId;
    data['parent_id'] = parentId;
    data['type'] = type;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
