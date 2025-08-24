import 'package:interesting/data/models/exercise.dart';

const List<String> questions1 = ["3+5=", "5+7=", "5+?=8"];

const List<String> answers1 = ["8", "12", "3", "2", "6", "7", "10"];

const List<String> instructions1 = ["Hello, today we will work on addition"];
var subProblem1 = SubProblemData(
  questions: questions1,
  answers: answers1,
  instructions: instructions1,
);

const List<String> questions2 = ["5-3=", "3-5=", "8-?=2", "?-5=2"];

const List<String> answers2 = ["2", "-2", "6", "7", "5", "-7", "10"];

const List<String> instructions2 = [
  "Good work, let's continue on substraction",
];

var subProblem2 = SubProblemData(
  questions: questions2,
  answers: answers2,
  instructions: instructions2,
);

const List<String> questions3 = ["5+3=", "12-5", "8-?=2", "?-14=16"];

const List<String> answers3 = ["8", "7", "6", "30", "-2", "2", "-4"];

const List<String> instructions3 = [];

var subProblem3 = SubProblemData(
  questions: questions3,
  answers: answers3,
  instructions: instructions3,
);

var problem1 = [subProblem1 /*, subProblem2, subProblem3*/];
var subExercise1 = Exercise(
  nameOfExercise: "arithmetic 1/3",
  instructions: "Solve the following additions",
  questions: questions1,
  solution: "No solution for the moment",
  answers: answers1.sublist(0, 3),
  fakeAnswers: answers1.sublist(3),
);
var subExercise2 = Exercise(
  nameOfExercise: "arithmetic 2/3",
  instructions: "Solve the following additions",
  questions: questions2,
  solution: "No solution for the moment",
  answers: answers2.sublist(0, 4),
  fakeAnswers: answers2.sublist(4),
);
var subExercise3 = Exercise(
  nameOfExercise: "arithmetic 3/3",
  instructions: "Solve the following additions and substraction",
  questions: questions3,
  solution: "No solution for the moment",
  answers: answers3.sublist(0, 4),
  fakeAnswers: answers3.sublist(4),
);
var exercise1 = [subExercise1 /*, subExercise2, subExercise3*/];

class SubProblemData {
  final List<String>? answers;
  final List<String>? questions;
  final List<String>? instructions;

  SubProblemData({this.questions, this.answers, this.instructions})
    : assert(
        (questions?.length ?? 0) <= (answers?.length ?? 0),
        'Number of questions (${questions?.length ?? 0}) '
        'cannot exceed number of answers (${answers?.length ?? 0}).',
      );
}
