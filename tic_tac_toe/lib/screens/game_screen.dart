import 'package:flutter/material.dart';
import 'package:tic_tac_toe/theme/app_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GameScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const GameScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool turn = true;
  List<String> xo = ['', '', '', '', '', '', '', '', ''];
  List<int> winLocation = [];
  List<int> moveHistory = [];
  int scoresOfO = 0;
  int scoresOfX = 0;
  int scoresOfDraw = 0;

  void _tapped(int index) {
    setState(() {
      if (xo[index] == '' && winLocation.isEmpty) {
        if (turn && xo[index] == '') {
          xo[index] = 'O';
        } else if (!turn && xo[index] == '') {
          xo[index] = 'X';
        }
        moveHistory.add(index);
        turn = !turn;
        _winner();
      }
    });
  }

  void _undoLastMove() {
    setState(() {
      if (moveHistory.isNotEmpty && winLocation.isEmpty) {
        int lastIndex = moveHistory.removeLast();
        xo[lastIndex] = '';
        turn = !turn;
      }
    });
  }

  void _winner() {
    bool isWinnerFound = false;
    if (xo[0] == xo[1] && xo[0] == xo[2] && xo[0] != '') {
      setState(() => winLocation = [0, 1, 2]);
      _showDialog(xo[0]);
      isWinnerFound = true;
    }
    if (xo[3] == xo[4] && xo[3] == xo[5] && xo[3] != '') {
      setState(() => winLocation = [3, 4, 5]);
      _showDialog(xo[3]);
      isWinnerFound = true;
    }
    if (xo[6] == xo[7] && xo[6] == xo[8] && xo[6] != '') {
      setState(() => winLocation = [3, 4, 5]);
      _showDialog(xo[6]);
      isWinnerFound = true;
    }
    if (xo[0] == xo[3] && xo[0] == xo[6] && xo[0] != '') {
      setState(() => winLocation = [0, 3, 6]);
      _showDialog(xo[0]);
      isWinnerFound = true;
    }
    if (xo[1] == xo[4] && xo[1] == xo[7] && xo[1] != '') {
      setState(() => winLocation = [1, 4, 7]);
      _showDialog(xo[1]);
      isWinnerFound = true;
    }
    if (xo[2] == xo[5] && xo[2] == xo[8] && xo[2] != '') {
      setState(() => winLocation = [2, 5, 8]);
      _showDialog(xo[2]);
      isWinnerFound = true;
    }
    if (xo[0] == xo[4] && xo[0] == xo[8] && xo[0] != '') {
      setState(() => winLocation = [0, 4, 8]);
      _showDialog(xo[0]);
      isWinnerFound = true;
    }
    if (xo[6] == xo[4] && xo[6] == xo[2] && xo[6] != '') {
      setState(() => winLocation = [2, 4, 6]);
      _showDialog(xo[6]);
      isWinnerFound = true;
    }
    if (!isWinnerFound && !xo.contains('')) {
      setState(() {
        scoresOfDraw++;
      });
    }
  }

  void _showDialog(String winner) {
    final player = AudioPlayer();
    player.play(AssetSource('audio/win_sound.mp3'));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Lottie.asset('assets/animation/celebrate.json'),
            AlertDialog(
              title: Column(
                children: [
                  Text(
                    "CONGRATS!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Winner is: $winner",
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actionsAlignment: .center,
              actions: [
                TextButton(
                  onPressed: () {
                    player.stop();
                    _clearBoard();
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
    if (winner == 'O') {
      scoresOfO++;
    } else if (winner == 'X') {
      scoresOfX++;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        xo[i] = '';
      }
      winLocation = [];
      moveHistory = [];
      turn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            title: const Text('Tic Tac Toe'),
            backgroundColor: Colors.transparent,

            actions: [
              _buildIconButton(
                _undoLastMove,
                Icon(Icons.restart_alt),
                theme.colorScheme.surface,
              ),

              SizedBox(width: 5),

              _buildIconButton(
                _clearBoard,
                Icon(Icons.clear),
                theme.colorScheme.surface,
              ),

              SizedBox(width: 5),

              Container(
                width: 45 ,
                height: 45,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border.all(
                    color: theme.colorScheme.surface,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.translate_outlined),
                ),
              ),

              SizedBox(width: 5),

              _buildIconButton(
                widget.onToggle,
                Icon(
                  widget.isDarkMode
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
                theme.colorScheme.surface,
              ),
              SizedBox(width: 10),

            ],
          ),
          body: SafeArea(
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              double screenWidth = constraints.maxWidth;
             double screenHeight = constraints.maxHeight;
            
             bool device = screenWidth > 600;
            
              return  SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: .spaceAround,
                      children: [
                        Container(
                          width: screenWidth ,
                          height: device ? screenHeight / 3 : screenHeight / 7,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.surface,
                              width: 2.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: .spaceAround,
                            children: [
                              _buildScoresBoard(
                                scoresOfX.toString(),
                                "Player X",
                                theme.colorScheme.primary,
                                theme.colorScheme.onSurface,
                                device
                              ),
                              _buildScoresBoard(
                                scoresOfDraw.toString(),
                                "Draw",
                                theme.colorScheme.onSurface,
                                theme.colorScheme.onSurface,
                                device
                              ),
                              _buildScoresBoard(
                                scoresOfO.toString(),
                                "Player O",
                                theme.colorScheme.secondary,
                                theme.colorScheme.onSurface,
                                device
                              ),
                            ],
                          ),
                        ),
                  
                        Row(
                          mainAxisAlignment: .spaceAround,
                          children: [
                            _buildPlayerCard(
                              theme.colorScheme.surface,
                              !turn
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.surface,
                              !turn ? 4 : 2,
                              !turn
                                  ? [
                                      BoxShadow(
                                        color: theme.colorScheme.primary.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                              "X",
                              theme.colorScheme.primary,
                              "Player X",
                              theme.colorScheme.primary.withValues(alpha: 0.8),
                              screenWidth,
                              screenHeight, 
                              device,
                            ),
                            _buildPlayerCard(
                              theme.colorScheme.surface,
                              turn
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.surface,
                              turn ? 4 : 2,
                              turn
                                  ? [
                                      BoxShadow(
                                        color: theme.colorScheme.secondary.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                              "O",
                              theme.colorScheme.secondary,
                              "Player O",
                              theme.colorScheme.secondary,
                              screenWidth,
                              screenHeight,
                              device,
                            ),
                          ],
                        ),
                            GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 9,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: device ? 3 : 1
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final isWin = winLocation.contains(index);
                                  return GestureDetector(
                                    onTap: () {
                                      _tapped(index);
                                    },
                                    child:
                                        Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: isWin
                                                      ? AppTheme.winColor
                                                      : theme.colorScheme.surface,
                                                  width: isWin ? 4 : 3,
                                                ),
                                                borderRadius: BorderRadius.circular(20),
                                                color: theme.colorScheme.surface,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  xo[index],
                                                  style: TextStyle(
                                                    fontSize: device ? 50 : 80,
                                                    fontWeight: FontWeight.bold,
                                                    color: isWin
                                                        ? AppTheme.winColor
                                                        : (xo[index] == 'X'
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
                                                            (xo[index] == 'X'
                                                                    ? theme
                                                                          .colorScheme
                                                                          .primary
                                                                    : theme
                                                                          .colorScheme
                                                                          .secondary)
                                                                .withValues(alpha: 0.5),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .animate(key: ValueKey(xo[index]))
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
            }
            ),
          ),
      ),
    );
  }
}

Widget _buildIconButton(Function func, Widget icon, Color color) {
  return Container(
    width: 45,
    height: 45,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: color, width: 2.5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: IconButton(
      onPressed: () {
        func();
      },
      icon: icon,
    ),
  );
}

Widget _buildScoresBoard(
  String score,
  String player,
  Color scoreColor,
  Color statusColor,
  bool device,
) {
  return Column(
    children: [
      Text(score, style: TextStyle(color: scoreColor, fontWeight: .bold, fontSize: device ? 42 : 40)),
      Text(player, style: TextStyle(color: statusColor, fontSize: device ? 30 : 24)),
    ],
  );
}

Widget _buildPlayerCard(
  Color containerColor,
  Color borderColor,
  double width,
  List<BoxShadow> shadow,
  String playerTurn,
  Color turnColor,
  String player,
  Color playerColor,
  double screenWidth,
  double screenHeight,
  bool device,
) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    width: screenWidth / 2.2,
    height: device ? screenHeight / 3 : screenHeight / 6,
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColor, width: width),
      boxShadow: shadow,
    ),
    child: Column(
      children: [
        Text(playerTurn, style: TextStyle(color: turnColor, fontWeight: .bold, fontSize: device ? 42 : 42)),
        Text(player, style: TextStyle(color: playerColor, fontSize: device ? 28 : 36)),
      ],
    ),
  );
}
