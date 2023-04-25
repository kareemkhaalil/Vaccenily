// ignore_for_file: unused_local_variable

import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/bloc/auth/auth_cubit.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/bloc/icons/icons_cubit.dart';
import 'package:dashborad/bloc/tags/tags_cubit.dart';
import 'package:dashborad/data/local/constans/appColors.dart';
import 'package:dashborad/presentation/wedgits/auth/custom_auth_text_form.dart';
import 'package:dashborad/presentation/wedgits/glassmorphism_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FloatingGlass extends StatelessWidget {
  FloatingGlass({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => DashboardCubit(
        authCubit: context.read<AuthCubit>(),
        adminCubit: context.read<AdminCubit>(),
        iconsCubit: context.read<IconsCubit>(),
        tagsCubit: context.read<TagsCubit>(),
        articlesCubit: context.read<ArticlesCubit>(),
        uid: FirebaseAuth.instance.currentUser!.uid,
      ),
    );
    // ignore: dead_code
    DashboardDataLoaded state;

    builder:
    (context) {
      return BlocConsumer<DashboardCubit, DashboardState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = DashboardCubit.get(context);
            if (state is DashboardDataLoaded) {
              GlassmorphismContainer(
                  height: screenSize.height,
                  width: screenSize.width * 0.9,
                  child: Stack(
                    children: [
                      GlassmorphismContainer(
                        width: screenSize.width * 0.01,
                        height: screenSize.height * 0.03,
                        child: GestureDetector(
                            child: Icon(
                              Icons.close,
                              color: AppColors.backgroundColor,
                            ),
                            onTap: () {}
                            // cubit.addAdmins(
                            //   state.loggedInAdmin,
                            //   state.adminData,
                            //   state.tagsData,
                            //   state.iconsData,
                            //   state.articlesData,
                            // ),
                            ),
                      ),
                      Column(
                        children: [
                          Text(
                            'User Name',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.008,
                          ),
                          CustomAuthTextForm(
                            keyboardType: TextInputType.name,
                            preIcon: Icon(Icons.person_rounded),
                            width: screenSize.width * 0.35,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.008,
                          ),
                          Text(
                            'Email Address',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.008,
                          ),
                          CustomAuthTextForm(
                            keyboardType: TextInputType.emailAddress,
                            preIcon: Icon(Icons.email_rounded),
                            width: screenSize.width * 0.35,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.008,
                          ),
                          Text(
                            'Password',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.008,
                          ),
                          CustomAuthTextForm(
                            keyboardType: TextInputType.visiblePassword,
                            preIcon: Icon(Icons.lock_rounded),
                            width: screenSize.width * 0.35,
                          ),
                          SizedBox(
                            height: screenSize.height * 0.008,
                          ),
                          GlassmorphismContainer(
                            width: screenSize.width * 0.08,
                            height: screenSize.height * 0.06,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Upload Image',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.008,
                          ),
                          GlassmorphismContainer(
                            width: screenSize.width * 0.35,
                            height: screenSize.height * 0.08,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Add Admin',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.cairo().fontFamily,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
            }
          });
    };
  }
}
