import 'package:danmalgi_mobile/core/providers/app_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:danmalgi_mobile/core/router/route_paths.dart';
import 'package:danmalgi_mobile/features/friend/domain/friend_state.dart';
import 'package:danmalgi_mobile/features/friend/domain/relationship_state.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/friend_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/friend_list_tile.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/incoming_relationship_list_tile.dart';

mixin class FriendViewProviderState {
  AsyncValue<FriendState> friendViewModel(WidgetRef ref) =>
      ref.watch(friendViewModelProvider);

  AsyncValue<RelationshipState> relationshipViewModel(WidgetRef ref) =>
      ref.watch(relationshipViewModelProvider);
}

class FriendView extends ConsumerStatefulWidget {
  const FriendView({super.key});

  @override
  ConsumerState<FriendView> createState() => FriendViewState();
}

class FriendViewState extends ConsumerState<FriendView>
    with FriendViewProviderState {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController friendTextFieldController =
      TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    friendTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: RefreshIndicator(
        onRefresh: () async {
          final _ = await ref.refresh(friendViewModelProvider.future);
          final _ = await ref.refresh(relationshipViewModelProvider.future);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4, top: 46.h),
                      child: Text(
                        "친구",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    IntrinsicHeight(
                      child: (user != null)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: GestureDetector(
                                    onTap: () async {
                                      // TODO: userRepo에서 유저를 갖고 오지 말고, AppAuthStatus에 sealed Authenticated(user, token)을 생성하여 이곳에서 가져오도록 변경
                                      Clipboard.setData(
                                        ClipboardData(
                                          text: '${user.name}#${user.tag}',
                                        ),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('복사 완료 !'),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.0,
                                        horizontal: 24.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${user.name}#${user.tag}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color(0xFF595959),
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Icon(
                                            Icons.copy,
                                            size: 22,
                                            color: Color(0xFF595959),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () =>
                                        context.push(RoutePaths.addFriend),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        // vertical: 18.0,
                                        horizontal: 24.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.add_rounded,
                                        color: Color(0xFF595959),
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36.h),
              relationshipViewModel(ref).when(
                data: (state) {
                  if (state.incomingRelationshipList.isEmpty) return SizedBox();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          "친구 요청",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 126,
                        child: ListView.builder(
                          clipBehavior: Clip.none,
                          padding: EdgeInsets.only(left: 14.0.w),
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.incomingRelationshipList.length,
                          itemBuilder: (context, index) {
                            final relationship =
                                state.incomingRelationshipList[index];
                            return SizedBox(
                              width: 270,
                              child: IncomingRelationshipListTile(
                                relationship: relationship,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  );
                },
                error: (e, stack) {
                  return Text("Error");
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "친구 목록",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    friendViewModel(ref).when(
                      data: (state) {
                        return ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 16.0.h),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.friendList.length,
                          itemBuilder: (context, index) {
                            final friend = state.friendList[index];

                            if (index == state.friendList.length) {
                              return Center(
                                child: const CircularProgressIndicator(),
                              );
                            }
                            if (friend.user.name.isNotEmpty) {
                              return FriendListTile(friend: friend);
                            } else {
                              return const Center(
                                child: Text('참여 가능한 방이 없습니다.'),
                              );
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 16.0),
                        );
                      },
                      error: (e, stack) => Text("Error"),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
