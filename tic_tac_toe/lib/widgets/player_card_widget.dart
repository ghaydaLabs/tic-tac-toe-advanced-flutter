import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PlayerCardWidget extends StatelessWidget {
  final Color containerColor;
  final Color borderColor;
  final double width;
  final List<BoxShadow> shadow;
  final String playerTurn;
  final Color turnColor;
  final String player;
  final Color playerColor;
  final double screenWidth;
  final double screenHeight;

  const PlayerCardWidget({
    super.key,
    required this.containerColor,
    required this.borderColor,
    required this.width,
    required this.shadow,
    required this.playerTurn,
    required this.turnColor,
    required this.player,
    required this.playerColor,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: screenWidth / 2.2,
        height: screenHeight * 0.2,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          border: Border.all(color: borderColor, width: width),
          boxShadow: shadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: .contain,
            child: Column(
              spacing: 1,
              children: [
                Text(
                  playerTurn,
                  style: TextStyle(
                    color: turnColor,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.25.sp,
                  ),
                ),
                Text(
                  player,
                  style: TextStyle(
                    color: playerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.2.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
