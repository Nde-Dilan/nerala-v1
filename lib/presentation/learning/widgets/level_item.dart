import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/music/source/audio_service.dart';
import 'package:other_screens/presentation/learning/pages/question_page.dart';

class LevelItem extends StatefulWidget {
  const LevelItem(
      {super.key, required this.levelName, required this.levelImage});

  final String levelName;
  final String levelImage;

  @override
  State<LevelItem> createState() => _LevelItemState();
}

class _LevelItemState extends State<LevelItem> {
  late AudioService _audioService;

  @override
  void initState() {
    super.initState();
    _audioService = AudioService();
    _audioService.pause();
  }

  @override
  void dispose() {
    _audioService.play();
    super.dispose();
  }

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
                widget.levelName,
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
                              levelImage: widget.levelImage,
                              levelName: widget.levelName));
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
            tag: widget.levelName,
            child: Image.asset(
              widget.levelImage,
              width: mediaWidth(context) / 4.6,
            ),
          ),
        ],
      ),
    );
  }
}
