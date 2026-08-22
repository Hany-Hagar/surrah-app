import 'package:get_it/get_it.dart';
import '../services/hive_service.dart';
import '../../features/layout/managers/layout_cubit.dart';
import '../../../features/settings/presentation/manager/settings_cubit.dart';

var getIt = GetIt.instance;

void setupLocator() {
  // Services
  getIt.registerLazySingleton<HiveService>(() => HiveService());

  // Settings
  getIt.registerLazySingleton<SettingsCubit>(() => SettingsCubit());

  // Layout
  getIt.registerLazySingleton<LayoutCubit>(() => LayoutCubit());
}
