import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taiseer/features/user_features/chat/data/models/conversation_model.dart';
import 'package:taiseer/features/user_features/chat/data/models/message_model.dart';
import 'package:taiseer/features/user_features/chat/domain/use_case/chats_use_cases.dart';
import 'package:taiseer/main.dart';

final fetchChatsProvider =
    FutureProvider.autoDispose.family<ChatsPaginationModel,int>((ref,id) async {
  final res = await getIt<FetchChatsUseCase>().call(id);
  return res.fold(
    (l) => throw l,
    (r) => r,
  );
});

final fetchMessagesProvider = FutureProvider.autoDispose
    .family<MessagesPaginationModel, int>((ref, id) async {
  final res = await getIt<FetchMessagesUseCase>().call(id);
  return res.fold(
    (l) => throw l,
    (r) => r,
  );
});
