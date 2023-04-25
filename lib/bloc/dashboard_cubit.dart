import 'dart:async';
import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/bloc/auth/auth_cubit.dart';
import 'package:dashborad/bloc/icons/icons_cubit.dart';
import 'package:dashborad/bloc/tags/tags_cubit.dart';
import 'package:dashborad/data/remote/fireAuth.dart';
import 'package:dashborad/presentation/screens/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/data/local/constans/constans.dart';
import 'package:dashborad/data/models/adminModel.dart';
import 'package:dashborad/data/models/articlesModel.dart';
import 'package:dashborad/data/models/iconsModel.dart';
import 'package:dashborad/data/models/tagsModel.dart';
import 'package:file/file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required this.authCubit,
    required this.adminCubit,
    required this.iconsCubit,
    required this.tagsCubit,
    required this.articlesCubit,
    required this.uid,
  }) : super(DashboardInitial());

  static DashboardCubit get(context) => BlocProvider.of(context);

  final AdminCubit adminCubit;
  final IconsCubit iconsCubit;
  final TagsCubit tagsCubit;
  final ArticlesCubit articlesCubit;
  final AuthCubit authCubit;
  String uid;
  StreamController<AdminModel> adminModelController =
      StreamController<AdminModel>.broadcast();
  var sliderSmall = 0.05;
  double xOffset = 60;
  double yOffset = 0;
  double scalX = 0.00052;
  bool sidebarOpen = false;
  double? adminOpacity = 0;
  double? tagsOpacity = 0;
  double? articlesOpacity = 0;
  double? iconsOpacity = 0;
  double? dashboardOpacity = 1;
  double? addAdminOpacity = 0;
  double? allAdminsOpacity = 0;
  double? adminButtonOpacity = 0;
  AdminModel? adminModel;
  TagsModel? tagsModel;
  IconsModel? iconsModel;
  ArticlesModel? articleModel;
  TextFormField? addAdminEmail;
  TextFormField? addAdminUserNamel;
  TextFormField? addAdminPass;
  bool isDark = false;

  final CarouselController buttonCarouselController = CarouselController();

  PageController? pageController;
  Future<void> fetchData() async {
    try {
      final adminData = await adminCubit.getUser();
      final allAdminsData = await adminCubit.getAllUsers();

      await Future.wait([
        iconsCubit.getIconsData(),
        tagsCubit.getAllTagsData(),
        articlesCubit.getAllArticles(),
      ]);

      final iconsState = iconsCubit.state;
      final tagsState = tagsCubit.state;
      final articlesState = articlesCubit.state;

      if (adminCubit.state is AdminsLoaded &&
          iconsState is IconsLoaded &&
          tagsState is TagsLoaded &&
          articlesState is ArticlesLoaded) {
        if (!this.isClosed) {
          emit(DashboardDataLoaded(
            loggedInAdmin: adminData,
            adminData: allAdminsData,
            iconsData: iconsState.iconsData,
            tagsData: tagsState.tagsData,
            articlesData: articlesState.articles,
          ));
        }
      } else {
        _handleError(adminCubit.state, iconsState, tagsState, articlesState);
      }
    } on FirebaseException catch (e) {
      emit(DashboardErrorState(error: e.message!));
    }
  }

  void _handleError(AdminState adminsState, IconsState iconsState,
      TagsState tagsState, ArticlesState articlesState) {
    print('Error in data:');
    print('adminsState: $adminsState');
    print('iconsState: $iconsState');
    print('tagsState: $tagsState');
    print('articlesState: $articlesState');
    emit(DashboardErrorState(error: 'Failed to load data.'));
  }

  Future<String> loadImage(String imageUrl) async {
    await Future.delayed(Duration(milliseconds: 200));
    return imageUrl;
  }

  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  int activePageIndex = 0;

  void slideBar(
      context,
      AdminModel loggedInAdmin,
      List<AdminModel> adminData,
      List<TagsModel> tagsData,
      List<IconsModel> iconsData,
      List<ArticlesModel> articlesData) {
    if (sliderSmall == 0.05 || scalX == 0.00052) {
      sliderSmall = 0.13;
      scalX = 0.000483;
      emit(OpenSideBar(
          loggedInAdmin: loggedInAdmin,
          adminData: adminData,
          iconsData: iconsData,
          tagsData: tagsData,
          articlesData: articlesData));
      emit(DashboardDataLoaded(
          loggedInAdmin: loggedInAdmin,
          adminData: adminData,
          iconsData: iconsData,
          tagsData: tagsData,
          articlesData: articlesData));

      print('slider is open');
    } else {
      sliderSmall = 0.05;
      scalX = 0.00052;
      emit(CloseSideBar());
      emit(DashboardDataLoaded(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData,
      ));
      emit(DashboardDataLoaded(
          loggedInAdmin: loggedInAdmin,
          adminData: adminData,
          iconsData: iconsData,
          tagsData: tagsData,
          articlesData: articlesData));
      print('slider is close');
    }
  }

  void changeAppMode() {
    isDark = !isDark;
    if (isDark) {
      emit(AppThemeModeDark());
    } else {
      emit(AppThemeModeLight());
    }
  }

  init() {
    xOffset = 60;
    yOffset = 0;
    sidebarOpen = false;
    dashboardOpacity = 1;
    adminOpacity = 0;
    tagsOpacity = 0;
    articlesOpacity = 0;
    iconsOpacity = 0;
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
    super.emit(DashboardInitial());
  }

  void nextCaro() {
    buttonCarouselController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    emit(NextPageState());
  }

  void prevCaro() {
    try {
      buttonCarouselController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      emit(PreviousPageState());
    } on Exception catch (e) {
      emit(PreviousPageState());
      print(e.toString());
    }
  }

  void changePage(int index) {
    if (index != null) {
      buttonCarouselController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      print('Error: index passed to changePage is null');
    }
  }

  void openAdmin(
      context,
      AdminModel loggedInAdmin,
      List<AdminModel> adminData,
      List<TagsModel> tagsData,
      List<IconsModel> iconsData,
      List<ArticlesModel> articlesData) {
    adminOpacity = 1;
    adminButtonOpacity = 1;
    tagsOpacity = 0;
    articlesOpacity = 0;
    iconsOpacity = 0;
    dashboardOpacity = 0;
    addAdminOpacity = 0;
    allAdminsOpacity = 0;
    print(Constants().adminUID.toString());
    emit(OpenAdminState(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
    emit(DashboardDataLoaded(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
  }

  void openTags(
      context,
      AdminModel loggedInAdmin,
      List<AdminModel> adminData,
      List<TagsModel> tagsData,
      List<IconsModel> iconsData,
      List<ArticlesModel> articlesData) {
    adminOpacity = 0;
    tagsOpacity = 1;
    adminButtonOpacity = 0;
    articlesOpacity = 0;
    iconsOpacity = 0;
    dashboardOpacity = 0;
    emit(OpenTagsState(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
    emit(DashboardDataLoaded(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
  }

  void openArticles(
      context,
      AdminModel loggedInAdmin,
      List<AdminModel> adminData,
      List<TagsModel> tagsData,
      List<IconsModel> iconsData,
      List<ArticlesModel> articlesData) {
    adminOpacity = 0;
    tagsOpacity = 0;
    articlesOpacity = 1;
    adminButtonOpacity = 0;
    iconsOpacity = 0;
    dashboardOpacity = 0;
    emit(OpenArticlesState(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
    emit(DashboardDataLoaded(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
  }

  void openIcons(
      context,
      AdminModel loggedInAdmin,
      List<AdminModel> adminData,
      List<TagsModel> tagsData,
      List<IconsModel> iconsData,
      List<ArticlesModel> articlesData) {
    adminOpacity = 0;
    tagsOpacity = 0;
    articlesOpacity = 0;
    adminButtonOpacity = 0;
    iconsOpacity = 1;
    dashboardOpacity = 0;
    emit(OpenIconsState(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
    emit(DashboardDataLoaded(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
  }

  void openDashboard(
      context,
      AdminModel loggedInAdmin,
      List<AdminModel> adminData,
      List<TagsModel> tagsData,
      List<IconsModel> iconsData,
      List<ArticlesModel> articlesData) {
    adminOpacity = 0;
    tagsOpacity = 0;
    articlesOpacity = 0;
    iconsOpacity = 0;
    dashboardOpacity = 1;
    adminButtonOpacity = 0;
    emit(OpenDashboardState(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
    emit(DashboardDataLoaded(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
  }

  void openAllAdmin(
      context,
      AdminModel loggedInAdmin,
      List<AdminModel> adminData,
      List<TagsModel> tagsData,
      List<IconsModel> iconsData,
      List<ArticlesModel> articlesData) {
    addAdminOpacity = 0;
    adminButtonOpacity = 0;
    allAdminsOpacity = 1;

    print(allAdminsOpacity.toString());
    print("All Admin Screen ");
    emit(OpenAllAddAdmin());
    emit(DashboardDataLoaded(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
    print(state.toString());
  }

  void addAdmin(
      context,
      AdminModel loggedInAdmin,
      List<AdminModel> adminData,
      List<TagsModel> tagsData,
      List<IconsModel> iconsData,
      List<ArticlesModel> articlesData) {
    allAdminsOpacity = 0;
    adminButtonOpacity = 0;
    addAdminOpacity = 1;

    print(addAdminOpacity.toString());
    print("Add Admin Screen ");

    emit(OpenAddAdmin());
    emit(DashboardDataLoaded(
        loggedInAdmin: loggedInAdmin,
        adminData: adminData,
        iconsData: iconsData,
        tagsData: tagsData,
        articlesData: articlesData));
    print(state.toString());
  }
}
