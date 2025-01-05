import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/loading_builder.dart';
import 'package:other_screens/data/main/mock_data.dart';
import 'package:other_screens/data/models/main/fun_fact_model.dart';
import 'package:other_screens/data/models/main/category_model.dart';
import 'package:other_screens/data/models/main/learning_stats.dart';
import 'package:other_screens/presentation/auth/pages/login_page.dart';
import 'package:other_screens/presentation/dictionary/pages/dictionary.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_cubit.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_state.dart';
import 'package:other_screens/presentation/main/methods/pages_method.dart';

// Main HomePage Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentPage = 0;
  final double tabBarHeight = 50;

  final List<Widget> _kTabPages = [
    const HomePage(),
    const DictionaryPage(),
    const LoginPage(),
    const LoginPage(),
  ];

  final List<IconData> tabIcons = [
    HugeIcons.strokeRoundedHome02,
    HugeIcons.strokeRoundedBook02,
    HugeIcons.strokeRoundedSchool01,
    HugeIcons.strokeRoundedUser,
  ];

  final List<String> tabNames = [
    'Home',
    'Words',
    'Dojo', //TODO: Explain to him that its the revision page
    'Profile', //TODO: Can implement settings into profile or vice versa
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPages.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mockStats = LearningStats(
      learningRate: 0.75,
      totalWordsLearned: 250,
      totalDaysLearned: 30,
    );
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        body: AnimatedSwitcher(
          duration: duration,
          child: IndexedStack(
            key: ValueKey<int>(currentPage),
            index: currentPage,
            children: [
              BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
                builder: (context, state) {
                  if (state is UserInfoLoading) {
                    return Center(child: const DefaultLoadingBuilder());
                  }
                  if (state is UserInfoLoaded) {
                    return SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: mediaWidth(context) / 12,
                        ),
                        child: Column(
                          spacing: mediaWidth(context) / 12,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaWidth(context) / 18),
                              child:
                                  buildHeader(mockStats, state.user.firstName),
                            ),
                            buildCarousel(funFacts),
                            buildCategoriesGrid(categories),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              //other pages
              ..._kTabPages.skip(1),
            ],
          ),
        ),
        bottomNavigationBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: UnconstrainedBox(
            child: Container(
              height: tabBarHeight,
              constraints: BoxConstraints(
                maxWidth: mediaWidth(context) - 50.0,
              ),
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xff86f16a),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: seedColor,
                    blurRadius: 8.0,
                    offset: Offset(0, 4.0),
                  ),
                ],
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  physics: const BouncingScrollPhysics(),
                  indicatorSize: TabBarIndicatorSize.label,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelColor: seedColorPalette.shade700,
                  unselectedLabelColor: seedColorPalette.shade800,
                  indicatorColor: seedColorPalette.shade400,
                  overlayColor:
                      WidgetStateProperty.all(seedColorPalette.shade50),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                  indicator: BoxDecoration(
                    color: seedColorPalette.shade100,
                    // borderRadius: BorderRadius.circular(50),
                    shape: BoxShape.circle,
                  ),
                  splashBorderRadius: BorderRadius.circular(99),
                  onTap: (index) {
                    setState(() {
                      currentPage = index;
                      _tabController.animateTo(
                        index,
                        duration: duration,
                        curve: Curves.bounceInOut,
                      );
                    });
                  },
                  tabs: List.generate(
                    _kTabPages.length,
                    (index) => Tab(
                      icon: Icon(tabIcons[index]),
                      text: tabNames[index],
                    ),
                  ),
                  dividerHeight: 0.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
