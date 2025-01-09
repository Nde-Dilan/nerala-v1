import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/bloc/button/button_state.dart';
import 'package:other_screens/common/bloc/button/button_state_cubit.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/loading_builder.dart';
import 'package:other_screens/common/widgets/dialogs/erro_dialog.dart';
import 'package:other_screens/data/auth/models/user_creation_req.dart';
import 'package:other_screens/domain/auth/usecases/siginup.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';

Logger _log = Logger('LanguagePage.dart');

// Data model for language
class Language {
  final String name;
  final String region;
  final String flagEmoji;
  final String description;

  const Language({
    required this.name,
    required this.region,
    required this.description,
    this.flagEmoji = '🌍', // Default flag emoji
  });
}

// Repository of languages
class LanguageRepository {
  static const List<Language> languages = [
    Language(
      name: 'Ghomala',
      region: 'West Region',
      flagEmoji: '🇨🇲',
      description:
          'Ghomala is a Grassfields Bantu language spoken in the West Region of Cameroon. It is primarily used by the Bamileke people and has around 350,000 speakers.',
    ),
    Language(
      name: 'Ewondo',
      region: 'Centre Region',
      flagEmoji: '🇨🇲',
      description:
          'Ewondo is a Bantu language spoken in the Centre Region of Cameroon. It is the native language of the Ewondo people and is one of the official languages of Cameroon.',
    ),
    Language(
      name: 'Bulu',
      region: 'South Region',
      flagEmoji: '🇨🇲',
      description:
          'Bulu is a Bantu language spoken in the South Region of Cameroon. It is the native language of the Bulu people and is one of the official languages of Cameroon.',
    ),
    Language(
      name: 'Duala',
      region: 'Littoral Region',
      flagEmoji: '🇨🇲',
      description:
          'Duala is a Bantu language spoken in the Littoral Region of Cameroon. It is the native language of the Duala people and is one of the official languages of Cameroon.',
    ),
    Language(
      name: 'Fulfulde',
      region: 'Adamawa, North, and Far North Regions',
      flagEmoji: '🇨🇲',
      description:
          'Fulfulde is a Niger-Congo language spoken in several countries, including Cameroon. It is the native language of the Fulbe people and is one of the official languages of Cameroon.',
    ),
    Language(
      name: 'Bamiléké',
      region: 'West Region',
      flagEmoji: '🇨🇲',
      description:
          'Bamiléké is a collective term for several closely related Bantu languages spoken in the West Region of Cameroon. It is the native language of the Bamiléké people.',
    ),
    Language(
      name: 'Fang',
      region: 'South Region',
      flagEmoji: '🇨🇲',
      description:
          'Fang is a Bantu language spoken in several countries, including Cameroon. It is the native language of the Fang people.',
    ),
    Language(
      name: 'Mbum',
      region: 'Adamawa Region',
      flagEmoji: '🇨🇲',
      description:
          'Mbum is a Bantu language spoken in the Adamawa Region of Cameroon. It is the native language of the Mbum people.',
    ),
    Language(
      name: 'Ngemba',
      region: 'North-West Region',
      flagEmoji: '🇨🇲',
      description:
          'Ngemba is a Grassfields Bantu language spoken in the North-West Region of Cameroon. It is the native language of the Ngemba people.',
    ),
    Language(
      name: 'Tikar',
      region: 'North Region',
      flagEmoji: '🇨🇲',
      description:
          'Tikar is a Bantu language spoken in the North Region of Cameroon. It is the native language of the Tikar people.',
    ),
  ];
}

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key, required this.userCreationReq});

  final UserCreationReq userCreationReq;

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  Language? _selectedLanguage;

  void _selectLanguage(Language language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  void _showLanguageInfo(BuildContext context, Language language) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(language.name),
          content: Text(language.description),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtonStateCubit(),
      child: BlocConsumer<ButtonStateCubit, ButtonState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(children: [
            if (state is ButtonLoadingState)
              Container(
                color: Colors.black.withAlpha(128),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Center(
                    child: DefaultLoadingBuilder(),
                  ),
                ),
              ),
            Scaffold(
              backgroundColor: scaffoldBgColor,
              appBar: AppBar(
                backgroundColor: scaffoldBgColor,
                centerTitle: true,
                leading: const BackButton(),
                title: const Text(
                  'Your Language',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      'What language would you like to learn?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: LanguageRepository.languages.length,
                      itemBuilder: (context, index) {
                        final language = LanguageRepository.languages[index];
                        return LanguageCard(
                          language: language,
                          isSelected: language == _selectedLanguage,
                          onSelect: () => _selectLanguage(language),
                          onInfoTap: () => _showLanguageInfo(context, language),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Builder(builder: (context) {
                      return BlocListener<ButtonStateCubit, ButtonState>(
                        listener: (context, state) {
                          if (state is ButtonLoadingState) {
                            DefaultLoadingBuilder();
                          } else if (state is ButtonFailureState) {
                            showErrorDialog(
                                context, "Sign Up Error", state.errorMessage);
                          } else if (state is ButtonSuccessState) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                        },
                        child: NextButton(
                          isEnabled: _selectedLanguage != null,
                          onPressed: () {
                            if (_selectedLanguage != null) {
                              // Handle navigation to next screen
                              _log.info("Selected : $_selectedLanguage");

                              widget.userCreationReq.learningLanguage =
                                  _selectedLanguage?.name;

                              _log.info(
                                  "Creating a user with mail : ${widget.userCreationReq.email}");
                              context.read<ButtonStateCubit>().execute(
                                  usecase: SignupUseCase(),
                                  params: widget.userCreationReq);
                            }
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  final Language language;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onInfoTap;

  const LanguageCard({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onSelect,
    required this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
          color:
              isSelected ? Colors.black.withValues(alpha: 0.05) : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  language.flagEmoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      language.region,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onInfoTap,
                icon: const CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.question_mark,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;

  const NextButton({
    super.key,
    required this.isEnabled,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        //disabledBackgroundColor: Colors.grey,
      ),
      child: const Text(
        'NEXT',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
