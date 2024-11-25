import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/user_features/chat/data/models/message_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/models/conversation_model.dart';

abstract class ChatsRepo {
  Future<Either<Failure, bool>> sendMessage(
      {required int id, required String body});

  Future<Either<Failure, ChatsPaginationModel>> getChats(int page);

  Future<Either<Failure, MessagesPaginationModel>> getMessages(int id);
}
