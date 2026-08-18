import 'icon_picker_states.dart';
import 'package:flutter/material.dart';
import '../../data/database/icons.dart';
import '../../data/models/app_icon_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/app_icon_extensions.dart';

class IconPickerCubit extends Cubit<IconPickerStates> {
  IconPickerCubit() : super(IconPickerInitial());

  static IconPickerCubit get(BuildContext context) =>
      BlocProvider.of<IconPickerCubit>(context);

  AppIcon? selectedIcon;
  bool isSearching = false;
  List<AppIcon> icons = iconsData;
  List<AppIcon> searchedIcons = iconsData;
  final searchController = TextEditingController();

  void selectIcon(AppIcon icon) {
    selectedIcon = icon;
    emit(IconPickerSelectedState());
  }

  void searchIcon(String query) {
    isSearching = query.trim().isNotEmpty;
    searchedIcons = iconsData.search(query);
    emit(IconPickerSearchState());
  }

  void clearSelection() {
    selectedIcon = null;
    isSearching = false;
    searchController.clear();
    searchedIcons = iconsData;
    emit(IconPickerClearedState());
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
