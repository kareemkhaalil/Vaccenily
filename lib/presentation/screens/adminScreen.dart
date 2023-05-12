
import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/data/remote/repo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dashborad/data/local/constans/appColors.dart';
import 'package:dashborad/data/local/constans/appImages.dart';
import 'package:dashborad/presentation/wedgits/auth/custom_auth_text_form.dart';
import 'package:dashborad/presentation/wedgits/custom_scaffold.dart';
import 'package:dashborad/presentation/wedgits/glassmorphism_container.dart';

class AdminScreen extends StatelessWidget {
  final dynamic state;
  final dynamic dCubit;

  AdminScreen({required this.state, required this.dCubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Repository? repo;

    return BlocProvider(
      create: (context) => AdminCubit(
        repo ?? Repository(),
      ),
      child: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, adminState) {},
        builder: (context, adminState) {
          final adminCubit = context.read<AdminCubit>();
          final cubit = context.read<DashboardCubit>();
          return adminCubit.addAdminLoadind == true
              ? GlassmorphismContainer(
                  height: screenSize.height * 0.97,
                  width: screenSize.width * 0.97,
                  child: Center(
                    child: Container(
                      color: Colors.transparent,
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.05,
                      child: const CircularProgressIndicator(
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    /// All Admins Button
                    AnimatedOpacity(
                      opacity: cubit.adminButtonOpacity!,
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// All Admins Button
                            GestureDetector(
                              onTap: () {
                                print('All Admins Button');
                                cubit.openAllAdmin(
                                  context,
                                  state.loggedInAdmin,
                                  state.adminData,
                                  state.tagsData,
                                  state.iconsData,
                                  state.articlesData,
                                );
                              },
                              child: AbsorbPointer(
                                child: GlassmorphismContainer(
                                  width: screenSize.width * 0.2,
                                  height: screenSize.height * 0.25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_rounded,
                                        size: screenSize.width * 0.07,
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.008,
                                      ),
                                      Text(
                                        'All Admins',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.cairo().fontFamily,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.backgroundColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.1,
                            ),

                            /// Add Admin Button
                            GestureDetector(
                              onTap: () {
                                cubit.addAdmin(
                                  context,
                                  state.loggedInAdmin,
                                  state.adminData,
                                  state.tagsData,
                                  state.iconsData,
                                  state.articlesData,
                                );
                              },
                              child: AbsorbPointer(
                                child: GlassmorphismContainer(
                                  width: screenSize.width * 0.2,
                                  height: screenSize.height * 0.25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: screenSize.width * 0.07,
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.008,
                                      ),
                                      Text(
                                        'Add Admins',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.cairo().fontFamily,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.backgroundColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        /// Explore Admins

                        AbsorbPointer(
                          absorbing: cubit.allAdminsOpacity == 0 ? true : false,
                          child: AnimatedOpacity(
                            opacity: cubit.allAdminsOpacity!,
                            duration: const Duration(milliseconds: 500),
                            child: Row(
                              children: [
                                GlassmorphismContainer(
                                  width: screenSize.width / 3,
                                  height: screenSize.height,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      25,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        state.loggedInAdmin.image == null
                                            ? CircleAvatar(
                                                radius: screenSize.width * 0.2,
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                child: const Icon(
                                                    Icons.person_rounded))
                                            : FutureBuilder<String>(
                                                future: cubit.loadImage(
                                                    state.loggedInAdmin.image),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String>
                                                        snapshot) {
                                                  return CircleAvatar(
                                                    radius:
                                                        screenSize.width * 0.05,
                                                    backgroundImage:
                                                        const NetworkImage(
                                                      AppImages.backGround,
                                                    ),
                                                    child: Center(
                                                      child: ClipOval(
                                                        child:
                                                            SizedBox.fromSize(
                                                          size: Size.fromRadius(
                                                            screenSize.width *
                                                                0.04,
                                                          ),
                                                          child: snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting
                                                              ? const CircularProgressIndicator()
                                                              : snapshot
                                                                      .hasError
                                                                  ? Text(
                                                                      snapshot
                                                                          .error
                                                                          .toString(),
                                                                    )
                                                                  : Image
                                                                      .network(
                                                                      state
                                                                          .loggedInAdmin
                                                                          .image,
                                                                      scale: 1,
                                                                    ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                        SizedBox(
                                          height: screenSize.height * 0.03,
                                        ),
                                        Text(
                                          state.loggedInAdmin.name,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontFamily:
                                                GoogleFonts.cairo().fontFamily,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.03,
                                        ),
                                        Text(
                                          state.loggedInAdmin.email,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontFamily:
                                                GoogleFonts.cairo().fontFamily,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GlassmorphismContainer(
                                              width: screenSize.width * 0.08,
                                              height: screenSize.height * 0.22,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    state.loggedInAdmin
                                                        .postsCount
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.03,
                                                  ),
                                                  Text(
                                                    'Articles',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .backgroundColor
                                                          .withOpacity(
                                                        0.7,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            GlassmorphismContainer(
                                              width: screenSize.width * 0.08,
                                              height: screenSize.height * 0.22,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    state.loggedInAdmin
                                                        .iconssCount
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.03,
                                                  ),
                                                  Text(
                                                    'Icons',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .backgroundColor
                                                          .withOpacity(
                                                        0.7,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            GlassmorphismContainer(
                                              width: screenSize.width * 0.08,
                                              height: screenSize.height * 0.22,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    state
                                                        .loggedInAdmin.tagsCount
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.03,
                                                  ),
                                                  Text(
                                                    'Tags',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .backgroundColor
                                                          .withOpacity(
                                                        0.7,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.008,
                                ),
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: screenSize.width * 1.8 / 3,
                                      height: screenSize.height,
                                      child: GridView.builder(
                                        itemCount: state.adminData.length,
                                        padding: const EdgeInsets.all(10),
                                        gridDelegate:
                                            // ignore: prefer_const_constructors
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 3 / 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemBuilder: (ctx, index) =>
                                            GlassmorphismContainer(
                                          width: screenSize.width * 0.006,
                                          height: screenSize.height * 0.22,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                FutureBuilder<String>(
                                                  future: cubit.loadImage(state
                                                      .loggedInAdmin.image),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<String>
                                                              snapshot) {
                                                    return CircleAvatar(
                                                      radius: screenSize.width *
                                                          0.03,
                                                      backgroundImage:
                                                          const NetworkImage(
                                                        AppImages.backGround,
                                                      ),
                                                      child: Center(
                                                        child: ClipOval(
                                                          child:
                                                              SizedBox.fromSize(
                                                            size:
                                                                Size.fromRadius(
                                                              screenSize.width *
                                                                  0.024,
                                                            ),
                                                            child: snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting
                                                                ? const CircularProgressIndicator()
                                                                : snapshot
                                                                        .hasError
                                                                    ? Text(
                                                                        snapshot
                                                                            .error
                                                                            .toString(),
                                                                      )
                                                                    : Image
                                                                        .network(
                                                                        state
                                                                            .adminData[index]
                                                                            .image,
                                                                        scale:
                                                                            1,
                                                                      ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Text(
                                                  state.adminData[index].name,
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    fontFamily:
                                                        GoogleFonts.cairo()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w800,
                                                    color: AppColors
                                                        .backgroundColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// Add Admin

                        AbsorbPointer(
                          absorbing: cubit.addAdminOpacity == 0 ? true : false,
                          child: AnimatedOpacity(
                            opacity: cubit.addAdminOpacity!,
                            duration: const Duration(milliseconds: 500),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  controller: adminCubit.nameController,
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
                                  controller: adminCubit.emailController,
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
                                  controller: adminCubit.passwordController,
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StreamBuilder<String?>(
                                      stream: adminCubit
                                          .imageUrlStreamController.stream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          // تظهر في حالة نجاح العملية
                                          return GlassmorphismContainer(
                                            width: screenSize.width * 0.2,
                                            height: screenSize.height * 0.25,
                                            child: Image.network(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.01,
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await adminCubit.pickImage();

                                          print("===================");
                                          print(state);
                                          print("===================");
                                        },
                                        child: Text(
                                          'Upload Image',
                                          textAlign: TextAlign.center,
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
                                    onPressed: () async {
                                      await adminCubit
                                          .onAddAdminButtonPressed();
                                      print("Add admin button pressed");
                                    },
                                    child: Text(
                                      'Add Admin',
                                      textAlign: TextAlign.center,
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
                      ],
                    ),
                    AnimatedOpacity(
                      opacity: cubit.adminButtonOpacity!,
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// All Admins Button
                            GestureDetector(
                              onTap: () {
                                print('All Admins Button');
                                cubit.openAllAdmin(
                                  context,
                                  state.loggedInAdmin,
                                  state.adminData,
                                  state.tagsData,
                                  state.iconsData,
                                  state.articlesData,
                                );
                              },
                              child: AbsorbPointer(
                                child: GlassmorphismContainer(
                                  width: screenSize.width * 0.2,
                                  height: screenSize.height * 0.35,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_rounded,
                                        size: screenSize.width * 0.07,
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.008,
                                      ),
                                      Text(
                                        'All Admins',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.cairo().fontFamily,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.backgroundColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.1,
                            ),

                            /// Add Admin Button
                            GestureDetector(
                              onTap: () {
                                cubit.addAdmin(
                                  context,
                                  state.loggedInAdmin,
                                  state.adminData,
                                  state.tagsData,
                                  state.iconsData,
                                  state.articlesData,
                                );
                              },
                              child: AbsorbPointer(
                                child: GlassmorphismContainer(
                                  width: screenSize.width * 0.2,
                                  height: screenSize.height * 0.35,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: screenSize.width * 0.07,
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.008,
                                      ),
                                      Text(
                                        'Add Admins',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.cairo().fontFamily,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.backgroundColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
