import 'package:get_it/get_it.dart';
import '../services/hive_service.dart';
import '../services/pdf_service.dart';
import '../services/update_service.dart';
import '../services/local_auth_service.dart';
import '../../features/layout/managers/layout_cubit.dart';
import '../../features/splash/data/repo/splash_repo.dart';
import '../../features/report/data/repo/report_repo.dart';
import '../../features/splash/data/database/splash_data.dart';
import '../../features/report/data/database/report_data.dart';
import '../../features/report/data/repo/report_impl_repo.dart';
import '../../features/splash/data/repo/splash_repo_impl.dart';
import '../../features/categories/data/repo/categories_repo.dart';
import '../../features/report/presentation/manager/report_cubit.dart';
import '../../features/transactions/data/repo/transactions_repo.dart';
import '../../features/categories/data/database/categories_data.dart';
import '../../features/splash/presentations/manger/splash_cubit.dart';
import '../../features/categories/data/repo/categories_repo_impl.dart';
import '../../features/transactions/data/database/transactions_data.dart';
import '../../features/transactions/data/repo/transactions_repo_impl.dart';
import '../../../features/settings/presentation/manager/settings_cubit.dart';
import '../../features/categories/presentation/manager/categories_cubit.dart';
import '../../features/transactions/presentation/manager/transactions_cubit.dart';

var getIt = GetIt.instance;

void setupLocator() {
  // Services
  getIt.registerLazySingleton<LocalAuthService>(() => LocalAuthService());

  getIt.registerLazySingleton<UpdateService>(() => UpdateService());

  getIt.registerLazySingleton<HiveService>(() => HiveService());

  getIt.registerLazySingleton<PdfService>(() => PdfService());

  // Settings
  getIt.registerLazySingleton<SettingsCubit>(() => SettingsCubit());

  // Splash
  getIt.registerFactory<SplashData>(
    () => SplashData(
      updateService: getIt<UpdateService>(),
      localAuth: getIt<LocalAuthService>(),
    ),
  );

  getIt.registerFactory<SplashRepo>(
    () => SplashRepoImpl(splashData: getIt<SplashData>()),
  );

  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(splashRepo: getIt<SplashRepo>()),
  );

  // Layout
  getIt.registerLazySingleton<LayoutCubit>(() => LayoutCubit());

  // Categories
  getIt.registerLazySingleton<CategoriesData>(
    () => CategoriesData(hiveService: getIt<HiveService>()),
  );

  getIt.registerLazySingleton<CategoriesRepo>(
    () => CategoriesRepoImpl(categoriesData: getIt<CategoriesData>()),
  );

  getIt.registerLazySingleton<CategoriesCubit>(
    () =>
        CategoriesCubit(categoriesRepo: getIt<CategoriesRepo>())
          ..getCategories(),
  );

  // Transactions
  getIt.registerLazySingleton<TransactionsData>(
    () => TransactionsData(hiveService: getIt<HiveService>()),
  );

  getIt.registerLazySingleton<TransactionsRepo>(
    () => TransactionsRepoImpl(transactionsData: getIt<TransactionsData>()),
  );

  getIt.registerLazySingleton<TransactionsCubit>(
    () => TransactionsCubit(transactionsRepo: getIt<TransactionsRepo>()),
  );
  // Report
  getIt.registerLazySingleton<ReportData>(
    () => ReportData(
      pdfService: getIt<PdfService>(),
      hiveService: getIt<HiveService>(),
    ),
  );

  getIt.registerLazySingleton<ReportRepo>(
    () => ReportRepoImpl(reportData: getIt<ReportData>()),
  );

  getIt.registerLazySingleton<ReportCubit>(
    () => ReportCubit(reportRepo: getIt<ReportRepo>()),
  );
}

