import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taiseer/config/app_color.dart';
import 'package:taiseer/core/service/auth_service.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';
import '../../../../main.dart';
import '../data/models/message_model.dart';
import '../domain/use_case/chats_use_cases.dart';
import 'managers/get_chat_provider.dart';

class ChatPage extends ConsumerStatefulWidget {
  final int id;
  final int shipmentId;
  final bool? isDisabled;

  const ChatPage({super.key, required this.id, this.isDisabled = false,required this.shipmentId,});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  List<types.Message> _messages = [];
  late types.User _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ref.watch(userProvider)!;
    _user = types.User(id: user.id.toString(), firstName: user.name);
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _loadMessagesFromResponse(List<MessageEntity> conversation) {
    final messages = conversation.map((e) {
      return types.TextMessage(
        author: types.User(id: e.senderId.toString()),
        createdAt: e.createdAt!.millisecondsSinceEpoch,
        id: e.id.toString(),
        showStatus: true,
        text: e.messageText??"",
        status: types.Status.sent,
      );
    }).toList();

    _messages = messages;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: Text("Chat with Company".tr),
        ),
        body: Consumer(
          builder: (context, ref, _) {
            ref.listen(fetchMessagesProvider(widget.id), (daf, sdfds) {
              if (sdfds.hasValue) {
                _loadMessagesFromResponse(sdfds.value!.data??[]);
              }
            });
            final provider = ref.watch(fetchMessagesProvider(widget.id));
            return provider.customWhen(
              ref: ref,
              refreshable: fetchMessagesProvider(widget.id).future,
              skipLoadingOnRefresh: true,
              data: (conversation) {
                return SafeArea(
                  child: Chat(
                    messages: _messages,
                    onPreviewDataFetched: _handlePreviewDataFetched,
                    onSendPressed: (types.PartialText message) async {
                      final textMessage = types.TextMessage(
                        author: _user,
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                        id: const Uuid().v4(),
                        text: message.text,
                      );
                      await getIt<SendMessageUseCase>().call(
                          Tuple2(widget.shipmentId, textMessage.text));
                      ref.invalidate(fetchChatsProvider(1));
                      ref.invalidate(fetchMessagesProvider);
                    },
                    theme: DefaultChatTheme(
                        backgroundColor: AppColor.white,
                        primaryColor: AppColor.primary,
                        secondaryColor: AppColor.primaryDark,
                        receivedMessageBodyTextStyle: TextStyle(color: AppColor.white, fontSize: 16.sp),
                        inputBackgroundColor: widget.isDisabled == true
                            ? Colors.transparent
                            : AppColor.primary.withOpacity(.8),
                        inputTextColor: widget.isDisabled == true
                            ? AppColor.primary
                            : AppColor.white,
                        inputSurfaceTintColor: AppColor.primary),
                    // showUserAvatars: true,
                    showUserNames: true,
                    user: _user,
                    inputOptions: InputOptions(enabled: !widget.isDisabled!),
                  ),
                );
              },
            );
          },
        ),
      );
}
