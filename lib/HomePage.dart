import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isTurn = true;
  List<String> displayEx01 = ["", "", "", "", "", "", "", "", ""];

  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int zeroScore = 0;
  int crossScore = 0;
  int filledBoxes = 0;

  static var myNewFont = GoogleFonts.pressStart2P(
      textStyle: TextStyle(
          color: Colors.yellow[800], letterSpacing: 10, fontSize: 25));
  static var myNewFontWhite = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.yellow[800], letterSpacing: 3, fontSize: 25));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[800], //yellow
      body: Column(
        children: [
          Expanded(
            child: Container(
                color: Color(0xff00154f), //black
                child: Center(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 60.0)),
                      Text(
                        'TIC TAC TOE',
                        style: myNewFont,
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff00154f))),
                      child: Center(
                        child: Text(
                          displayEx01[index],
                          style: TextStyle(
                              color: Color(0xff00154f), fontSize: 100),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              color: Color(0xff00154f), //black
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player O:',
                          style: myNewFontWhite,
                        ),
                        Text(
                          zeroScore.toString(),
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player X:',
                          style: myNewFontWhite,
                        ),
                        Text(
                          crossScore.toString(),
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void tapped(
    int index,
  ) {
    setState(() {
      if (isTurn && displayEx01[index] == "") {
        displayEx01[index] = "0";
        filledBoxes++;
      } else if (!isTurn && displayEx01[index] == "") {
        displayEx01[index] = "X";
        filledBoxes++;
      }

      isTurn = !isTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    if (displayEx01[0] != "" &&
        displayEx01[0] == displayEx01[1] &&
        displayEx01[1] == displayEx01[2]) {
      showWinDialog(displayEx01[0]);
    } else if (displayEx01[3] != "" &&
        displayEx01[3] == displayEx01[4] &&
        displayEx01[4] == displayEx01[5]) {
      showWinDialog(displayEx01[3]);
    } else if (displayEx01[6] != "" &&
        displayEx01[6] == displayEx01[7] &&
        displayEx01[7] == displayEx01[8]) {
      showWinDialog(displayEx01[6]);
    } else if (displayEx01[0] != "" &&
        displayEx01[0] == displayEx01[3] &&
        displayEx01[3] == displayEx01[6]) {
      showWinDialog(displayEx01[0]);
    } else if (displayEx01[1] != "" &&
        displayEx01[1] == displayEx01[4] &&
        displayEx01[4] == displayEx01[7]) {
      showWinDialog(displayEx01[1]);
    } else if (displayEx01[2] != "" &&
        displayEx01[2] == displayEx01[5] &&
        displayEx01[5] == displayEx01[8]) {
      showWinDialog(displayEx01[2]);
    } else if (displayEx01[0] != "" &&
        displayEx01[0] == displayEx01[4] &&
        displayEx01[4] == displayEx01[8]) {
      showWinDialog(displayEx01[0]);
    } else if (displayEx01[2] != "" &&
        displayEx01[2] == displayEx01[4] &&
        displayEx01[4] == displayEx01[6]) {
      showWinDialog(displayEx01[2]);
    } else if (filledBoxes == 9) {
      showDrawDialog();
    }
  }

  void showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff00154f),
            title: Text(
              'Draw',
              style: myNewFontWhite,
            ),
            actions: [
              FlatButton(
                child: Text(
                  'Play Again!',
                ),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff00154f),
            title: Text(
              "Winner is: " + winner,
              style: myNewFontWhite,
            ),
            actions: [
              FlatButton(
                child: Text(
                  'Play Again!',
                ),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (winner == '0')
      zeroScore++;
    else if (winner == 'X') crossScore++;
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayEx01[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
