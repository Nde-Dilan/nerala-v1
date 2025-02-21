import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/models/main/dictionary_model.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';
import 'package:pie_menu/pie_menu.dart';
import '../widgets/dictionary_card.dart';
import '../widgets/phrase_card.dart';

Logger _log = Logger("dictionary_page");

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PieCanvas(
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: scaffoldBgColor,
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              AppNavigator.pushReplacement(context, HomePage());
            },
          ),
          title: const Text(
            "My dictionary",
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            Image.asset("assets/icons/words/translation.png"),
            SizedBox(
              width: 5,
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  textAlign: TextAlign.center,
                  "Every word learned is a step towards fluency! 🌟",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              isScrollable: false,
              physics: const BouncingScrollPhysics(),
              indicatorSize: TabBarIndicatorSize.label,
              padding: EdgeInsets.symmetric(horizontal: 8),
              indicatorPadding: EdgeInsets.zero,
              labelColor: seedColorPalette.shade700,
              unselectedLabelColor: seedColorPalette.shade800,
              indicatorColor: seedColorPalette.shade400,
              overlayColor: WidgetStateProperty.all(seedColorPalette.shade50),
              labelStyle: AppTextStyles.h2,
              unselectedLabelStyle: AppTextStyles.h4,
              indicator: BoxDecoration(
                color: seedColorPalette.shade100,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                shape: BoxShape.rectangle,
              ),
              splashBorderRadius: BorderRadius.circular(99),
              tabs: const [
                Tab(text: 'Words'),
                Tab(text: 'Phrases'),
                Tab(text: 'History'),
              ],
            ),
            const SizedBox(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Words Tab
                  ListView.builder(
                    itemCount: DictionaryEntry.sampleEntries.length,
                    itemBuilder: (context, index) {
                      return DictionaryCard(
                        entry: DictionaryEntry.sampleEntries[index],
                      );
                    },
                  ),
                  // Phrases Tab
                  ListView.builder(
                    itemCount: DictionaryEntry.samplePhrases.length,
                    itemBuilder: (context, index) {
                      return PhraseCard(
                        entry: DictionaryEntry.samplePhrases[index],
                      );
                    },
                  ),
                  // History Tab
                  ListView.builder(
                    itemCount: DictionaryEntry.sampleEntries.length,
                    itemBuilder: (context, index) {
                      return DictionaryCard(
                        entry: DictionaryEntry.sampleEntries[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: PieMenu(
          theme: PieTheme(
            buttonTheme: PieButtonTheme(
              backgroundColor: seedColorPalette.shade100,
              iconColor: seedColorPalette.shade700,
            ),
            buttonThemeHovered: PieButtonTheme(
              backgroundColor: seedColor,
              iconColor: Colors.white,
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Long press for options',
                  style: TextStyle(color: seedColorPalette.shade700),
                ),
                backgroundColor: seedColorPalette.shade100,
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          actions: [
            PieAction(
              tooltip: const Text('Filter'),
              onSelect: () => _log.info('filter'),
              child: const Icon(Icons.filter_list),
            ),
            PieAction(
              tooltip: const Text('Revise All'),
              onSelect: () => _log.info('Revise All'),
              child: const Icon(HugeIcons.strokeRoundedAllBookmark),
            ),
          ],
          child: FloatingActionButton(
            backgroundColor: seedColor,
            child: Icon(HugeIcons.strokeRoundedMenu02),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
