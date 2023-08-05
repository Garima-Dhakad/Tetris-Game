import 'dart:ui';

import 'package:zoom_clone/board.dart';

import 'values.dart';

class Piece {
  Tetromino type;

  Piece({required this.type});

// the piece is just a list of integers
  List<int> position = [];

//color of tetris piece
  Color get color {
    return tetrominoColor[type] ?? const Color(0xFFFFFFFF);
  }

  // generate the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  //move pieces
  void movePieces(Directions directions) {
    switch (directions) {
      case Directions.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Directions.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Directions.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  //rotate piece
  int rotationState = 1;
  void rotatePiece() {
    //new position

    List<int> newPosition = [];

    switch (type) {
      /*

                                              L  

      */
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            /*

          *
          *
          * *

          */
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            // check that new position is a valid move before assigning it to real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

          * * *
          *

          */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

          * *
            *
            *

          */
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

              *
          * * *

          */
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
      /*

                                              J
                                              
      */
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            /*

          *
          *
          * *

          */
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            // check that new position is a valid move before assigning it to real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

          * * *
          *

          */
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

          * *
            *
            *

          */
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

              *
          * * *

          */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
//

      // I

      //
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            /*

          *
          *
          * *

          */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            // check that new position is a valid move before assigning it to real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

          * * *
          *

          */
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength * 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

          * *
            *
            *

          */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

              *
          * * *

          */
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
//

//O

//
      case Tetromino.O:
        break;

      //

      // S

      //

      case Tetromino.S:
        switch (rotationState) {
          case 0:
            /*

          *
          *
          * *

          */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            // check that new position is a valid move before assigning it to real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

          * * *
          *

          */
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

          * *
            *
            *

          */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

              *
          * * *

          */
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;

      //

      //Z

      //

      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            /*

          *
          *
          * *

          */
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // check that new position is a valid move before assigning it to real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

          * * *
          *

          */
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

          * *
            *
            *

          */
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

              *
          * * *

          */
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;

      //

      //T

      //

      case Tetromino.T:
        switch (rotationState) {
          case 0:
            /*

          *
          *
          * *

          */
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            // check that new position is a valid move before assigning it to real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

          * * *
          *

          */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

          * *
            *
            *

          */
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*

              *
          * * *

          */
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
    }
  }

  // check valid position
  bool positionIsValid(int position) {
    //get row and col of position
    int row = (position / rowLength).floor();
    int col = position % rowLength;
    //if the position is taken , return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    // otherwisw position is valid so return true
    else {
      return true;
    }
  }

  // check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      //return false if any position is already taken
      if (!positionIsValid(pos)) {
        return false;
      }

      //get the col of position
      int col = pos % rowLength;

      //check if the first or last col is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    //if there is a piece in the first and last col, it is going through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}
