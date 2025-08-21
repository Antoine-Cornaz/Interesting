import 'package:flutter_test/flutter_test.dart';
import 'package:interesting/data/repositories/assessment_repository.dart';
import 'package:interesting/features/assessment/logic/assessment_manager.dart';

void main() {
  group("Testing multiple answer", () {
    test('basic know nothing', () {
      // Create a card manager and display the instruction
      AssessmentManager am = AssessmentManager();

      AssessmentRepository ar = AssessmentRepository();

      expect(am.isInstruction, true);
      expect(am.isFinished, false);
      expect(am.currentCard, ar.cardInstruction[0]);

      am.answerYes();

      expect(am.isInstruction, false);
      expect(am.isFinished, false);
      expect(am.currentCard, ar.cardsArithmetic[0]);

      am.answerNo();

      expect(am.isInstruction, false);
      expect(am.isFinished, false);
      expect(am.currentCard, ar.cardsArithmetic[1]);

      am.answerNo();

      expect(am.isInstruction, false);
      expect(am.isFinished, true);
      expect(am.currentCard != ar.cardsArithmetic[2], true);
      expect(am.finalLevel, 1);
    });

    test('basic know everything', () {
      // Create a card manager and display the instruction
      AssessmentManager am = AssessmentManager();

      AssessmentRepository ar = AssessmentRepository();

      expect(am.isInstruction, true);
      expect(am.isFinished, false);
      expect(am.currentCard, ar.cardInstruction[0]);

      am.answerYes();

      List levels = [1, 5, 7, 8];

      for (int j in levels) {
        for (int i = 0; i < 5; i++) {
          //print("i $i, j $j, ${cardManager.currentCard}");
          expect(am.isInstruction, false);
          expect(am.isFinished, false);
          expect(
            am.currentCard,
            ar.allCards[j][i],
            reason: "question $i of level $j",
          );

          am.answerYes();
        }
      }

      expect(am.isInstruction, false);
      expect(am.isFinished, true);
      expect(am.finalLevel, 8);
    });

    test('basic know 5 of 6', () {
      // Create a card manager and display the instruction
      AssessmentManager am = AssessmentManager();

      AssessmentRepository ar = AssessmentRepository();

      expect(am.isInstruction, true);
      expect(am.isFinished, false);
      expect(am.currentCard, ar.cardInstruction[0]);

      am.answerYes();

      List levels = [1, 5, 7, 8];

      for (int j in levels) {
        for (int i = 0; i < 6; i++) {
          //print("i $i, j $j, ${cardManager.currentCard}");
          expect(am.isInstruction, false);
          expect(am.isFinished, false);
          expect(
            am.currentCard,
            ar.allCards[j][i],
            reason: "question $i of level $j",
          );

          if (i == 2) {
            am.answerNo();
          } else {
            am.answerYes();
          }
        }
      }

      expect(am.isInstruction, false);
      expect(am.isFinished, true);
      expect(am.finalLevel, 8);
    });

    test("basic know 4 of 6, don't know the last 2", () {
      /*
      The test succeed level 1 and then fail all other levels.
       */

      // Create a card manager and display the instruction
      AssessmentManager am = AssessmentManager();

      AssessmentRepository ar = AssessmentRepository();

      expect(am.isInstruction, true);
      expect(am.isFinished, false);
      expect(am.currentCard, ar.cardInstruction[0]);

      am.answerYes();

      List levels = [1, 5, 3, 2];

      for (int j in levels) {
        int iMax = j == 1 ? 5 : 6;
        for (int i = 0; i < iMax; i++) {
          //print("i $i, j $j, ${am.currentCard}");
          expect(am.isInstruction, false);
          expect(am.isFinished, false);
          expect(
            am.currentCard,
            ar.allCards[j][i],
            reason: "question $i of level $j",
          );

          if (i >= 4 && j != 1) {
            am.answerNo();
          } else {
            am.answerYes();
          }
        }
      }

      expect(am.isInstruction, false);
      expect(am.isFinished, true);
      expect(am.finalLevel, 1);
    });

    test("basic know 4 of 6, don't know the last 2", () {
      /*
      The test succeed level 1 and then fail all other levels.
      Same as previous one but with maybe instead of no
       */

      // Create a card manager and display the instruction
      AssessmentManager am = AssessmentManager();

      AssessmentRepository ar = AssessmentRepository();

      expect(am.isInstruction, true);
      expect(am.isFinished, false);
      expect(am.currentCard, ar.cardInstruction[0]);

      am.answerYes();

      List levels = [1, 5, 3, 2];

      for (int j in levels) {
        int iMax = j == 1 ? 5 : 6;
        for (int i = 0; i < iMax; i++) {
          //print("i $i, j $j, ${am.currentCard}");
          expect(am.isInstruction, false);
          expect(am.isFinished, false);
          expect(
            am.currentCard,
            ar.allCards[j][i],
            reason: "question $i of level $j",
          );

          if (i >= 4 && j != 1) {
            am.answerMaybe();
          } else {
            am.answerYes();
          }
        }
      }

      expect(am.isInstruction, false);
      expect(am.isFinished, true);
      expect(am.finalLevel, 1);
    });
  });
}
