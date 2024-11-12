import 'package:taiseer/config/api_path.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_details_model.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_pagination_model.dart';
import '../../../../../core/service/webservice/dio_helper.dart';

abstract class UserCompanyDataSource {
  Future<CompanyPaginationModel> getCompanies({String? param});

  Future<CompanyDetailsModel> getCompanyDetails({required int id});

  // Future<
  //     Tuple3<List<UserCompanyModel>, List<CommentsEntity>,
  //         List<OrderEntity>>> searchCompanies({String? search});

  Future<List<dynamic>> searchCompanies2({String? search});
}

class UserCompanyDataSourceImp extends UserCompanyDataSource {
  final ApiService apiService;

  UserCompanyDataSourceImp(this.apiService);

  @override
  Future<CompanyPaginationModel> getCompanies({String? param}) async {
    final res = await apiService.post(
        url: "${ApiPath.filteredCompanies}?filter=$param", returnDataOnly: true);
    CompanyPaginationModel companies = CompanyPaginationModel.fromJson(res);
    return companies;
  }

  // @override
  // Future<
  //     Tuple3<List<UserCompanyModel>, List<CommentsEntity>,
  //         List<OrderEntity>>> searchCompanies({String? search}) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //
  //   // final List<UserCompanyModel> companiesList = [];
  //   // final List<CommentsEntity> commentsList = [];
  //   // final List<OrderEntity> ordersList = [];
  //   // for (Map<String, dynamic> i in mixedList) {
  //   //   print(i);
  //   //   // Check if it's a UserCompanyModel based on the presence of specific fields
  //   //   if (i.containsKey('title') &&
  //   //       i.containsKey('backgroundImage') &&
  //   //       i.containsKey('shipment')) {
  //   //     companiesList.add(UserCompanyModel.fromJson(i));
  //   //   }
  //   //   else if (i.containsKey('userName') && i.containsKey('comment')) {
  //   //     commentsList.add(CommentsEntity.fromJson(i));
  //   //   }
  //   //   else if (i.containsKey('programId') && i.containsKey('companyModel')) {
  //   //     ordersList.add(OrderEntity(
  //   //       programId: i['programId'],
  //   //       id: i['id'],
  //   //       status: StatusEntity(
  //   //         id: i['id'],
  //   //         title: i['title']??"",
  //   //         description: i['description']??"",
  //   //         color: Colors.blue,
  //   //         percent: i['percent']??0.0,
  //   //       ),
  //   //       total: i['total'],
  //   //       subTotal: i['subTotal'],
  //   //       fundType: i['fundType'],
  //   //       price: i['price'],
  //   //       from: i['from'],
  //   //       to: i['to'],
  //   //       orderDescription: i['orderDescription'],
  //   //       companyModel: UserCompanyModel(
  //   //         id: i['companyModel']['id'],
  //   //         backgroundImage: i['companyModel']['backgroundImage'],
  //   //         image: i['companyModel']['image'],
  //   //         title: i['companyModel']['title'],
  //   //         rating: i['companyModel']['rating'],
  //   //         likes: i['companyModel']['likes'],
  //   //         shipment: i['companyModel']['shipment'],
  //   //         description: i['companyModel']['description'],
  //   //         ads: ads,
  //   //         attributes: attributes,
  //   //         comment: comments,
  //   //         shippingMethods: shippingMethods,
  //   //       ),
  //   //     ));
  //   //   }
  //   // }
  //   // return Tuple3(companiesList, commentsList, ordersList);
  //   return Tuple3([], [], []);
  // }

  @override
  Future<List<dynamic>> searchCompanies2({String? search}) async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      // companies[0],
      // comments[0],
      // companies[1],
    ];
  }

  @override
  Future<CompanyDetailsModel> getCompanyDetails({required int id}) async {
    final res = await apiService.get(
        url: "${ApiPath.companyDetails}/$id", returnDataOnly: true);
    CompanyDetailsModel companies = CompanyDetailsModel.fromJson(res);
    return companies;
  }
}
