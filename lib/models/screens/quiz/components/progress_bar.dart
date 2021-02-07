import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzler/constants.dart';
import 'package:quizzler/controllers/question_controller.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35.0,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF3F4768), width: 3.0),
          borderRadius: BorderRadius.circular(50.0)),
      child: GetBuilder<QuestionController>(
          init: QuestionController(),
          builder: (controller) {
            print(controller.animation.value);
            return Stack(
              children: [
                // Layout builder provide us the available space for the Container
                //  constraints.maxWidth needed for our animation
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                // from 0 to 1 it takes 1 minute.
                    width: constraints.maxWidth *
                        controller.animation.value.toDouble(),
                    decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${(controller.animation.value * 60).round()} seconds'),
                        WebsafeSvg.asset(
                          "assets/icons/clock.svg",
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
