///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsAr = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$onBoarding$ar onBoarding = Translations$onBoarding$ar.internal(_root);
	late final Translations$setup$ar setup = Translations$setup$ar.internal(_root);
}

// Path: onBoarding
class Translations$onBoarding$ar {
	Translations$onBoarding$ar.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ar: 'تابع كل جنيه'
	String get title1 => 'تابع كل جنيه';

	/// ar: 'سجّل دخلك ومصروفاتك في ثواني.'
	String get description1 => 'سجّل دخلك ومصروفاتك في ثواني.';

	/// ar: 'اعرف فلوسك رايحة فين'
	String get title2 => 'اعرف فلوسك رايحة فين';

	/// ar: 'رتّب مصروفاتك في فئات وشوف تقارير يومية وأسبوعية وشهرية.'
	String get description2 => 'رتّب مصروفاتك في فئات وشوف تقارير يومية وأسبوعية وشهرية.';

	/// ar: 'بياناتك معاك بس'
	String get title3 => 'بياناتك معاك بس';

	/// ar: 'كل حاجة محفوظة على موبايلك، من غير حساب ومن غير إنترنت.'
	String get description3 => 'كل حاجة محفوظة على موبايلك، من غير حساب ومن غير إنترنت.';

	/// ar: 'تخطي'
	String get skip => 'تخطي';

	/// ar: 'التالي'
	String get next => 'التالي';

	/// ar: 'ابدأ الإعداد'
	String get getStarted => 'ابدأ الإعداد';
}

// Path: setup
class Translations$setup$ar {
	Translations$setup$ar.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ar: 'تخطي'
	String get skip => 'تخطي';

	/// ar: 'التالي'
	String get next => 'التالي';

	/// ar: 'ابدأ الآن'
	String get getStarted => 'ابدأ الآن';

	late final Translations$setup$skipDialog$ar skipDialog = Translations$setup$skipDialog$ar.internal(_root);
}

// Path: setup.skipDialog
class Translations$setup$skipDialog$ar {
	Translations$setup$skipDialog$ar.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ar: 'تأكيد التخطي'
	String get title => 'تأكيد التخطي';

	/// ar: 'هل أنت متأكد أنك تريد تخطي عملية الإعداد؟'
	String get message => 'هل أنت متأكد أنك تريد تخطي عملية الإعداد؟';

	/// ar: 'إلغاء'
	String get cancel => 'إلغاء';

	/// ar: 'تخطي'
	String get confirm => 'تخطي';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'onBoarding.title1' => 'تابع كل جنيه',
			'onBoarding.description1' => 'سجّل دخلك ومصروفاتك في ثواني.',
			'onBoarding.title2' => 'اعرف فلوسك رايحة فين',
			'onBoarding.description2' => 'رتّب مصروفاتك في فئات وشوف تقارير يومية وأسبوعية وشهرية.',
			'onBoarding.title3' => 'بياناتك معاك بس',
			'onBoarding.description3' => 'كل حاجة محفوظة على موبايلك، من غير حساب ومن غير إنترنت.',
			'onBoarding.skip' => 'تخطي',
			'onBoarding.next' => 'التالي',
			'onBoarding.getStarted' => 'ابدأ الإعداد',
			'setup.skip' => 'تخطي',
			'setup.next' => 'التالي',
			'setup.getStarted' => 'ابدأ الآن',
			'setup.skipDialog.title' => 'تأكيد التخطي',
			'setup.skipDialog.message' => 'هل أنت متأكد أنك تريد تخطي عملية الإعداد؟',
			'setup.skipDialog.cancel' => 'إلغاء',
			'setup.skipDialog.confirm' => 'تخطي',
			_ => null,
		};
	}
}
