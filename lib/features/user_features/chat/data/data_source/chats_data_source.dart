import 'package:taiseer/config/api_path.dart';
import 'package:taiseer/features/user_features/chat/data/models/message_model.dart';
import '../../../../../core/service/webservice/dio_helper.dart';
import '../models/conversation_model.dart';

abstract class ChatsDataSource {
  Future<ChatsPaginationModel> getChats(int page);

  Future<MessagesPaginationModel> getMessages(int id);

  Future<bool> sendMessage({required int id, required String body});
}

class ChatsDataSourceImpl extends ChatsDataSource {
  ApiService apiService;

  ChatsDataSourceImpl(this.apiService);

  @override
  Future<ChatsPaginationModel> getChats(int page) async {
    final conversation = await apiService.get(url: "${ApiPath.getChats}?page=$page");
    return ChatsPaginationModel.fromJson(conversation);
  }

  @override
  Future<bool> sendMessage({required int id, required String body}) async {
    await apiService.post(url: ApiPath.storeMessage, requestBody: {"message_text": body, "shipment_id": id});
    return true;
  }

  @override
  Future<MessagesPaginationModel> getMessages(int id) async {
    final messages = await apiService.get(url: "${ApiPath.getMessages}$id");
    return MessagesPaginationModel.fromJson(messages);
  }
}
