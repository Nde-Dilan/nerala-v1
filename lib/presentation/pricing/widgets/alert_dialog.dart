import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';

Future<dynamic> showDefaultDialog({
  required BuildContext context,
  required String title,
  message,
  Color? backgroundColor,
  IconData? icon = Icons.info,
  required List<Widget> actions,
  Widget? content,
  iconWidget,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return OrientationBuilder(builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;

        return BackdropFilter(
            filter: blurFilter,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.spaceAround,
              insetPadding: isLandscape
                  ? EdgeInsets.symmetric(vertical: 24.0, horizontal: 100.0)
                  : Theme.of(context).dialogTheme.insetPadding,
              icon: iconWidget,
              title: Text(title),
              titleTextStyle: AppTextStyles.h2.copyWith(color: darkColor),
              content: content ??
                  Text(
                    message,
                    style: AppTextStyles.body.copyWith(color: darkColor),
                  ),
              iconColor: backgroundColor ?? seedColor,
              contentTextStyle: AppTextStyles.body.copyWith(color: darkColor),
              actions: actions,
              actionsOverflowButtonSpacing: 8.0,
            ));
      });
    },
  );
}
