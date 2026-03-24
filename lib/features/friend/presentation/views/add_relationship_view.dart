import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:danmalgi_mobile/core/widgets/rounded_text_field.dart';
import 'package:danmalgi_mobile/features/friend/presentation/providers/relationship_view_model.dart';
import 'package:danmalgi_mobile/features/friend/presentation/widgets/outgoing_relationship_list_tile.dart';

class AddRelationshipView extends ConsumerStatefulWidget {
  const AddRelationshipView({super.key});

  @override
  ConsumerState<AddRelationshipView> createState() =>
      _AddRelationshipViewState();
}

class _AddRelationshipViewState extends ConsumerState<AddRelationshipView> {
  final TextEditingController friendTextFieldController =
      TextEditingController();

  @override
  void dispose() {
    friendTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ), // Custom icon and color
                    onPressed: () => context.pop(), // Define navigation action
                  ),
                  Text(
                    "친구 추가",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      RoundedTextField(
                        controller: friendTextFieldController,
                        // onChanged: (value) => viewModel.onNicknameChanged(value),
                        // onEditingComplete: () => viewModel.onEditingComplete(),
                        contentPadding: EdgeInsets.only(
                          left: 24,
                          top: 18,
                          right: 46,
                          bottom: 18,
                        ),
                        hintText: "친구 추가하고 싶은 닉네임을 입력해주세요",
                      ),
                      Positioned.fill(
                        right: 8,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () async {
                              final id = friendTextFieldController.text.split(
                                "#",
                              );
                              print(id);
                              await ref
                                  .read(relationshipViewModelProvider.notifier)
                                  .addRelationship(name: id[0], tag: id[1]);
                              ref.invalidate(relationshipViewModelProvider);
                            },
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            ref
                .watch(relationshipViewModelProvider)
                .when(
                  skipLoadingOnRefresh: true,
                  skipLoadingOnReload: true,
                  data: (state) {
                    if (state.incomingRelationshipList.isEmpty)
                      return SizedBox();
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

                        ListView.separated(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0.h,
                            horizontal: 16.0.w,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.outgoingRelationshipList.length,
                          itemBuilder: (context, index) {
                            final relationship =
                                state.outgoingRelationshipList[index];

                            if (index ==
                                state.outgoingRelationshipList.length) {
                              return Center(
                                child: const CircularProgressIndicator(),
                              );
                            }
                            return OutgoingRelationshipListTile(
                              relationship: relationship,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 16.0),
                        ),
                      ],
                    );
                  },
                  error: (e, stack) => Text("Error"),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: Padding(
    //     padding: MediaQuery.of(context).viewInsets,
    //     child: Container(
    //       padding: EdgeInsets.all(16.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           SizedBox(height: 20),
    //           TextFormField(
    //             controller: friendTextFieldController,
    //             validator: (value) {
    //               if (value!.isEmpty) {
    //                 return 'Please Enter Friend ID';
    //               }
    //               return null;
    //             },
    //             decoration: InputDecoration(
    //               border: OutlineInputBorder(),
    //               hintText: 'Example#0000',
    //               labelText: 'Friend ID',
    //             ),
    //           ),
    //           ElevatedButton(
    //             onPressed: () async {
    //               final List<String> nameTag = friendTextFieldController.text
    //                   .split('#');
    //               await ref
    //                   .read(relationshipViewModelProvider.notifier)
    //                   .addRelationship(name: nameTag[0], tag: nameTag[1]);

    //               if (mounted) {
    //                 context.pop();
    //               }
    //             },
    //             child: Text('Submit'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
