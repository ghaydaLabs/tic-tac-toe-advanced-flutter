import '../models/game_model.dart';

class GameController {
  GameModel game = GameModel();

  void tap(int index) {
    if (game.gameBoard[index] == '' && game.winLocation.isEmpty) {
      game.gameBoard[index] = game.turn ? 'O' : 'X';
      game.moveHistory.add(index);
      game.turn = !game.turn;
    }
  }

  void undo() {
    // Undo allowed only if game is still active
    if (game.moveHistory.isNotEmpty && game.winLocation.isEmpty) {
      int lastIndex = game.moveHistory.removeLast();
      game.gameBoard[lastIndex] = '';
      game.turn = !game.turn;
    }
  }

  void clear() {
    game.gameBoard = List.filled(9, '');
    game.winLocation = [];
    game.moveHistory = [];
    game.turn = true;
  }

  String? checkWinner() {
    // Each pattern checks a row, column, or diagonal
    const patterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var i in patterns) {
      if (game.gameBoard[i[0]] != '' &&
          game.gameBoard[i[0]] == game.gameBoard[i[1]] &&
          game.gameBoard[i[0]] == game.gameBoard[i[2]]) {
        game.winLocation = i;
        return game.gameBoard[i[0]];
      }
    }
    if (game.winLocation.isEmpty && !game.gameBoard.contains('')) {
      game.scoreDraw++;
      return "Draw";
    }

    return null;
  }
}
