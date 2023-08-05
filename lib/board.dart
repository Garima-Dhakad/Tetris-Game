import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zoom_clone/values.dart';
import 'piece.dart';
import 'pixel.dart';

/*

Game Board
this is 2*2 grid with null representing an empty space
a nun empty space will have color to represent the landed pieces

*/

//create game board

List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // grid dimensions

  Piece currentPiece = Piece(type: Tetromino.L);

  //current score
  int currentScore = 0;

  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    // start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    // feame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  //game Loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // clear lines
        clearLines();

        // check landing
        checkLanding();

        //check if game is over
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }

        //move current piece down
        currentPiece.movePieces(Directions.down);
      });
    });
  }

  //game over msg
  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Game Over'),
              content: Text("Your Score is : $currentScore"),
              actions: [
                TextButton(
                    onPressed: () {
                      resetGame();
                      Navigator.pop(context);
                    },
                    child: const Text('Play Again'))
              ],
            ));
  }

  //reset game
  void resetGame() {
    //clear the game board
    gameBoard =
        List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

    //new game
    gameOver = false;
    currentScore = 0;

    //create new piece
    createNewPiece();

    //start game again
    startGame();
  }

  // CHECK FOR COLLISION IN FUTURE POSITION
  // return true -> there is collision
  // return false -> there is no collision
  // bool checkCollision(Directions directions) {
  //   // loop through each position of the current piece
  //   for (int i = 0; i < currentPiece.position.length; i++) {
  //     // calculate the row and column of the current position
  //     int row = (currentPiece.position[i] / rowLength).floor();
  //     int col = currentPiece.position[i] % rowLength;

  //     //adjust the row and col based on the direction
  //     if (directions == Directions.left) {
  //       col -= 1;
  //     } else if (directions == Directions.right) {
  //       col += 1;
  //     } else if (directions == Directions.down) {
  //       row += 1;
  //     }

  //     // check if the puece is out of bound (either too low or too far to the left or right)
  //     if (row >= colLength || col < 0 || col >= rowLength) {
  //       return true;
  //     }
  //   }
  //   // if no collision are detected,  return false
  //   return false;
  // }

  bool checkCollision(Directions directions) {
    // loop through all direction index
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the index of the current piece
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      // directions
      if (directions == Directions.down) {
        row++;
      } else if (directions == Directions.right) {
        col++;
      } else if (directions == Directions.left) {
        col--;
      }

      // check for collisions with boundaries
      if (col < 0 || col >= rowLength || row >= colLength) {
        return true;
      }

      // check for collisions with other landed pieces
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    // if there is no collision return false
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(Directions.down)) {
      //mark position as occupied on the gameBoard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      //once landed create new piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // create a random object to generate random tetromino types
    Random rand = Random();

    // create a new piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    //
    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Directions.left)) {
      setState(() {
        currentPiece.movePieces(Directions.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Directions.right)) {
      setState(() {
        currentPiece.movePieces(Directions.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clrae lines
  void clearLines() {
    // step 1: Loop through each row of the game board from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      //step 2: Initialize a variable to track if the row if full
      bool rowIsFull = true;

      // step 3: check if the row is full (all col in the row are filled with pieces)
      for (int col = 0; col < rowLength; col++) {
        //if there's anempty col, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // step 4: if the row if full, clear the row and shift rows down
      if (rowIsFull) {
        //step 5: move all rows above the cleared row down by one position
        for (int r = row; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        //step 6: set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);
        // step 7: increse the score
        currentScore++;
      }
    }
  }

  //game over
  bool isGameOver() {
    // check if any col in the top row are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    //if top row is empty, game is not over
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * colLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength),
              itemBuilder: (context, index) {
                //get row and col of each index
                int row = (index / rowLength).floor();
                int col = index % rowLength;

                //current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                  );
                }
                //landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                    color: tetrominoColor[tetrominoType],
                  );
                }
                // blank pixel
                else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              },
            ),
          ),

          // Score

          Text(
            'Score:  $currentScore',
            style: const TextStyle(color: Colors.white),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 50, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // game controllers
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: moveLeft,
                ),

                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.rotate_right),
                  onPressed: rotatePiece,
                ),

                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: moveRight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
