import 'package:json_annotation/json_annotation.dart';
// To create the exercise.g.dart below, run the following command:
// dart run build_runner build
part 'exercise.g.dart';

@JsonSerializable()
class Exercise {
  @JsonKey(name: 'name_of_exercise')
  final String nameOfExercise;

  final String instructions;

  // Add a default value for this list
  @JsonKey(defaultValue: [])
  final List<String> questions;

  // It's good practice to provide a default for all optional fields
  @JsonKey(defaultValue: '')
  final String solution;

  // Add a default value for this list
  @JsonKey(defaultValue: [])
  final List<String> answers;

  // Add a default value for this list
  @JsonKey(name: 'fake_answers', defaultValue: [])
  final List<String> fakeAnswers;

  Exercise({
    required this.nameOfExercise,
    required this.instructions,
    required this.questions,
    required this.solution,
    required this.answers,
    required this.fakeAnswers,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}