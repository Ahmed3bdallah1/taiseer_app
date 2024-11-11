import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tuple/tuple.dart';

import '../../../../../core/service/webservice/dio_helper.dart';
import '../../../home/domain/entities/ad_entity.dart';
import '../../../order/domain/entity/order_entity.dart';
import '../../domain/entity/attributes_entity.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/entity/shipping_methods_entity.dart';
import '../model/company_model.dart';

abstract class UserCompanyDataSource {
  Future<List<UserCompanyModel>> getCompanies({Map? map});

  Future<Tuple3<List<UserCompanyModel>, List<CommentsEntity>, List<OrderEntity>>> searchCompanies({String? search});
  Future<List<dynamic>> searchCompanies2({String? search});
}

class UserCompanyDataSourceImp extends UserCompanyDataSource {
  final ApiService apiService;

  UserCompanyDataSourceImp(this.apiService);

  @override
  Future<List<UserCompanyModel>> getCompanies({Map? map}) async {
    await Future.delayed(const Duration(seconds: 2));
    return companies;
  }

  @override
  Future<
      Tuple3<List<UserCompanyModel>, List<CommentsEntity>,
          List<OrderEntity>>> searchCompanies({String? search}) async {
    await Future.delayed(const Duration(seconds: 2));

    // final List<UserCompanyModel> companiesList = [];
    // final List<CommentsEntity> commentsList = [];
    // final List<OrderEntity> ordersList = [];
    // for (Map<String, dynamic> i in mixedList) {
    //   print(i);
    //   // Check if it's a UserCompanyModel based on the presence of specific fields
    //   if (i.containsKey('title') &&
    //       i.containsKey('backgroundImage') &&
    //       i.containsKey('shipment')) {
    //     companiesList.add(UserCompanyModel.fromJson(i));
    //   }
    //   else if (i.containsKey('userName') && i.containsKey('comment')) {
    //     commentsList.add(CommentsEntity.fromJson(i));
    //   }
    //   else if (i.containsKey('programId') && i.containsKey('companyModel')) {
    //     ordersList.add(OrderEntity(
    //       programId: i['programId'],
    //       id: i['id'],
    //       status: StatusEntity(
    //         id: i['id'],
    //         title: i['title']??"",
    //         description: i['description']??"",
    //         color: Colors.blue,
    //         percent: i['percent']??0.0,
    //       ),
    //       total: i['total'],
    //       subTotal: i['subTotal'],
    //       fundType: i['fundType'],
    //       price: i['price'],
    //       from: i['from'],
    //       to: i['to'],
    //       orderDescription: i['orderDescription'],
    //       companyModel: UserCompanyModel(
    //         id: i['companyModel']['id'],
    //         backgroundImage: i['companyModel']['backgroundImage'],
    //         image: i['companyModel']['image'],
    //         title: i['companyModel']['title'],
    //         rating: i['companyModel']['rating'],
    //         likes: i['companyModel']['likes'],
    //         shipment: i['companyModel']['shipment'],
    //         description: i['companyModel']['description'],
    //         ads: ads,
    //         attributes: attributes,
    //         comment: comments,
    //         shippingMethods: shippingMethods,
    //       ),
    //     ));
    //   }
    // }
    // return Tuple3(companiesList, commentsList, ordersList);
    return Tuple3([], [], []);
  }

  @override
  Future<List<dynamic>> searchCompanies2({String? search}) async {
    await Future.delayed(const Duration(seconds: 2));
    return [companies[0],comments[0],companies[1]];
  }
}
