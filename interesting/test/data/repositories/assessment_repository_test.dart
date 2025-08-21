import 'package:flutter_test/flutter_test.dart';
import 'package:interesting/data/repositories/assessment_repository.dart';


void main() {


  test('check size deck', () {

    // Create a card manager and display the instruction

    AssessmentRepository ar = AssessmentRepository();

    expect(ar.allCards.length, 9);

    expect(ar.cardInstruction.length, 1);

    expect(ar.cardsArithmetic.length, 6);
    expect(ar.cardsPreAlgebra.length, 6);
    expect(ar.cardsElementaryAlgebra.length, 6);
    expect(ar.cardsSystemEquation.length, 6);
    expect(ar.cardsIntermediateAlgebra.length, 6);
    expect(ar.cardsPreCalculus.length, 6);
    expect(ar.cardsCalculus.length, 6);
    expect(ar.cardsDifferentialEqu.length, 6);

  });

}