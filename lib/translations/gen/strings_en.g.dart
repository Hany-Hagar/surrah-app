///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$onBoarding$en onBoarding = _Translations$onBoarding$en._(_root);
	@override late final _Translations$setup$en setup = _Translations$setup$en._(_root);
}

// Path: onBoarding
class _Translations$onBoarding$en extends Translations$onBoarding$ar {
	_Translations$onBoarding$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title1 => 'Track every pound';
	@override String get description1 => 'Log your income and expenses in seconds.';
	@override String get title2 => 'See where your money goes';
	@override String get description2 => 'Organize spending by category and review daily, weekly and monthly reports.';
	@override String get title3 => 'Your data stays with you';
	@override String get description3 => 'Everything is stored on your phone. No account, no internet.';
	@override String get skip => 'Skip';
	@override String get next => 'Next';
	@override String get getStarted => 'Start setup';
}

// Path: setup
class _Translations$setup$en extends Translations$setup$ar {
	_Translations$setup$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get appName => 'Surrah';
	@override String get back => 'Back';
	@override String get skip => 'Skip';
	@override String get next => 'Next';
	@override String get getStarted => 'Get Started';
	@override late final _Translations$setup$skipDialog$en skipDialog = _Translations$setup$skipDialog$en._(_root);
}

// Path: setup.skipDialog
class _Translations$setup$skipDialog$en extends Translations$setup$skipDialog$ar {
	_Translations$setup$skipDialog$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confirm Skip';
	@override String get message => 'Are you sure you want to skip the setup process?';
	@override String get cancel => 'Cancel';
	@override String get confirm => 'Skip';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'onBoarding.title1' => 'Track every pound',
			'onBoarding.description1' => 'Log your income and expenses in seconds.',
			'onBoarding.title2' => 'See where your money goes',
			'onBoarding.description2' => 'Organize spending by category and review daily, weekly and monthly reports.',
			'onBoarding.title3' => 'Your data stays with you',
			'onBoarding.description3' => 'Everything is stored on your phone. No account, no internet.',
			'onBoarding.skip' => 'Skip',
			'onBoarding.next' => 'Next',
			'onBoarding.getStarted' => 'Start setup',
			'setup.appName' => 'Surrah',
			'setup.back' => 'Back',
			'setup.skip' => 'Skip',
			'setup.next' => 'Next',
			'setup.getStarted' => 'Get Started',
			'setup.skipDialog.title' => 'Confirm Skip',
			'setup.skipDialog.message' => 'Are you sure you want to skip the setup process?',
			'setup.skipDialog.cancel' => 'Cancel',
			'setup.skipDialog.confirm' => 'Skip',
			_ => null,
		};
	}
}
