import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/common/loading_builder.dart';
import 'package:other_screens/data/auth/models/user_creation_req.dart';
import 'package:other_screens/data/main/mock_data.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_cubit.dart';
import 'package:other_screens/presentation/main/bloc/display_user_info_state.dart';
import 'package:other_screens/presentation/main/methods/pages_method.dart';
import 'package:other_screens/presentation/main/widgets/stats_card.dart';
import 'package:other_screens/presentation/onboarding/pages/goal_page.dart';
import 'package:other_screens/presentation/pricing/pages/pricing_page.dart';
import 'package:other_screens/presentation/pricing/widgets/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

Logger _log = Logger('home_page.dart');

final GlobalKey _firstShowcaseKey = GlobalKey();
final GlobalKey _menuShowcaseKey = GlobalKey();
final GlobalKey _lastShowcaseKey = GlobalKey();

// Main HomePage Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  int currentPage = 0;
  final double tabBarHeight = 50;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _log.info("Nothing seems to be changing");

    _tabController = TabController(
      length: kTabPages.length,
      vsync: this,
    );

    // Check onboarding status after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOnboardingStatus();
    });
  }

  void _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final hasCompletedOnboarding =
        prefs.getBool('has_completed_onboarding') ?? false;

    if (!hasCompletedOnboarding) {
      if (mounted) {
        showDefaultDialog(
          context: context,
          title: "Complete Your Profile",
          message:
              "Hey! 👋 To get the most out of your learning experience, let's set up your goals and preferences.",
          backgroundColor: seedColor,
          icon: Icons.person_outline,
          actions: [
            BlocProvider(
              create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
              child: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
                builder: (context, state) {
                   
                
                    return TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        AppNavigator.push(
                          context,
                          GoalsPage(
                            userCreationReq: UserCreationReq()
                              ..email = state.user.email
                              ..firstName = state.user.firstName,
                          ),
                        );
                      },
                      child: Text(
                        "Let's Go!",
                        style: TextStyle(
                          color: seedColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  
                },
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Maybe Later",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: BlocProvider(
        create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
        child: Scaffold(
          backgroundColor: scaffoldBgColor,
          body: RepaintBoundary(
            child: AnimatedSwitcher(
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
                        return HomeWidget(
                          state: state,
                        );
                      }
                      return Container();
                    },
                  ),
                  //other pages
                  ...kTabPages.skip(1),
                ],
              ),
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
                      kTabPages.length,
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
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key, required this.state});

  final UserInfoLoaded state;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final GlobalKey _four = GlobalKey();

  @override
  void initState() {
    super.initState();

    //Start showcase view after current widget frames are drawn.
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) => ShowCaseWidget.of(context)
    //       .startShowCase([_firstShowcaseKey, _two, _three]),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: mediaWidth(context) / 12,
        ),
        child: Column(
          spacing: mediaWidth(context) / 12,
          children: [
            Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaWidth(context) / 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CountdownTimer(),
                        GestureDetector(
                            onTap: () {
                              AppNavigator.push(context, PremiumPage());
                            },
                            child:
                                Image.asset("assets/icons/pricing/crown.png")),

                        const Text(
                          'Hi,',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          formatUsername(widget.state.user.firstName),
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: seedColor),
                        ),
                        const Text(
                          'Olia ?',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    StatsCard(stats: mockStats),
                  ],
                )),
            buildCarousel(funFacts),
            buildCategoriesGrid(categories),
          ],
        ),
      ),
    );
  }
}
