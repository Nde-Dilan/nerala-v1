import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/music/source/audio_service.dart';
import 'package:other_screens/presentation/learning/pages/question_page.dart';
import 'package:other_screens/presentation/pricing/pages/pricing_page.dart';

class LevelItem extends StatefulWidget {
  const LevelItem(
      {super.key,
      required this.levelName,
      required this.categoryName,
      required this.levelImage,
      required this.isPremium});

  final String levelName;
  final String categoryName;
  final String levelImage;
  final bool isPremium;

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
              widget.isPremium
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            AppNavigator.push(context, PremiumPage());
                          },
                          child: Image.asset("assets/icons/pricing/crown.png"),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.levelName,
                          style: AppTextStyles.h3.copyWith(
                            color: white,
                          ),
                        )
                      ],
                    )
                  : Text(
                      widget.levelName,
                      style: AppTextStyles.h3.copyWith(color: white),
                    ),
              TextButton(
                  style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll<Size>(Size(
                          mediaWidth(context) / 3.6, mediaWidth(context) / 12)),
                      backgroundColor: WidgetStatePropertyAll(darkColor)),
                  onPressed: () {
                    //DUPLICATE
                    widget.isPremium
                        ? PremiumPage()
                        : AppNavigator.pushReplacement(
                            context,
                            QuestionPage(
                                levelImage: widget.levelImage,
                                levelName: widget.levelName, categoryName: widget.categoryName,));
                  },
                  child: GestureDetector(
                    onTap: () {
                      widget.isPremium
                          ? PremiumPage()
                          : AppNavigator.pushReplacement(
                              context,
                              QuestionPage(
                                  levelImage: widget.levelImage,
                                  levelName: widget.levelName, categoryName: widget.categoryName,));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Add this
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Change to center
                      children: [
                        Text(
                          "View",
                          style: AppTextStyles.h4.copyWith(color: white),
                        ),
                        const SizedBox(width: 8), // Add spacing

                        SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset(
                              "assets/icons/category-page/play.png",
                              fit: BoxFit.contain,
                            ))
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
