import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzler/constants.dart';
import 'package:quizzler/controllers/question_controller.dart';
import 'package:quizzler/models/Questions.dart';

import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {Key key,
      // we pass question here
      @required this.question})
      : super(key: key);

  final Questions question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      child: Column(children: [
        Text(
          question.question,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: kBlackColor),
        ),
        SizedBox(height: kDefaultPadding / 2),
        ...List.generate(
          question.options.length,
          (index) => Option(
            index: index,
            text: question.options[index],
            press: () => _controller.checkAns(question, index),
          ),
        )
      ]),
    );
  }
}
