import 'icon_picker_states.dart';
import 'package:flutter/material.dart';
import '../../data/database/icons.dart';
import '../../data/models/icon_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/icon_extensions.dart';

class IconPickerCubit extends Cubit<IconPickerStates> {
  IconPickerCubit() : super(IconPickerInitial());

  static IconPickerCubit get(BuildContext context) =>
      BlocProvider.of<IconPickerCubit>(context);

  IconModel? selectedIcon;
  bool isSearching = false;
  List<IconModel> icons = iconsData;
  Color selectedColor = Colors.blue;
  List<IconModel> searchedIcons = iconsData;
  final searchController = TextEditingController();

  void selectIcon(IconModel icon) {
    selectedIcon = icon;
    emit(IconPickerSelectedState());
  }

  void selectColor(Color color) {
    selectedColor = color;
    emit(IconPickerColorSelectedState());
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
