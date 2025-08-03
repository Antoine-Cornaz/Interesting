import '../card_repository.dart';

class CardManager {
  final List<String> _cards = CardRepository().allCards;

  int _currentIndex = 0;

  String get currentCard => _cards[_currentIndex];
  bool get isFirst => _currentIndex == 0;
  bool get isLast => _currentIndex >= _cards.length - 1;
  int get lengthCard => _cards.length;


  void accept() {
    print("accepted");
    nextCard();
  }

  void dontKnow() {
    print("I don't know");
    nextCard();
  }

  void refuse() {
    print("refused");
    nextCard();
  }

  void previousCard() {
    print("previous card");
    if (_currentIndex != 0) _currentIndex--;
  }

  void nextCard() {
    if (!isLast) _currentIndex++;
  }

  void reset() {
    _currentIndex = 0;
  }

  int get currentIndex => _currentIndex;
}


