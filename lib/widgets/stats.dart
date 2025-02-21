import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_wordle/domain.dart' as stats;
import 'package:share_plus/share_plus.dart';

class Stats extends StatelessWidget {
  const Stats(this._stats, this._close, {Key? key}) : super(key: key);

  final Function _close;
  final stats.Stats _stats;

  int _getFlex(int number, int total) => (number / (number + (total - number)) * 10).ceil();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.6),
      child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
              width: 500,
              height: 670,
              child: Stack(children: [
                Positioned(
                    top: 75,
                    left: 65,
                    child: SizedBox(
                      width: 370,
                      height: 500,
                      child: Container(
                        color: const Color.fromARGB(255, 29, 29, 29),
                        child: Column(children: [
                          Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                  onPressed: () => _close(),
                                  child: const Text("X",
                                      style: TextStyle(color: Colors.white, fontSize: 20)))
                            ],
                          ),
                          const Center(
                              child: Text(
                            "STATISTICS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, right: 4),
                                  child: Column(
                                    children: [
                                      Text(
                                        _stats.played.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 36,
                                        ),
                                      ),
                                      const Text(
                                        "Played",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, right: 4),
                                  child: Column(
                                    children: [
                                      Text(
                                        _stats.percentWon.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 36,
                                        ),
                                      ),
                                      const Text(
                                        "Win %",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, right: 4),
                                  child: Column(
                                    children: [
                                      Text(
                                        _stats.streak.current.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 36,
                                        ),
                                      ),
                                      const Text(
                                        "Current Streak",
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, right: 4),
                                  child: Column(
                                    children: [
                                      Text(
                                        _stats.streak.max.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 36,
                                        ),
                                      ),
                                      const Text(
                                        "Max Streak",
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                                child: Text(
                              "GUESS DISTRIBUTION",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: _guessDistribution(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                const Spacer(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.green),
                                  onPressed: () {
                                    Share.share('Flutter Wordle ${_stats.lastGuess}/6\n${_stats.lastBoard}',
                                        subject: 'Flutter Wordle ${_stats.lastGuess}/6');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text('SHARE',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.share,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ))
              ]))),
    );
  }

  Widget _guessDistribution() {
    if (_stats.played == 0) {
      return const Center(
          child: Text(
        "No Data",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ));
    }

    var maxGuess = _stats.guessDistribution.reduce(max);
    var children = <Widget>[];

    for (var i = 0; i < _stats.guessDistribution.length; i++) {
      children.add(_statRow(i + 1, _stats.guessDistribution[i], maxGuess, isCurrent: (i + 1) == _stats.lastGuess));
    }
    return Column(children: children);
  }

  Padding _statRow(int rowNumber, int completed, int total, {bool isCurrent = false}) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: Text(
              rowNumber.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: _getFlex(completed, total),
            child: Container(
                color: isCurrent ? Colors.green : const Color.fromARGB(255, 90, 87, 87),
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    completed.toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )),
          ),
          Expanded(
            flex: _getFlex(total - completed, total),
            child: Container(),
          ),
        ],
      ),
    );
  }
}
