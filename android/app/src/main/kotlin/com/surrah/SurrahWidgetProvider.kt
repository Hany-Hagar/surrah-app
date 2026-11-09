package com.surrah.app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class SurrahWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        val enabled = widgetData.getBoolean("widget_enabled", false)
        val showBalance = widgetData.getBoolean("show_balance", false)
        val balance = widgetData.getString("balance", "") ?: ""
        val showIncome = widgetData.getBoolean("show_income", true)
        val showExpense = widgetData.getBoolean("show_expense", true)
        val showCategory = widgetData.getBoolean("show_category", true)

        appWidgetIds.forEach { id ->
            val views = RemoteViews(context.packageName, R.layout.surrah_widget)

            fun vis(on: Boolean) = if (on) View.VISIBLE else View.GONE

            // الويدجت مقفولة: رسالة بسيطة وبس
            views.setViewVisibility(R.id.off_message, vis(!enabled))
            views.setViewVisibility(R.id.balance_box, vis(enabled))
            views.setViewVisibility(R.id.tiles_row, vis(enabled))

            if (enabled) {
                // الرقم بيظهر بس لو الإظهار مفعّل وفيه قيمة فعلًا
                val visible = showBalance && balance.isNotEmpty()
                views.setTextViewText(R.id.tv_balance, if (visible) balance else "••••••")
                views.setImageViewResource(
                    R.id.iv_balance_icon,
                    if (visible) R.drawable.ic_eye else R.drawable.ic_lock
                )

                views.setViewVisibility(R.id.tile_income, vis(showIncome))
                views.setViewVisibility(R.id.tile_expense, vis(showExpense))
                views.setViewVisibility(R.id.tile_category, vis(showCategory))
            }

            // كل جزء يفتح التطبيق برابط مختلف (هنستقبله في الخطوة 8)
            fun link(viewId: Int, path: String) {
                views.setOnClickPendingIntent(
                    viewId,
                    HomeWidgetLaunchIntent.getActivity(
                        context,
                        MainActivity::class.java,
                        Uri.parse("surrah://$path")
                    )
                )
            }
            link(R.id.root, "home")
            link(R.id.tile_income, "add_income")
            link(R.id.tile_expense, "add_expense")
            link(R.id.tile_category, "add_category")

            appWidgetManager.updateAppWidget(id, views)
        }
    }
}