import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/bloc/button/button_state.dart';
import 'package:other_screens/common/bloc/button/button_state_cubit.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/loading_builder.dart';
import 'package:other_screens/common/widgets/dialogs/erro_dialog.dart';
import 'package:other_screens/data/auth/models/user_creation_req.dart';
import 'package:other_screens/data/models/onboarding/language_model.dart';
import 'package:other_screens/data/onboarding/language_repository.dart';
import 'package:other_screens/domain/auth/usecases/siginup.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';
import 'package:other_screens/presentation/onboarding/widgets/language_card.dart';
import 'package:other_screens/presentation/onboarding/widgets/next_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

Logger _log = Logger('LanguagePage.dart');

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key, required this.userCreationReq});

  final UserCreationReq userCreationReq;

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  Language? _selectedLanguage;
  bool isGoogleUser = false;

  @override
  void initState() {
    super.initState();
    _checkUserFlow();
  }

  Future<void> _checkUserFlow() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isGoogleUser = prefs.getBool('is_google_user') ?? false;
    });
  }

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
                          onPressed: () async {
                            if (_selectedLanguage == null) return;

                            if (isGoogleUser) {
                              // Update Firestore user document with selected language
                              try {
                                final firestore = FirebaseFirestore.instance;
                                final user = FirebaseAuth.instance.currentUser;

                                if (user != null) {
                                  
                                  await firestore
                                      .collection('users')
                                      .doc(user.uid)
                                      .update({
                                    'learningLanguage': _selectedLanguage?.name,
                                  });

                                  // Mark onboarding as completed
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool(
                                      'has_completed_onboarding', true);

                                  if (mounted) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  }
                                }
                              } catch (e) {
                                _log.severe('Error updating user language: $e');
                                if (mounted) {
                                  showErrorDialog(context, "Update Error",
                                      "Failed to update language preference");
                                }
                              }
                            } else {
                              // Normal signup flow
                              widget.userCreationReq.learningLanguage =
                                  _selectedLanguage?.name;
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
