import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScoreBoardWidget extends StatelessWidget {
  final String score;
  final String player;
  final Color scoreColor;
  final Color statusColor;
  final double screenWidth;
  final double screenHeight;

  const ScoreBoardWidget({
    super.key,
    required this.score,
    required this.player,
    required this.scoreColor,
    required this.statusColor,

    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Column(
          children: [
            Flexible(
              child: Text(
                score,
                style: TextStyle(
                  color: scoreColor,
                  fontWeight: FontWeight.bold,
                  fontSize: orientation == Orientation.portrait
                      ? screenHeight * 5.sp
                      : screenHeight * 3.sp,
                ),
              ),
            ),
            Flexible(
              child: Text(
                player,
                style: TextStyle(
                  color: statusColor,
                  fontSize: screenHeight * 2.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
