import 'dart:io';

class TicTacToe {
  late List<List<String>> board;
  late String currentPlayer;
  late bool gameWon;

  TicTacToe() {
    board = List.generate(3, (_) => List.filled(3, ' '));
    currentPlayer = 'X';
    gameWon = false;
  }

  void printBoard() {
    for (var row in board) {
      print(row.join(' | '));
      print('---------');
    }
  }

  void makeMove(int row, int col) {
    if (board[row][col] == ' ') {
      board[row][col] = currentPlayer;
      checkForWin(row, col);
      currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
    } else {
      print('Cell already occupied. Try again.');
    }
  }

  void checkForWin(int row, int col) {
    // Check row
    if (board[row].every((element) => element == currentPlayer)) {
      gameWon = true;
      return;
    }

    // Check column
    if (board.every((element) => element[col] == currentPlayer)) {
      gameWon = true;
      return;
    }

    // Check diagonals
    if ((row == col || row + col == 2) &&
        ((board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer) ||
            (board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer))) {
      gameWon = true;
      return;
    }

    // Check for a draw
    if (!board.any((row) => row.any((cell) => cell == ' '))) {
      gameWon = true;
      print('It\'s a draw!');
    }
  }

  bool isValidMove(int row, int col) {
    return row >= 0 && row < 3 && col >= 0 && col < 3 && board[row][col] == ' ';
  }

  void playGame() {
    print('Welcome to Tic-Tac-Toe!\n');
    printBoard();

    do {
      late int row;
      late int col;
      do {
        print('\n$currentPlayer\'s turn. Enter row (1-3) and column (1-3) separated by a space:');

        try {
          var input = stdin.readLineSync()!.split(' ');
          row = int.parse(input[0]) - 1;
          col = int.parse(input[1]) - 1;
        } catch (e) {
          print('Invalid input. Please enter two integers separated by a space.');
          continue;
        }
      } while (!isValidMove(row, col));

      makeMove(row, col);
      printBoard();
    } while (!gameWon);

    print('Game over!');

    // Ask if the players want to play again
    print('Do you want to play again? (yes/no)');
    var playAgain = stdin.readLineSync()?.toLowerCase();
    if (playAgain == 'yes') {
      resetGame();
      playGame();
    }
  }

  void resetGame() {
    board = List.generate(3, (_) => List.filled(3, ' '));
    currentPlayer = 'X';
    gameWon = false;
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.playGame();
}
