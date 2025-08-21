import 'package:flutter_test/flutter_test.dart';
import 'package:interesting/data/card_repository.dart';


void main() {


    test('check size deck', () {

      // Create a card manager and display the instruction

      CardRepository cr = CardRepository();

      expect(cr.allCards.length, 9);

      expect(cr.cardInstruction.length, 1);

      expect(cr.cardsArithmetic.length, 6);
      expect(cr.cardsPreAlgebra.length, 6);
      expect(cr.cardsElementaryAlgebra.length, 6);
      expect(cr.cardsSystemEquation.length, 6);
      expect(cr.cardsIntermediateAlgebra.length, 6);
      expect(cr.cardsPreCalculus.length, 6);
      expect(cr.cardsCalculus.length, 6);
      expect(cr.cardsDifferentialEqu.length, 6);

    });

}