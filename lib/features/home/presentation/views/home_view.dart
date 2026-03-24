import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:danmalgi_mobile/core/providers/notification_provider.dart';
import 'package:danmalgi_mobile/features/auth/data/providers/auth_provider.dart';

// class HomeView extends StatelessWidget {
//   int _selectedIndex = 0;

//   static const List<Widget> _pages = <Widget>[
//     // DirectMessageListViewScreen(),
//     // FriendScreen(),
//     // LogoutScreen(),
//   ];

//   static const List<Icon> _icons = <Icon>[
//     Icon(Icons.home_filled, size: 26),
//     Icon(Icons.people_alt, size: 30),
//     Icon(Icons.person, size: 31),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: _pages.elementAt(_selectedIndex),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // floatingActionButton: BottomNavigationBar(
//       //   currentIndex: _selectedIndex,
//       //   type: BottomNavigationBarType.fixed,
//       //   showSelectedLabels: false,
//       //   showUnselectedLabels: false,
//       //   selectedItemColor: Color(0xFF333333),
//       //   unselectedItemColor: Color(0xFFA29898),
//       //   backgroundColor: Colors.white,
//       //   enableFeedback: false,
//       //   elevation: 0.0,
//       //   onTap: (value) => _onItemTapped(value),
//       //   items: [
//       //     BottomNavigationBarItem(
//       //         icon: Icon(Icons.home_filled, size: 26), label: "Home"),
//       //     BottomNavigationBarItem(
//       //         icon: Icon(Icons.people_alt, size: 30), label: "Friend"),
//       //     BottomNavigationBarItem(
//       //         icon: Icon(Icons.person, size: 31), label: "Profile"),
//       //   ],
//       // ),
//       floatingActionButton: Container(
//         color: Colors.white,
//         // padding: const EdgeInsets.symmetric(vertical: 17.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: _icons.mapIndexed((idx, icon) {
//             return Expanded(
//               child: GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 // onTap: () => _onItemTapped(idx),
//                 child: Container(
//                   // padding: EdgeInsets.symmetric(vertical: 17.0),
//                   height: 64.0,
//                   child: Icon(
//                     icon.icon,
//                     size: icon.size,
//                     color: _selectedIndex == idx
//                         ? Color(0xFF333333)
//                         : Color(0xFFA29898),
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// TODO: 테스트 코드
class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(notificationInitProvider, (previous, next) {
      next.when(
        data: (_) => print('✅ Notifications initialized'),
        error: (err, stack) => print('❌ Init failed: $err'),
        loading: () => print('⏳ Initializing notifications...'),
      );
    });

    final tokenAsync = ref.watch(fcmTokenProvider);
    final permissionAsync = ref.watch(notificationPermissionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPermissionCard(permissionAsync),
            const SizedBox(height: 16),
            _buildTokenCard(context, tokenAsync, ref),
            const SizedBox(height: 16),
            _buildMessageListener(ref),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionCard(AsyncValue<dynamic> permissionAsync) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔔 Notification Permission',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            permissionAsync.when(
              data: (status) {
                final isGranted = status.toString().contains('authorized');
                return Row(
                  children: [
                    Icon(
                      isGranted ? Icons.check_circle : Icons.cancel,
                      color: isGranted ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isGranted ? 'Granted ✅' : 'Denied ❌',
                      style: TextStyle(
                        color: isGranted ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenCard(
    BuildContext context,
    AsyncValue<String?> tokenAsync,
    WidgetRef ref,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔑 FCM Token',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            tokenAsync.when(
              data: (token) {
                if (token == null) {
                  return const Text('No token available');
                }

                // ref
                //     .read(authRepositoryProvider)
                //     .upsertFCMToken(fcmToken: token);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      token,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: token));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Token copied!')),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text('Copy Token'),
                    ),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageListener(WidgetRef ref) {
    final messageAsync = ref.watch(foregroundMessageProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📬 Latest Message',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            messageAsync.when(
              data: (message) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.notification?.title ?? 'No title',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(message.notification?.body ?? 'No body'),
                      if (message.data.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Data: ${message.data}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
              loading: () => const Text('Waiting for messages...'),
              error: (err, _) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }
}
