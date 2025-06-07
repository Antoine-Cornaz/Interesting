const List<String> questions1 = ["3+5=", "5+7=", "5+?=8"];

const List<String> answers1 = [
  "8", "12", "3", "2", "6", "7", "10",
];

const List<String> instructions1 = [
  "Hello, today we will work on addition",
];
var subProblem1 = SubProblemData(questions: questions1, answers: answers1, instructions: instructions1);

const List<String> questions2 = ["5-3=", "3-5=", "8-?=2", "?-5=2"];

const List<String> answers2 = [
  "2", "-2", "6", "7", "5", "-7", "10",
];

const List<String> instructions2 = [
  "Good work, let's continue on substraction",
];

var subProblem2 = SubProblemData(questions: questions2, answers: answers2, instructions: instructions2);


class SubProblemData{
  final List<String>? answers;
  final List<String>? questions;
  final List<String>? instructions;

  SubProblemData({this.questions, this.answers, this.instructions}): assert(
  (questions?.length ?? 0) <= (answers?.length ?? 0),
  'Number of questions (${questions?.length ?? 0}) '
      'cannot exceed number of answers (${answers?.length ?? 0}).',
  );
}