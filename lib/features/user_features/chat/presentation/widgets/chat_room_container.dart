import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:taiseer/features/user_features/chat/data/models/conversation_model.dart';
import '../../../../../config/app_font.dart';
import '../chat_screen.dart';

class ChatRoomContainer extends StatelessWidget {
  final ConversationModel chatsRoomEntity;

  const ChatRoomContainer({super.key, required this.chatsRoomEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Get.to(() => ChatPage(shipmentId:chatsRoomEntity.shipmentId??0,id: chatsRoomEntity.id ?? 0)),
        child: ListTile(
          trailing: Text(
            intl.DateFormat.yMd().add_jm().format(chatsRoomEntity.updatedAt!),
            style: AppFont.font12w500Grey2,
          ),
          subtitle: Text(
            chatsRoomEntity.chatName ?? "",
            style: AppFont.font12w500Grey2,
          ),
          title: Text(
            chatsRoomEntity.name ?? "",
            style: AppFont.font14W600Primary,
          ),
          // leading: ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: ImageOrSvg(
          //     chatsRoomEntity.,
          //     fit: BoxFit.cover,
          //     width: 75,
          //     height: 75,
          //   ),
          // ),
        ));
  }
}
