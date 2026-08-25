import 'generated/l10n.dart';
import 'core/utils/theme.dart';
import 'core/di/server_locator.dart';
import 'package:flutter/material.dart';
import 'core/services/hive_service.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/services/snack_bar_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'features/layout/managers/layout_cubit.dart';
import 'features/splash/pages/views/splash_view.dart';
import 'features/settings/model/app_user_pref_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/settings/presentation/manager/settings_cubit.dart';
import 'features/categories/presentation/manager/categories_cubit.dart';
import 'features/categories/presentation/manager/categories_states.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  setupLocator();
  await getIt<HiveService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LayoutCubit>()),
        BlocProvider(create: (context) => getIt<SettingsCubit>()),
        BlocProvider(create: (context) => getIt<CategoriesCubit>()),
      ],
      child: BlocListener<CategoriesCubit, CategoriesStates>(
        listener: (context, state) {
          final appContext = rootNavigatorKey.currentState?.context;
          if (state is AddCategorySuccess) {
            rootNavigatorKey.currentState?.pop();
            getIt<CategoriesCubit>().resetAddCategoryData();
            if (appContext != null) {
              SnackBarService.success(
                context: appContext,
                message: S.of(appContext).addNewCategorySuccess,
              );
            }
          }
          if (state is UpdateCategorySuccess) {
            rootNavigatorKey.currentState?.pop();
            getIt<CategoriesCubit>().resetAddCategoryData();
            if (appContext != null) {
              SnackBarService.success(
                context: appContext,
                message: S.of(appContext).updateCategorySuccess,
              );
            }
          }
          if (state is UpdateCategoriesFailure) {
            if (appContext != null) {
              SnackBarService.failure(
                context: appContext,
                message: state.errorMessage,
              );
            }
          }
        },
        child: BlocBuilder<SettingsCubit, AppUserPref>(
          builder: (context, state) => ScreenUtilInit(
            designSize: const Size(390, 884),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: "Surrah صُرَة",
                theme: AppTheme.light,
                themeMode: state.theme,
                darkTheme: AppTheme.dark,
                locale: Locale(state.lang),
                debugShowCheckedModeBanner: false,
                navigatorKey: rootNavigatorKey,
                localizationsDelegates: [
                  S.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                home: const SplashView(),
              );
            },
          ),
        ),
      ),
    );
  }
}
