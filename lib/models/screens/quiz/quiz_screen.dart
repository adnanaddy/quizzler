import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzler/controllers/question_controller.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // FLutter show back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(onPressed: _controller.nextQuestion, child: Text("Skip"))
        ],
      ),
      body: Body(),
    );
  }
}

