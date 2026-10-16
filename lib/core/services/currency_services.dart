import '../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_countries/world_countries.dart' hide CountryFlag;

class CurrencyServices {
  static Widget card({
    required BuildContext context,
    required FiatCurrency currentCurrency,
    required ValueChanged<FiatCurrency> onSelect,
  }) {
    return GestureDetector(
      onTap: () {
        final picker = _currenciesBody(
          context: context,
          currentCurrency: currentCurrency,
          onSelect: onSelect,
        );
        picker.showInModalBottomSheet(context);
      },
      child: _Card(currency: currentCurrency),
    );
  }

  static Widget setup({
    bool showSearchBar = true,
    EdgeInsetsGeometry? padding,
    required BuildContext context,
    required FiatCurrency currentCurrency,
    required ValueChanged<FiatCurrency> onSelect,
  }) {
    return _currenciesBody(
      padding: padding,
      context: context,
      onSelect: onSelect,
      showSearchBar: showSearchBar,
      currentCurrency: currentCurrency,
    );
  }

  static CurrencyPicker _currenciesBody({
    bool showSearchBar = true,
    EdgeInsetsGeometry? padding,
    required BuildContext context,
    required FiatCurrency currentCurrency,
    required ValueChanged<FiatCurrency> onSelect,
  }) {
    return CurrencyPicker(
      showSearchBar: showSearchBar,
      currencies: [
        currentCurrency,
        ...FiatCurrency.list.where(
          (currency) => currency.code != currentCurrency.code,
        ),
      ],
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      searchBarPadding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h,
          ).copyWith(bottom: 0.h),
      itemBuilder: (props, defaultTile) {
        final currency = props.item;

        return _Item(
          currency: currency,
          currentCurrency: currentCurrency,
          onTap: () {
            onSelect.call(currency);
          },
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  final FiatCurrency currency;
  const _Card({required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsetsDirectional.only(end: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: theme.disabledColor.withAlpha(5),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: theme.disabledColor, width: 1.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Flag(currency: currency, size: 20.sp),
          SizedBox(width: 5.w),
          CustomText(text: currency.code, size: 16.sp, type: Type.overMedium),
          Icon(Icons.arrow_drop_down, size: 22.sp),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final VoidCallback onTap;
  final FiatCurrency currency;
  final FiatCurrency currentCurrency;

  const _Item({
    required this.onTap,
    required this.currency,
    required this.currentCurrency,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currency.code == currentCurrency.code;
    return ListTile(
      onTap: onTap,
      minTileHeight: 60.h,
      horizontalTitleGap: 10.w,
      leading: _Flag(currency: currency, size: 30.sp),
      title: _text(
        text: currency.maybeCommonNameFor(context.maybeLocale) ?? currency.name,
        isSubtitle: false,
      ),
      subtitle: _text(text: currency.code, isSubtitle: true),
      trailing: Row(
        spacing: 5.w,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _text(text: currency.symbol ?? "", isSubtitle: false),
          if(isSelected) Icon(Icons.check_circle, color: Colors.green, size: 25.sp),
        ]
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    );
  }

  CustomText _text({required String text, required bool isSubtitle}) {
    return CustomText(
      text: text,
      height: 1.4.h,
      type: Type.overMedium,
      size: isSubtitle ? 14.sp : 16.sp,
      opacity: isSubtitle ? FontOpacity.medium : FontOpacity.high,
    );
  }
}



class _Flag extends StatelessWidget {
  final double? size;
  final FiatCurrency currency;
  const _Flag({required this.currency, this.size});

  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromCurrencyCode(
      currency.code,
      theme: EmojiTheme(size: size ?? 20.sp),
    );
  }
}
