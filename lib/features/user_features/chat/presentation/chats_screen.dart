import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taiseer/features/user_features/chat/data/models/conversation_model.dart';
import 'package:taiseer/features/user_features/chat/domain/use_case/chats_use_cases.dart';
import 'package:taiseer/features/user_features/chat/presentation/managers/get_chat_provider.dart';
import 'package:taiseer/features/user_features/chat/presentation/widgets/chat_room_container.dart';
import 'package:taiseer/ui/shared_widgets/custom_app_bar.dart';
import 'package:taiseer/ui/shared_widgets/loading_widget.dart';

import '../../../../config/app_color.dart';
import '../../../../main.dart';
import '../../../../ui/shared_widgets/error_widget.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen>
    with TickerProviderStateMixin {
  late final TabController controller;
  final PagingController<int, ConversationModel> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    final response = await getIt<FetchChatsUseCase>().call(pageKey);
    response.fold((l) {
      _pagingController.error = l;
    }, (r) {
      final isLastPage = r.total! < 15;
      if (isLastPage) {
        _pagingController.appendLastPage(r.data ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(r.data ?? [], nextPageKey);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // backgroundColor: AppColor.primaryDark,
        title: "Chats".tr,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(fetchChatsProvider(1).future),
        child: Consumer(
          builder: (context, ref, _) {
            final provider = ref.watch(fetchChatsProvider(1));
            return provider.customWhen(
              ref: ref,
              refreshable: fetchChatsProvider(1).future,
              skipLoadingOnRefresh: true,
              data: (chats) {
                if (chats.data!.isEmpty) {
                  return EmptyWidget(
                    onRetry: () {
                      return ref.refresh(fetchChatsProvider(1).future);
                    },
                  );
                }
                return PagedListView<int, ConversationModel>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ConversationModel>(
                    itemBuilder: (context, conv, index) {
                      return ChatRoomContainer(chatsRoomEntity: conv);
                    },
                    firstPageProgressIndicatorBuilder: (context)=>const Center(child: LoadingWidget(),),
                    newPageProgressIndicatorBuilder: (context)=>const Center(child: LoadingWidget(),),
                    firstPageErrorIndicatorBuilder: (context) => Center(
                        child: CustomErrorWidget(
                      message: "No Conversation found".tr,
                      onRetry: () => ref.refresh(fetchChatsProvider(1).future),
                    )),
                    newPageErrorIndicatorBuilder: (context) =>
                        const Center(child: Text('Error loading more data')),
                    noItemsFoundIndicatorBuilder: (context) =>
                        const Center(child: Text('No Chats found')),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
