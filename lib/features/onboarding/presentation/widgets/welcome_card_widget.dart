import 'package:flutter/material.dart';

class WelcomeCardWidget extends StatelessWidget {
  const WelcomeCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Center(
        child: SizedBox(
          width: 364,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                left: 17,
                top: 38.78,
                child: Container(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(-0.14),
                  width: 178.03,
                  height: 105.72,
                  padding: const EdgeInsets.all(17),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFC4A1FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        'VOICE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w800,
                          height: 1.43,
                          letterSpacing: -0.22,
                        ),
                      ),
                      Text(
                        '#게임-수다방',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.43,
                          letterSpacing: -0.22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 192.81,
                top: 78,
                child: Container(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(0.21),
                  width: 165.38,
                  height: 104.91,
                  padding: const EdgeInsets.all(17),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF2D78),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        'ALIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w800,
                          height: 1.43,
                          letterSpacing: -0.22,
                        ),
                      ),
                      Text(
                        '민수 참여 중',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.43,
                          letterSpacing: -0.22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 34.89,
                top: 139,
                child: Container(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(0.07),
                  width: 158.18,
                  height: 70.14,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFE500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Container(
                        width: 19.21,
                        height: 19.21,
                        decoration: ShapeDecoration(
                          color: Colors.black,
                          shape: OvalBorder(),
                        ),
                      ),
                      Text(
                        '새 메시지 🔥',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w800,
                          height: 1.43,
                          letterSpacing: -0.22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
