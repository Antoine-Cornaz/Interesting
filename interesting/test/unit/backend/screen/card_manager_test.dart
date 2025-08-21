import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interesting/backend/screen/card_manager.dart';
import 'package:interesting/screen/swipe_screen.dart';
import 'package:interesting/data/card_repository.dart';


void main() {
  group("Testing multiple answer", () {

    test('basic know nothing', () {

      // Create a card manager and display the instruction
      CardManager cm = CardManager();

      CardRepository cr = CardRepository();

      expect(cm.isInstruction, true);
      expect(cm.isFinished, false);
      expect(cm.currentCard, cr.cardInstruction[0]);

      cm.answerYes();

      expect(cm.isInstruction, false);
      expect(cm.isFinished, false);
      expect(cm.currentCard, cr.cardsArithmetic[0]);

      cm.answerNo();

      expect(cm.isInstruction, false);
      expect(cm.isFinished, false);
      expect(cm.currentCard, cr.cardsArithmetic[1]);

      cm.answerNo();

      expect(cm.isInstruction, false);
      expect(cm.isFinished, true);
      expect(cm.currentCard != cr.cardsArithmetic[2], true);
      expect(cm.finalLevel, 1);
    });

    test('basic know everything', () {

      // Create a card manager and display the instruction
      CardManager cm = CardManager();

      CardRepository cr = CardRepository();

      expect(cm.isInstruction, true);
      expect(cm.isFinished, false);
      expect(cm.currentCard, cr.cardInstruction[0]);

      cm.answerYes();

      List levels = [1, 5, 7, 8];

      for (int j in levels) {
        for (int i = 0; i < 5; i++) {
          //print("i $i, j $j, ${cardManager.currentCard}");
          expect(cm.isInstruction, false);
          expect(cm.isFinished, false);
          expect(cm.currentCard, cr.allCards[j][i],
              reason: "question $i of level $j");

          cm.answerYes();
        }
      }

      expect(cm.isInstruction, false);
      expect(cm.isFinished, true);
      expect(cm.finalLevel, 8);
    });

    test('basic know 5 of 6', () {

      // Create a card manager and display the instruction
      CardManager cm = CardManager();

      CardRepository cr = CardRepository();

      expect(cm.isInstruction, true);
      expect(cm.isFinished, false);
      expect(cm.currentCard, cr.cardInstruction[0]);

      cm.answerYes();

      List levels = [1, 5, 7, 8];

      for (int j in levels) {
        for (int i = 0; i < 6; i++) {
          //print("i $i, j $j, ${cardManager.currentCard}");
          expect(cm.isInstruction, false);
          expect(cm.isFinished, false);
          expect(cm.currentCard, cr.allCards[j][i],
              reason: "question $i of level $j");

          if (i == 2){
            cm.answerNo();
          }else{
            cm.answerYes();
          }
        }
      }

      expect(cm.isInstruction, false);
      expect(cm.isFinished, true);
      expect(cm.finalLevel, 8);
    });

    test("basic know 4 of 6, don't know the last 2", () {

      /*
      The test succeed level 1 and then fail all other levels.
       */

      // Create a card manager and display the instruction
      CardManager cm = CardManager();

      CardRepository cr = CardRepository();

      expect(cm.isInstruction, true);
      expect(cm.isFinished, false);
      expect(cm.currentCard, cr.cardInstruction[0]);

      cm.answerYes();

      List levels = [1, 5, 3, 2];

      for (int j in levels) {
        int iMax = j==1 ? 5 : 6;
        for (int i = 0; i < iMax; i++) {
          //print("i $i, j $j, ${cm.currentCard}");
          expect(cm.isInstruction, false);
          expect(cm.isFinished, false);
          expect(cm.currentCard, cr.allCards[j][i],
              reason: "question $i of level $j");

          if (i >= 4 && j != 1){
            cm.answerNo();
          }else{
            cm.answerYes();
          }
        }
      }

      expect(cm.isInstruction, false);
      expect(cm.isFinished, true);
      expect(cm.finalLevel, 1);
    });

    test("basic know 4 of 6, don't know the last 2", () {

      /*
      The test succeed level 1 and then fail all other levels.
      Same as previous one but with maybe instead of no
       */

      // Create a card manager and display the instruction
      CardManager cm = CardManager();

      CardRepository cr = CardRepository();

      expect(cm.isInstruction, true);
      expect(cm.isFinished, false);
      expect(cm.currentCard, cr.cardInstruction[0]);

      cm.answerYes();

      List levels = [1, 5, 3, 2];

      for (int j in levels) {
        int iMax = j==1 ? 5 : 6;
        for (int i = 0; i < iMax; i++) {
          //print("i $i, j $j, ${cm.currentCard}");
          expect(cm.isInstruction, false);
          expect(cm.isFinished, false);
          expect(cm.currentCard, cr.allCards[j][i],
              reason: "question $i of level $j");

          if (i >= 4 && j != 1){
            cm.answerMaybe();
          }else{
            cm.answerYes();
          }
        }
      }

      expect(cm.isInstruction, false);
      expect(cm.isFinished, true);
      expect(cm.finalLevel, 1);
    });
  });
}