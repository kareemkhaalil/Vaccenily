part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class OpenAddAdmin extends DashboardState {}

class OpenAllAddAdmin extends DashboardState {}

class OpenAdminButtonState extends DashboardState {}

class CloseAddAdmin extends DashboardState {}

class CloseAllAddAdmin extends DashboardState {}

class CloseAdminButtonState extends DashboardState {}

class DashboardDataLoaded extends DashboardState {
  final List<AdminModel> adminData;
  final List<IconsModel> iconsData;
  final List<TagsModel> tagsData;
  final List<ArticlesModel> articlesData;
  final AdminModel loggedInAdmin;

  const DashboardDataLoaded({
    required this.loggedInAdmin,
    required this.adminData,
    required this.iconsData,
    required this.tagsData,
    required this.articlesData,
  });

  @override
  List<Object> get props =>
      [adminData, iconsData, tagsData, articlesData, loggedInAdmin];
}

class DashboardInitial extends DashboardState {}

class AppThemeModeLight extends DashboardState {}

class AppThemeModeDark extends DashboardState {}

class OpenSideBar extends DashboardState {
  final List<AdminModel> adminData;
  final List<IconsModel> iconsData;
  final List<TagsModel> tagsData;
  final List<ArticlesModel> articlesData;
  final AdminModel loggedInAdmin;

  const OpenSideBar({
    required this.loggedInAdmin,
    required this.adminData,
    required this.iconsData,
    required this.tagsData,
    required this.articlesData,
  });
  List<Object> get props =>
      [adminData, iconsData, tagsData, articlesData, loggedInAdmin];
}

class CloseSideBar extends DashboardState {}

class ChangePageState extends DashboardState {}

class NextPageState extends DashboardState {}

class PreviousPageState extends DashboardState {}

class OpenAdminState extends DashboardState {
  final List<AdminModel> adminData;
  final List<IconsModel> iconsData;
  final List<TagsModel> tagsData;
  final List<ArticlesModel> articlesData;
  final AdminModel loggedInAdmin;

  const OpenAdminState({
    required this.loggedInAdmin,
    required this.adminData,
    required this.iconsData,
    required this.tagsData,
    required this.articlesData,
  });
  List<Object> get props =>
      [adminData, iconsData, tagsData, articlesData, loggedInAdmin];
}

class OpenArticlesState extends DashboardState {
  final List<AdminModel> adminData;
  final List<IconsModel> iconsData;
  final List<TagsModel> tagsData;
  final List<ArticlesModel> articlesData;
  final AdminModel loggedInAdmin;

  const OpenArticlesState({
    required this.loggedInAdmin,
    required this.adminData,
    required this.iconsData,
    required this.tagsData,
    required this.articlesData,
  });
  List<Object> get props =>
      [adminData, iconsData, tagsData, articlesData, loggedInAdmin];
}

class OpenTagsState extends DashboardState {
  final List<AdminModel> adminData;
  final List<IconsModel> iconsData;
  final List<TagsModel> tagsData;
  final List<ArticlesModel> articlesData;
  final AdminModel loggedInAdmin;

  const OpenTagsState({
    required this.loggedInAdmin,
    required this.adminData,
    required this.iconsData,
    required this.tagsData,
    required this.articlesData,
  });
  List<Object> get props =>
      [adminData, iconsData, tagsData, articlesData, loggedInAdmin];
}

class OpenIconsState extends DashboardState {
  final List<AdminModel> adminData;
  final List<IconsModel> iconsData;
  final List<TagsModel> tagsData;
  final List<ArticlesModel> articlesData;
  final AdminModel loggedInAdmin;

  const OpenIconsState({
    required this.loggedInAdmin,
    required this.adminData,
    required this.iconsData,
    required this.tagsData,
    required this.articlesData,
  });
  List<Object> get props =>
      [adminData, iconsData, tagsData, articlesData, loggedInAdmin];
}

class OpenDashboardState extends DashboardState {
  final List<AdminModel> adminData;
  final List<IconsModel> iconsData;
  final List<TagsModel> tagsData;
  final List<ArticlesModel> articlesData;
  final AdminModel loggedInAdmin;

  const OpenDashboardState({
    required this.loggedInAdmin,
    required this.adminData,
    required this.iconsData,
    required this.tagsData,
    required this.articlesData,
  });
  List<Object> get props =>
      [adminData, iconsData, tagsData, articlesData, loggedInAdmin];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {}

class DashboardErrorState extends DashboardState {
  final String error;

  const DashboardErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
