import 'dart:ui';
import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/auth/auth_cubit.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/data/local/constans/appColors.dart';
import 'package:dashborad/data/local/constans/appImages.dart';
import 'package:dashborad/data/remote/fireAuth.dart';
import 'package:dashborad/data/remote/repo.dart';
import 'package:dashborad/presentation/wedgits/auth/custom_auth_text_form.dart';
import 'package:dashborad/presentation/wedgits/custom_scaffold.dart';
import 'package:dashborad/presentation/wedgits/glassmorphism_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Repository();

    var screenSize = MediaQuery.of(context).size;
    final Auth auth = Auth();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminCubit>(
          create: (context) => AdminCubit(repository),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(auth, context.read<AdminCubit>()),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<AuthCubit>();
          return CustomScaffold(
            child: Center(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: screenSize.height * 0.1,
                    left: screenSize.width * 0.2,
                    child: GlassmorphismContainer(
                      width: screenSize.width * 0.1,
                      height: screenSize.height * 0.2,
                    ),
                  ),
                  Positioned(
                    top: screenSize.height * 0.1,
                    right: screenSize.width * 0.2,
                    child: GlassmorphismContainer(
                      width: screenSize.width * 0.15,
                      height: screenSize.height * 0.25,
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        GlassmorphismContainer(
                          width: screenSize.width * 0.5,
                          height: screenSize.height * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Welcome',
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.cairo().fontFamily,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.backgroundColor,
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.05),
                                  //email
                                  CustomAuthTextForm(
                                    controller: cubit.emailController,
                                  ),
                                  SizedBox(height: screenSize.height * 0.05),
                                  //password
                                  CustomAuthTextForm(
                                    controller: cubit.passwordController,
                                  ),
                                  SizedBox(height: screenSize.height * 0.05),
                                  //sign in button
                                  GlassmorphismContainer(
                                    width: screenSize.width * 0.2,
                                    height: screenSize.height * 0.1,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        cubit.signIn(
                                          cubit.emailController.text,
                                          cubit.passwordController.text,
                                          context,
                                        );
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.cairo().fontFamily,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.backgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: screenSize.height * 0.15,
                          left: screenSize.width * 0.03,
                          child: GlassmorphismContainer(
                            width: screenSize.width * 0.08,
                            height: screenSize.height * 0.1,
                            child: Center(
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color:
                                      AppColors.backgroundColor.withAlpha(200),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: screenSize.height * 0.36,
                          left: screenSize.width * 0.03,
                          child: GlassmorphismContainer(
                            width: screenSize.width * 0.1,
                            height: screenSize.height * 0.1,
                            child: Center(
                              child: Text(
                                'Password',
                                style: TextStyle(
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color:
                                      AppColors.backgroundColor.withAlpha(200),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: screenSize.height * 0.7,
                    left: screenSize.width * 0.2,
                    child: GlassmorphismContainer(
                      width: screenSize.width * 0.13,
                      height: screenSize.height * 0.23,
                    ),
                  ),
                  Positioned(
                    top: screenSize.height * 0.7,
                    right: screenSize.width * 0.2,
                    child: GlassmorphismContainer(
                      width: screenSize.width * 0.08,
                      height: screenSize.height * 0.18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
