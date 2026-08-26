import 'package:get_it/get_it.dart';
import '../services/hive_service.dart';
import '../../features/layout/managers/layout_cubit.dart';
import '../../features/categories/data/repo/categories_repo.dart';
import '../../features/transactions/data/repo/transactions_repo.dart';
import '../../features/categories/data/database/categories_data.dart';
import '../../features/categories/data/repo/categories_repo_impl.dart';
import '../../features/transactions/data/database/transactions_data.dart';
import '../../features/transactions/data/repo/transactions_repo_impl.dart';
import '../../../features/settings/presentation/manager/settings_cubit.dart';
import '../../features/categories/presentation/manager/categories_cubit.dart';

var getIt = GetIt.instance;

void setupLocator() {
  // Services
  getIt.registerLazySingleton<HiveService>(() => HiveService());

  // Settings
  getIt.registerLazySingleton<SettingsCubit>(() => SettingsCubit());

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
    () => CategoriesCubit(categoriesRepo: getIt<CategoriesRepo>())..getCategories(),
  );

  // Transactions
  getIt.registerLazySingleton<TransactionsData>(
    () => TransactionsData(hiveService: getIt<HiveService>()),
  );

  getIt.registerLazySingleton<TransactionsRepo>(
    () => TransactionsRepoImpl(transactionsData: getIt<TransactionsData>()),
  );
}
