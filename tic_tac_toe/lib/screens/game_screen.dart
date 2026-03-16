import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tic_tac_toe/controllers/game_controller.dart';
import 'package:tic_tac_toe/l10n/app_localizations.dart';
import 'package:tic_tac_toe/models/game_model.dart';
import 'package:tic_tac_toe/theme/app_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tic_tac_toe/widgets/icon_button_widget.dart';
import 'package:tic_tac_toe/widgets/player_card_widget.dart';
import 'package:tic_tac_toe/widgets/score_board_widget.dart';

class GameScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;
  final VoidCallback onToggleLanguage;

  const GameScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
    required this.onToggleLanguage,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameController controller = GameController();
  GameModel game = GameModel();

  void _tapped(int index) {
    setState(() {
      controller.tap(index);

      final result = controller.checkWinner();
      if (result != null) {
        _showDialog(result);
      }
    });
  }

  void _undoLastMove() {
    setState(() {
      controller.undo();
    });
  }

  void _clearBoard() {
    setState(() {
      controller.clear();
    });
  }

  // Function that displays the winner dialog and plays celebration sound
  void _showDialog(String result) {
    final player = AudioPlayer();
    player.play(AssetSource('audio/win_sound.mp3'));
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent closing by tapping outside the dialog
      builder: (context) {
        return Stack(
          children: [
            Lottie.asset('assets/animation/celebrate.json'),
            AlertDialog(
              title: Text(
                "CONGRATS!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),
              content: Text(
                result == "Draw" ? "It's a Draw" : "Winner is: $result",
                style: const TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    player.stop();
                    setState(() {
                      controller.clear();
                    });

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Play Again",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        );
      },
    );
    // Update score board based on winner (X, O, or Draw)
    if (result == 'O') {
      controller.game.scoreO++;
    } else if (result == 'X') {
      controller.game.scoreX++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access theme data
    final loc = AppLocalizations.of(context)!; // Access localized language

    // container for gradient background
    return Container(
      decoration: BoxDecoration(
        gradient: widget.isDarkMode
            ? RadialGradient(
                center: Alignment(0.7, 0.2),
                radius: 1.5,
                colors: [Color(0xFF4A105D), Color(0xFF0B0B15)],
                stops: [0.0, 0.7],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFA366FF), Color(0xFF5E42F5)],
              ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: FittedBox(fit: .scaleDown, child: Text(loc.appTitle)),

          backgroundColor: Colors.transparent,

          actions: [
            IconButtonWidget(
              onPressed: _undoLastMove,
              icon: Icon(Icons.restart_alt, size: 20.sp),
              color: theme.colorScheme.surface,
            ),

            SizedBox(width: 2.sw),

            IconButtonWidget(
              onPressed: _clearBoard,
              icon: Icon(Icons.clear, size: 20.sp),
              color: theme.colorScheme.surface,
            ),

            SizedBox(width: 2.sw),
            IconButtonWidget(
              onPressed: widget.onToggleLanguage,
              icon: Icon(Icons.translate_outlined, size: 20.sp),
              color: theme.colorScheme.surface,
            ),

            SizedBox(width: 2.sw),
            IconButtonWidget(
              onPressed: widget.onToggle,
              icon: Icon(
                widget.isDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                size: 20.sp,
              ),
              color: theme.colorScheme.surface,
            ),

            SizedBox(width: 2.sw),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Get screen dimensions for responsive design
              double screenWidth = constraints.maxWidth;
              double screenHeight = constraints.maxHeight;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Column(
                      spacing: 20.sp,
                      mainAxisAlignment: .spaceAround,
                      children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.2,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.surface,
                              width: 2.5,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: .spaceAround,
                              children: [
                                Expanded(
                                  child: ScoreBoardWidget(
                                    score: controller.game.scoreX.toString(),
                                    player: loc.playerX,
                                    scoreColor: theme.colorScheme.primary,
                                    statusColor: theme.colorScheme.onSurface,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight * 0.2,
                                  ),
                                ),
                                Expanded(
                                  child: ScoreBoardWidget(
                                    score: controller.game.scoreDraw.toString(),
                                    player: loc.draw,
                                    scoreColor: theme.colorScheme.onSurface,
                                    statusColor: theme.colorScheme.onSurface,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight * 0.2,
                                  ),
                                ),
                                Expanded(
                                  child: ScoreBoardWidget(
                                    score: controller.game.scoreO.toString(),
                                    player: loc.playerO,
                                    scoreColor: theme.colorScheme.secondary,
                                    statusColor: theme.colorScheme.onSurface,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight * 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: .spaceAround,
                          children: [
                            PlayerCardWidget(
                              containerColor: theme.colorScheme.surface,
                              borderColor: !controller.game.turn
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.surface,
                              width: !controller.game.turn ? 4 : 2,
                              shadow: !controller.game.turn
                                  ? [
                                      BoxShadow(
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.4),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                              playerTurn: "X",
                              turnColor: theme.colorScheme.primary,
                              player: loc.playerX,
                              playerColor: theme.colorScheme.primary.withValues(
                                alpha: 0.8,
                              ),
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),

                            PlayerCardWidget(
                              containerColor: theme.colorScheme.surface,
                              borderColor: controller.game.turn
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.surface,
                              width: controller.game.turn ? 4 : 2,
                              shadow: controller.game.turn
                                  ? [
                                      BoxShadow(
                                        color: theme.colorScheme.secondary
                                            .withValues(alpha: 0.5),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                              playerTurn: "O",
                              turnColor: theme.colorScheme.secondary,
                              player: loc.playerO,
                              playerColor: theme.colorScheme.secondary,
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                          ],
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 9,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: screenWidth * 0.01,
                                mainAxisSpacing: screenWidth * 0.01,
                                childAspectRatio:
                                    (screenWidth / 3) / (screenHeight / 6),
                              ),
                          itemBuilder: (context, index) {
                            final isWin = controller.game.winLocation.contains(
                              index,
                            ); // Check if current cell is part of the winning pattern
                            return GestureDetector(
                              onTap: () {
                                _tapped(index);
                              },
                              child:
                                  Container(
                                        width: screenWidth / 3,
                                        height: screenHeight * 0.2,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: isWin
                                                ? AppTheme.winColor
                                                : theme.colorScheme.surface,
                                            width: isWin ? 4 : 3,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: theme.colorScheme.surface,
                                        ),
                                        child: FittedBox(
                                          fit: .contain,

                                          child: Text(
                                            controller.game.gameBoard[index],
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.12,
                                              fontWeight: FontWeight.bold,
                                              color: isWin
                                                  ? AppTheme.winColor
                                                  : (controller
                                                                .game
                                                                .gameBoard[index] ==
                                                            'X'
                                                        ? theme
                                                              .colorScheme
                                                              .primary
                                                        : theme
                                                              .colorScheme
                                                              .secondary),
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 10,
                                                  color:
                                                      (controller.game.gameBoard[index] ==
                                                                  'X'
                                                              ? theme
                                                                    .colorScheme
                                                                    .primary
                                                              : theme
                                                                    .colorScheme
                                                                    .secondary)
                                                          .withAlpha(
                                                            0.5.toInt(),
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .animate(
                                        key: ValueKey(
                                          controller.game.gameBoard[index],
                                        ),
                                      )
                                      .flip(
                                        direction: Axis.horizontal,
                                        duration: 400.ms,
                                        curve: Curves.easeInOut,
                                      )
                                      .fadeIn(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
