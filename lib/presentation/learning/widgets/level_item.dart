import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/presentation/learning/pages/question_page.dart';

class LevelItem extends StatelessWidget {
  const LevelItem(
      {super.key, required this.levelName, required this.levelImage});

  final String levelName;
  final String levelImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
      height: mediaWidth(context) / 2.90,
      decoration: BoxDecoration(
        color: pricingCardback,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                levelName,
                style: AppTextStyles.h2.copyWith(color: white),
              ),
              TextButton(
                  style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll<Size>(Size(
                          mediaWidth(context) / 3.6, mediaWidth(context) / 12)),
                      backgroundColor: WidgetStatePropertyAll(darkColor)),
                  onPressed: () {},
                  child: GestureDetector(
                    onTap: () {
                      AppNavigator.pushReplacement(
                          context,
                          QuestionPage(
                              levelImage: levelImage, levelName: levelName));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "View",
                          style: AppTextStyles.h4.copyWith(color: white),
                        ),
                        Image.asset("assets/icons/category-page/play.png")
                      ],
                    ),
                  ))
            ],
          ),
          Hero(
            tag: levelName,
            child: Image.asset(
              levelImage,
              width: mediaWidth(context) / 4.6,
            ),
          ),
        ],
      ),
    );
  }
}
