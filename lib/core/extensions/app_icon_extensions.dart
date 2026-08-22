import '../../features/iconPicker/data/models/icon_model.dart';

extension AppIconSearch on List<IconModel> {
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
