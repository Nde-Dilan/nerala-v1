import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/common/loading_builder.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_cubit.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_state.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';
import 'package:other_screens/presentation/profile/widgets/custom_inkwell.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style =
        TextStyle(color: darkColor, fontSize: 19, fontWeight: FontWeight.bold);

    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: scaffoldBgColor,
          surfaceTintColor: scaffoldBgColor,
          leading: BackButton(
            onPressed: () {
              AppNavigator.pushReplacement(context, HomePage());
            },
          ),
          title: Text(
            'Profile',
            style: TextStyle(
                color: seedColor, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: scaffoldBgColor,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Stack(
                children: [
                  BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
                    builder: (context, state) {
                      if (state is UserInfoLoading) {
                        return Center(child: const DefaultLoadingBuilder());
                      }

                      if (state is UserInfoLoaded) {
                        return CircleAvatar(
                          radius: 70.0,
                          backgroundImage: NetworkImage(state.user.image),
                        );
                      }

                      return Container();
                    },
                  ),
                  Positioned(
                      bottom: 20,
                      right: 0,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: seedColor,
                              border: Border.all(width: 4, color: seedColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 15,
                              color: darkColor,
                            )),
                      ))
                ],
              ),
              BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
                builder: (BuildContext context, state) {
                  if (state is UserInfoLoading) {}
                  if (state is UserInfoLoaded) {
                    return Text(
                      state.user.firstName,
                      style: style,
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 1.0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: optionList.length,
                  itemBuilder: (context, index) {
                    return CustomInkWell(
                      name: optionList[index]["name"].toString(),
                      onTap: optionList[index]["onTap"].toString(),
                      style: optionList[index]["style"] as TextStyle,
                      icon: optionList[index]["icon"] as IconData,
                    );
                  }),
            ])),
      ),
    );
  }
}

const double fontSize = 18;
final optionList = [
  {
    "name": "Edit Personal Details",
    "onTap": "detail",
    "style": const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000)),
    "icon": Icons.person_outline,
  },
  {
    "name": "Appearance",
    "onTap": "/home",
    "style": const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000)),
    "icon": Icons.settings,
  },
  {
    "name": "Notifications",
    "onTap": "/home",
    "style": const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000)),
    "icon": Icons.notifications_outlined,
  },
  {
    "name": "Help",
    "onTap": "/hhh",
    "style": const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000)),
    "icon": Icons.help_center,
  },
  {
    "name": "About",
    "onTap": "/home/payment",
    "style": const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000)),
    "icon": Icons.info,
  },
  {
    "name": "Logout",
    "onTap": "/",
    "style": const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000)),
    "icon": Icons.logout,
  },
];

final editImageOptionList = [
  {
    "name": "Select from Gallery",
    "onTap": "/home",
    "style": const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000)),
    "icon": Icons.grid_on_rounded,
  },
  {
    "name": "Take a Picture",
    "onTap": "/home",
    "style": const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000)),
    "icon": Icons.camera_enhance,
  },
];
