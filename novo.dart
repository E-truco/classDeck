import 'dart:io';
import 'dart:math';

class Card {
  late String value;
  late String suit;
  late int trueValue;
  late int suitValue;
  late int teamOwner;

  Card(this.value, this.suit, this.trueValue, this.suitValue);

  @override
  String toString() => "[($trueValue)($suitValue) | $value of $suit]";
}

class Player{
  late int id;
  late String name;
  late int points;
  late List<Card> hand;

  Player(this.id, this.name, this.points, this.hand);

  @override
  String toString() => "ID: $id | Name: $name | Points: $points | Hand: $hand";
}

class Deck {
  int cardbattle(List<Card> cards, bool useSuitWhenTied) {
    int face1 = cards[0].trueValue;
    int face2 = cards[1].trueValue;

    int suit1 = cards[0].suitValue;
    int suit2 = cards[1].suitValue;

    if (face1 > face2) {
      return 1;
    } else if (face2 > face1) {
      return 2;
    } else if (useSuitWhenTied == true) {
      if (suit1 > suit2) {
        return 1;
      } else if (suit2 > suit1) {
        return 2;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  List<Card> addToPile(List<Card> pile, Card cardToBeAdded, bool checkSuits) {
    if (pile.isEmpty) {
      pile.add(cardToBeAdded);
      return pile;
    }

    Card topCard = pile[0];
    int strongest = cardbattle([cardToBeAdded, topCard], checkSuits);

    if (strongest == 1 || strongest == 0) {
      pile.insert(0, cardToBeAdded);
    } else {
      pile.add(cardToBeAdded);
    }

    return pile;
  }

  Player createPlayer() {
    int id;
    String name;

    print("-----------------------");
    print("Create Player");
    print("-----------------------");
    stdout.write("Insert player ID: ");
    String? inputID = stdin.readLineSync();

    if (inputID != null && inputID != '') {
      id = int.parse(inputID);
    } else {
      Random random = new Random(DateTime.now().microsecondsSinceEpoch);
      id = random.nextInt(99);
    }

    stdout.write("Insert player name: ");
    String? inputName = stdin.readLineSync();

    if (inputName != null && inputName != '') {
      name = inputName;
    } else {
      name = "Player$id";
    }

    print("-----------------------");
    print("Player created.");
    print("ID: $id");
    print("Name: $name");
    print("-----------------------");

    Player player = new Player(id, name, 0, []);
    return player;
  }

  List<Card> shuffler(List<Card> deck, int amountOfDecks) {
    List<Card> shuffledDeck = [];
    Random random = new Random(DateTime.now().microsecondsSinceEpoch);

    for (int i = 1; i <= amountOfDecks; i++) {
      shuffledDeck.addAll(deck);
    }

    shuffledDeck.shuffle(random);
    return shuffledDeck;
  }
}
