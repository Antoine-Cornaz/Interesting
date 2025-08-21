// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
  nameOfExercise: json['name_of_exercise'] as String,
  instructions: json['instructions'] as String,
  questions:
      (json['questions'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  solution: json['solution'] as String? ?? '',
  answers:
      (json['answers'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  fakeAnswers:
      (json['fake_answers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
);

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
  'name_of_exercise': instance.nameOfExercise,
  'instructions': instance.instructions,
  'questions': instance.questions,
  'solution': instance.solution,
  'answers': instance.answers,
  'fake_answers': instance.fakeAnswers,
};
