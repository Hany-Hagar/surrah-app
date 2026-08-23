import '../../features/iconPicker/data/database/icons.dart';
import '../../features/iconPicker/data/models/icon_model.dart';

extension IconSearch on List<IconModel> {
  List<IconModel> search(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return this;
    }

    return where((appIcon) {
      final searchableText = [
        appIcon.id,
        ...appIcon.keywords,
      ].join(' ').toLowerCase();

      return searchableText.contains(normalizedQuery);
    }).toList();
  }
}


// Extensions to get icon models by id
extension IconById on  String{
  IconModel? getIconById() {
    try {
      return iconsData.firstWhere((icon) => icon.id == this);
    } catch (e) {
      return null;
    }
  }
}