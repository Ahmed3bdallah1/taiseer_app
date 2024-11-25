import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/user_features/chat/data/models/conversation_model.dart';
import 'package:taiseer/features/user_features/chat/data/models/message_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/repo/chats_repo.dart';
import '../data_source/chats_data_source.dart';

class ChatsRepoImpl extends ChatsRepo {
  final ChatsDataSource dataSource;

  ChatsRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> sendMessage(
      {required int id, required String body}) async {
    try {
      final res = await dataSource.sendMessage(id: id, body: body);
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, ChatsPaginationModel>> getChats(int page) async {
    try {
      final res = await dataSource.getChats(page);
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, MessagesPaginationModel>> getMessages(int id) async {
    try {
      final res = await dataSource.getMessages(id);
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError(e));
      }
    }
  }
}
