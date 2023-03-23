import 'questions.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizBrain{


  int questionNumber =0;
  List<Icon> answerIcons= [];

  List<Question>questionsBank=[
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was "Moon".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called "Backrub".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),

  ];

  void questionIncrease(icon,color){

    if(questionNumber<questionsBank.length-1){
      answerIcons.add(Icon(icon,color: color,));
      questionNumber++;
    }
  }

  void checkAnswer(bool answer,context) {
    bool? correctAnswer = getCorrectAnswer();

    if (isFinished() == true) {
      //TODO Step 4 Part A - show an alert using rFlutter_alert,

      //This is the code for the basic alert from the docs for rFlutter Alert:
      //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

      //Modified for our purposes:
      Alert(
        context: context,
        title: 'Finished!',
        desc: 'You\'ve reached the end of the quiz.',
      ).show();

      //TODO Step 4 Part C - reset the questionNumber,
      reset();

      //TODO Step 4 Part D - empty out the scoreKeeper.
      answerIcons = [];
    }

    //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
    else {
      if (correctAnswer == answer) {
        answerIcons.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        answerIcons.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      nextQuestion();
    }
  }


  void nextQuestion() {
    if (questionNumber < questionsBank.length - 1) {
      questionNumber++;
    }
  }

  String? getQuestionText() {

    return questionsBank[questionNumber].questionText;
  }

  bool? getCorrectAnswer() {
    return questionsBank[questionNumber].answerText;
  }

  //TODO: Step 3 Part A - Create a method called isFinished() here that checks to see if we have reached the last question. It should return (have an output) true if we've reached the last question and it should return false if we're not there yet.

  bool isFinished() {
    if (questionNumber >= questionsBank.length - 1) {
      //TODO: Step 3 Part B - Use a print statement to check that isFinished is returning true when you are indeed at the end of the quiz and when a restart should happen.

      print('Now returning true');
      return true;

    } else {
      return false;
    }
  }

  //TODO: Step 4 part B - Create a reset() method here that sets the questionNumber back to 0.
  void reset() {
    questionNumber = 0;
  }
}