import 'package:flutter_wordle/domain.dart';

class MatchingService {
  static Iterable<Letter> _convert(String word) {
    return word.split('').asMap().entries.map((e) => Letter(e.key, e.value, GameColor.none));
  }

  static Iterable<Letter> matches(String guess, String answer) {
    var cg = _convert(guess);
    var ca = _convert(answer);

    var greens = cg
        .where((l) => guess[l.index] == answer[l.index])
        .map((l) => Letter(l.index, l.value, GameColor.exact));

    var glg = cg.where((g) => !greens.any((l) => l.index == g.index));
    var alg = ca.where((a) => !greens.any((l) => l.index == a.index));
    var results = _notGreens(glg, alg, greens).toList();
    results.sort((a, b) => a.index.compareTo(b.index));
    return results.map((l) => Letter(l.index, l.value.toUpperCase(), l.color)).toList();
  }

  static Iterable<Letter> _notGreens(
      Iterable<Letter> guess, Iterable<Letter> answer, Iterable<Letter> results) {
    var guessList = guess.toList();
    var answerList = answer.toList();
    var resultList = results.toList();

    if (guessList.isEmpty) {
      return resultList;
    } else {
      var letter = guessList.removeAt(0);
      var i = answerList.indexWhere((l) => l.value == letter.value);
      if (i != -1) {
        answerList.removeAt(i);
        letter.color = GameColor.partial;
        resultList.add(letter);
      } else {
        resultList.add(letter);
      }
      return _notGreens(guessList, answerList, resultList);
    }
  }
}
