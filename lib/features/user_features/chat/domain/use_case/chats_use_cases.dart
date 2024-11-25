import 'package:fpdart/fpdart.dart';
import 'package:taiseer/core/use_cases/use_case.dart';
import 'package:taiseer/features/user_features/chat/data/models/message_model.dart';
import 'package:tuple/tuple.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/models/conversation_model.dart';
import '../repo/chats_repo.dart';

class FetchChatsUseCase extends UseCaseParam<ChatsPaginationModel, int> {
  final ChatsRepo chatsRepo;

  FetchChatsUseCase({
    required this.chatsRepo,
  });

  @override
  Future<Either<Failure, ChatsPaginationModel>> call([int? param]) {
    return chatsRepo.getChats(param ?? 1);
  }
}

class FetchMessagesUseCase extends UseCaseParam<MessagesPaginationModel, int> {
  final ChatsRepo chatsRepo;

  FetchMessagesUseCase({
    required this.chatsRepo,
  });

  @override
  Future<Either<Failure, MessagesPaginationModel>> call([int? param]) {
    return chatsRepo.getMessages(param ?? 0);
  }
}

class SendMessageUseCase extends UseCaseParam<bool, Tuple2<int, String?>> {
  final ChatsRepo chatsRepo;

  SendMessageUseCase({
    required this.chatsRepo,
  });

  @override
  Future<Either<Failure, bool>> call([Tuple2? param]) {
    return chatsRepo.sendMessage(
        id: param?.item1 ?? 0, body: param?.item2 ?? "");
  }
}
