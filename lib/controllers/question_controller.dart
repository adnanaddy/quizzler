import 'dart:ffi';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quizzler/models/Questions.dart';

// we use Getx Pakcage for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Here we animate out progress bar

  AnimationController _animationController;
  Animation _animation;
  // we use get here so that we can accessour animation outside.
  Animation get animation => this._animation;

  PageController _pageController;
  PageController get pageController => this._pageController;

  List<Questions> _questions = sample_data
      .map(
        (question) => Questions(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<Questions> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int _correctAns;
  int get correctAns => this._correctAns;

  int _selectedAns;
  int get selectedAns => this._selectedAns;

// obs is from get pkg. see the docs for more
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  // called immediatly after the widget is allocated memory.
  @override
  void onInit() {
    // Our animation duration is 60 seconds
    // so our plan is tol fill the progress bar within 60 seconds
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });
    // start our animation
    // Once 60s are completed goto the next next question.
    _animationController.forward().whenComplete(nextQuestion);

    _pageController = PageController();
    super.onInit();
  }

// called just before the controller is started from mwmory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Questions question, int selectedIndex) {
    // this run once the user press any option.
    _isAnswered = true;
    _correctAns = selectedIndex;
    _selectedAns = selectedAns;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // once an option is selected the counter is stopped.
    _animationController.stop();
    update();

    // once a user select an answer, after 3 seconds it will go to the next question
    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // then start it again
      // Once the timer is finished go to the next question.
      _animationController.forward().whenComplete(nextQuestion);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
