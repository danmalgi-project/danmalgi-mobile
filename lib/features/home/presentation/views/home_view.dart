import 'package:collection/collection.dart';
import 'package:danmalgi_mobile/core/widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';

class MockMeeting {
  const MockMeeting({
    required this.title,
    this.subtitle,
    required this.timeLabel,
    required this.statusLabel,
    this.avatarUrls = const [],
    this.waitingCount = 0,
    this.isActive = false,
  });

  final String title;
  final String? subtitle;
  final String timeLabel; // "오전 10:00 (지금 시작 가능)" 그대로 문자열로
  final String statusLabel; // "수락함" / "미정"
  final List<String> avatarUrls;
  final int waitingCount;
  final bool isActive;
}

final mockMeetings = [
  MockMeeting(
    title: '디자인 팀 위클리',
    subtitle: '기초UIUX 8조',
    timeLabel: '오전 10:00 (지금 시작 가능)',
    statusLabel: '수락함',
    isActive: true,
    waitingCount: 3,
    avatarUrls: List.generate(
      3,
      (index) =>
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTum_J6gEMzt30wsdGbhC58x78n51GyV0wz0s0Qr51DOkluLSGcY7B0DIo&s=10",
    ),
  ),
  MockMeeting(
    title: '기획 동기화 미팅',
    timeLabel: '오후 02:00 (45분간)',
    statusLabel: '수락함',
    avatarUrls: List.generate(
      3,
      (index) =>
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTum_J6gEMzt30wsdGbhC58x78n51GyV0wz0s0Qr51DOkluLSGcY7B0DIo&s=10",
    ),
  ),
  MockMeeting(title: '피드백 및 마무리 세션', timeLabel: '오후 05:30', statusLabel: '미정'),
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [ScheduleBannerWidget(), Text("오늘 할 일")]),
          ),
        ),
      ),
    );
  }
}

class ScheduleBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "오늘의 미팅 일정",
          style: TextStyle(
            color: Color(0xFF8E8E93),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 12),
        ...mockMeetings.mapIndexed((idx, m) {
          final card = Material(
            color: m.isActive ? Color(0xFFFFE500) : Color(0xFF272729),
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          m.timeLabel,
                          style: TextStyle(
                            color: m.isActive ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                        Material(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            child: Text(
                              m.statusLabel,
                              style: TextStyle(
                                color: m.isActive
                                    ? Color(0xFFFFE500)
                                    : Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      m.title,
                      style: TextStyle(
                        color: m.isActive ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),

                    if (m.subtitle != null) ...[
                      SizedBox(height: 4),
                      Text(
                        m.subtitle!,
                        style: TextStyle(
                          color: m.isActive ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],

                    if (m.avatarUrls.isNotEmpty || m.waitingCount != 0) ...[
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Builder(
                            builder: (context) {
                              const radius = 12.0;
                              const overlap = 6.0;
                              final diameter = (radius + 2) * 2;
                              final urls = m.avatarUrls;

                              return SizedBox(
                                width: urls.isEmpty
                                    ? 0
                                    : diameter +
                                          (urls.length - 1) *
                                              (diameter - overlap),
                                height: diameter,
                                child: Stack(
                                  children: urls.mapIndexed((idx, url) {
                                    return Positioned(
                                      left: idx * (diameter - overlap),
                                      child: Material(
                                        color: m.isActive
                                            ? Color(0xFFFFE500)
                                            : Color(0xFF272729),
                                        shape: CircleBorder(),
                                        clipBehavior: Clip.antiAlias,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: CachedCircleAvatar(
                                            url: url,
                                            radius: radius,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(), // <- 이거 빼먹지 않았는지 확인
                                ),
                              );
                            },
                          ),
                          (m.waitingCount != 0)
                              ? Text(
                                  "외 ${m.waitingCount}명 대기 중",
                                  style: TextStyle(
                                    color: m.isActive
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );

          return idx == 0
              ? card
              : Padding(padding: const EdgeInsets.only(top: 8), child: card);
        }),
      ],
    );
  }
}
