import 'dart:convert';
import 'dart:ui';
import 'package:taiseer/models/program_model.dart';
import 'package:flutter_color/flutter_color.dart' as color;
import '../../../user_company/data/model/company_model.dart';

class StatusEntity {
  final String title;
  final int id;
  final Color color;
  final String description;
  final num percent;

  StatusEntity({
    required this.title,
    required this.id,
    required this.color,
    required this.percent,
    required this.description,
  });
}

class OrderEntity {
  final int programId;
  final int id;
  final StatusEntity status;
  final String total;
  final String subTotal;
  final String fundType;
  final double price;
  final String from;
  final String to;
  final String orderDescription;
  final UserCompanyModel companyModel;

  OrderEntity({
    required this.programId,
    required this.id,
    required this.status,
    required this.total,
    required this.subTotal,
    required this.fundType,
    required this.price,
    required this.from,
    required this.to,
    required this.orderDescription,
    required this.companyModel,
  });

  factory OrderEntity.fromOrderModel(OrderModel orderModel) {
    return OrderEntity(
      price: 250,
      from: "مدينة نصر, القاهرة, مصر",
      to: "مدينة نصر, القاهرة, مصر",
      orderDescription:
          "هذا وصف افتراضي للشحنه حتي تكون مواصفاتها واضحة لمقدم الشحنة هذا وصف افتراضي للشحنه حتي تكون مواصفاتها واضحة لمقدم الشحنة هذا وصف افتراضي",
      programId: jsonDecode(orderModel.programDetails!)['id'],
      id: orderModel.id!,
      status: StatusEntity(
        id: orderModel.status!.id!,
        title: orderModel.status!.title!,
        description: "الطلب في انتظار موافقة الاستلام في خلال 24 ساعة",
        color: color.HexColor(orderModel.status!.backgroudColor!),
        percent: orderModel.status!.persage!,
      ),
      total: orderModel.total!.toStringAsFixed(2),
      subTotal: orderModel.subtotal!.toStringAsFixed(2),
      fundType: orderModel.programType!.title!,
      companyModel: companies[0],
    );
  }
}
