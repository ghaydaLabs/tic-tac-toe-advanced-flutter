class GameModel {
  List<String> gameBoard = List.filled(9, ''); // Represents the 3x3 board
  List<int> winLocation = [];
  List<int> moveHistory = [];

  bool turn = true; // true = Player O's turn

  int scoreX = 0;
  int scoreO = 0;
  int scoreDraw = 0;
}
