import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:other_screens/common/bloc/button/button_state_cubit.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/widgets/custom_button.dart';
import 'package:other_screens/common/widgets/forms/password_text_formfield.dart';
import 'package:other_screens/common/widgets/forms/simple_text_formfield.dart';
import 'package:other_screens/data/auth/models/user_signin_req.dart';
import 'package:other_screens/domain/auth/usecases/signin.dart';
import 'package:other_screens/presentation/auth/pages/register_page.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // Forms fields
  String? email;

  String? password;

  // Form validation
  bool isEmailFilled = false;

  bool doRememberYou = false;

  bool isPasswordFilled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        isEmailFilled = _emailController.text.isNotEmpty;
      });
    });

    _passwordController.addListener(() {
      setState(() {
        isPasswordFilled = _passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var allPadding = EdgeInsets.all(15);
    return BlocProvider(
      create: (context) => ButtonStateCubit(),
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: scaffoldBgColor,
          title: Text("Sign In"),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Image.asset(
                "assets/images/login-woman.png",
                width: 155,
                height: 151,
              ),

              const SizedBox(
                height: 15,
              ),
              //form

              Form(
                key: _loginFormKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: allPadding * 1.25,
                  children: [
                    SimpleTextFormField(
                      controller: _emailController,
                      hintText: "Email address",
                      prefixIcon: Image.asset("assets/icons/email.png"),
                      onChanged: (value) => email = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email address is required";
                        }

                        if (!RegExp(emailRegex).hasMatch(value)) {
                          return 'Enter a valid email address';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    PasswordTextFormField(
                      controller: _passwordController,
                      hintText: "Password",
                      prefixIcon: Icon(HugeIcons.strokeRoundedLockPassword),
                      onChanged: (value) => password = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              //remember me text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: doRememberYou,
                      onChanged: (value) {
                        setState(() {
                          doRememberYou = !doRememberYou;
                        });
                      }),
                  Text("Remember me")
                ],
              ),
              //button

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Builder(builder: (context) {
                  return CustomButton(
                    onPressed:
                        // Call login hero
                        (isEmailFilled && isPasswordFilled)
                            ? () {
                                if (_loginFormKey.currentState!.validate()) {
                                  // Save and proceed
                                  UserSigninReq signinReq =
                                      UserSigninReq(email: email);

                                  signinReq.password = _passwordController.text;
                                  context.read<ButtonStateCubit>().execute(
                                      usecase: SigninUseCase(),
                                      params: signinReq);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }
                              }
                            : null,
                    text: 'LOG IN',
                  );
                }),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ));
                },
                child: Text(
                  "No Account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Or Continue With",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset("assets/icons/facebook.png"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset("assets/icons/google.png"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
