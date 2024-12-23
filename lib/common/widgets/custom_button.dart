import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/bloc/button/button_state.dart';
import 'package:other_screens/common/bloc/button/button_state_cubit.dart';
import 'package:other_screens/common/constants.dart';

Logger _log = Logger('main.dart');

class CustomButton extends StatelessWidget {
  final bool? isEnabled;
  final String text;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    this.isEnabled,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
        builder: (context, state) {
      if (state is ButtonLoadingState) {
        _log.info("Button Loading");
        return _loading(context);
      }
      _log.info("Button Loading state done ");

      return _initial(context);
    });
  }

  Widget _loading(BuildContext context) {
    return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(mediaWidth(context) / 0.9, mediaWidth(context) / 6),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBackgroundColor: Colors.grey,
        ),
        child: Container(
            height: 50,
            alignment: Alignment.center,
            child: const CircularProgressIndicator()));
  }

  Widget _initial(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(mediaWidth(context) / 0.9, mediaWidth(context) / 6),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        disabledBackgroundColor: Colors.grey,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
