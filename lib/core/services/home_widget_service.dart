import 'package:home_widget/home_widget.dart';
import '../../features/home_widget/data/model/home_widget_model.dart'; 

class HomeWidgetService {
  static const _androidName = 'SurrahWidgetProvider';

  static String _format(double v) =>
      v.toStringAsFixed(2); 
  static Future<void> updateBalance(
    double balance, {
    String Function(double)? formatBalance,
  }) async {
    final visible =
        await HomeWidget.getWidgetData<bool>(
          'show_balance',
          defaultValue: false,
        ) ??
        false;

    await HomeWidget.saveWidgetData<String>(
      'balance',
      visible ? (formatBalance ?? _format)(balance) : '',
    );
    await HomeWidget.updateWidget(androidName: _androidName);
  }

  static Future<void> updateSettings(
    HomeWidgetModel m, {
    String Function(double)? formatBalance,
  }) async {
    final visible = m.enableCard && m.showBalance;
    await HomeWidget.saveWidgetData<bool>('widget_enabled', m.enableCard);
    await HomeWidget.saveWidgetData<bool>('show_balance', visible);
    await HomeWidget.saveWidgetData<String>(
      'balance',
      visible ? (formatBalance ?? _format)(m.balance) : '********',
    );
    await HomeWidget.saveWidgetData<bool>('show_income', m.showIncomeButton);
    await HomeWidget.saveWidgetData<bool>('show_expense', m.showExpenseButton);
    await HomeWidget.saveWidgetData<bool>(
      'show_category',
      m.showAddCategoryButton,
    );
    await HomeWidget.updateWidget(androidName: _androidName);
  }
}
