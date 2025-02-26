import 'package:flutter/material.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';

class DojoPage extends StatelessWidget {
  const DojoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dojo Page"),
        leading: BackButton(
          onPressed: () {
            AppNavigator.pushReplacement(context, HomePage());
          },
        ),
      ),
      body: Text("Dojo Page"),
    );
  }
}
