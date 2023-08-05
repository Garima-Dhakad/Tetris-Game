import 'dart:ui';

int rowLength = 10;
int colLength = 15;

enum Directions {
  left,
  right,
  down,
}

enum Tetromino { L, J, I, O, S, Z, T }

const Map<Tetromino, Color> tetrominoColor = {
  Tetromino.L: Color(0xFFFFA500),
  Tetromino.J: Color.fromARGB(255, 0, 102, 255),
  Tetromino.I: Color.fromARGB(255, 242, 0, 255),
  Tetromino.O: Color.fromARGB(255, 149, 254, 254),
  Tetromino.Z: Color(0xFFFF0000),
  Tetromino.T: Color.fromARGB(255, 144, 0, 255),
};
