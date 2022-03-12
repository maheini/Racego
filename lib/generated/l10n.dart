// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: 'The current language',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'Display text for storing changes',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Display text for cancelling changes',
      args: [],
    );
  }

  /// `Try again`
  String get retry {
    return Intl.message(
      'Try again',
      name: 'retry',
      desc: 'Try again text',
      args: [],
    );
  }

  /// `OK`
  String get ok_flat {
    return Intl.message(
      'OK',
      name: 'ok_flat',
      desc: 'ok label for flat buttons',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: 'Display text for going back',
      args: [],
    );
  }

  /// `Race Track`
  String get race_track {
    return Intl.message(
      'Race Track',
      name: 'race_track',
      desc: 'How a race track is called',
      args: [],
    );
  }

  /// `Participants`
  String get participants {
    return Intl.message(
      'Participants',
      name: 'participants',
      desc: 'How the participants are beeing called',
      args: [],
    );
  }

  /// `Race Classes`
  String get race_classes {
    return Intl.message(
      'Race Classes',
      name: 'race_classes',
      desc: 'How race classes are called',
      args: [],
    );
  }

  /// `Laps`
  String get laps {
    return Intl.message(
      'Laps',
      name: 'laps',
      desc: 'How laps are called',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: 'Name of an ID',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: 'How the first name is called',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: 'How the last name is called',
      args: [],
    );
  }

  /// `Racego login`
  String get sign_in_title {
    return Intl.message(
      'Racego login',
      name: 'sign_in_title',
      desc: 'Login title text',
      args: [],
    );
  }

  /// `Login`
  String get sign_in {
    return Intl.message(
      'Login',
      name: 'sign_in',
      desc: 'Login button text',
      args: [],
    );
  }

  /// `Please login again`
  String get retry_login {
    return Intl.message(
      'Please login again',
      name: 'retry_login',
      desc: 'Try login again text',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Email name',
      args: [],
    );
  }

  /// `Email is empty`
  String get email_empty {
    return Intl.message(
      'Email is empty',
      name: 'email_empty',
      desc: 'Email is empty message',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Password name',
      args: [],
    );
  }

  /// `Password is empty`
  String get password_empty {
    return Intl.message(
      'Password is empty',
      name: 'password_empty',
      desc: 'Password is empty message',
      args: [],
    );
  }

  /// `Incorrect username or password.`
  String get login_invalid {
    return Intl.message(
      'Incorrect username or password.',
      name: 'login_invalid',
      desc: 'Email or Password is incorrrect',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcome {
    return Intl.message(
      'Welcome back',
      name: 'welcome',
      desc: 'Welcome message',
      args: [],
    );
  }

  /// `Session expired`
  String get session_expired {
    return Intl.message(
      'Session expired',
      name: 'session_expired',
      desc: 'Message if session expires',
      args: [],
    );
  }

  /// `Your session has expired. Please log in again.`
  String get session_expired_details {
    return Intl.message(
      'Your session has expired. Please log in again.',
      name: 'session_expired_details',
      desc: 'Detailed message if session expires',
      args: [],
    );
  }

  /// `Search...`
  String get search_hint {
    return Intl.message(
      'Search...',
      name: 'search_hint',
      desc: 'Hint text which is displayed for search bars',
      args: [],
    );
  }

  /// `Edit User`
  String get edit_user {
    return Intl.message(
      'Edit User',
      name: 'edit_user',
      desc: 'Edit user title',
      args: [],
    );
  }

  /// `Create Class...`
  String get create_class_hint {
    return Intl.message(
      'Create Class...',
      name: 'create_class_hint',
      desc: 'Hint text which is displayed for create class bars',
      args: [],
    );
  }

  /// `Error: Synchronization interrupted!`
  String get sync_errormessage {
    return Intl.message(
      'Error: Synchronization interrupted!',
      name: 'sync_errormessage',
      desc: 'Warning message if synchronization is interrupted',
      args: [],
    );
  }

  /// `Unbekannter Fehler`
  String get unknown_error {
    return Intl.message(
      'Unbekannter Fehler',
      name: 'unknown_error',
      desc: 'Error message for unknown errors',
      args: [],
    );
  }

  /// `Error loading the user.`
  String get loading_user_error {
    return Intl.message(
      'Error loading the user.',
      name: 'loading_user_error',
      desc: 'Error message if user couldn\'t be loaded',
      args: [],
    );
  }

  /// `User could not be removed from the race track: ID invalid.`
  String get failed_cancelling_lap_invalid_id {
    return Intl.message(
      'User could not be removed from the race track: ID invalid.',
      name: 'failed_cancelling_lap_invalid_id',
      desc:
          'Error message if user couldn\'t be removed from track, because of invalid ID',
      args: [],
    );
  }

  /// `Lap time could not be recorded: ID or time invalid.`
  String get failed_finishing_lap_invalid_id {
    return Intl.message(
      'Lap time could not be recorded: ID or time invalid.',
      name: 'failed_finishing_lap_invalid_id',
      desc:
          'Error message if lap could not be stored, because of invalid ID or lap-time',
      args: [],
    );
  }

  /// `User could not be removed: ID invalid.`
  String get failed_removing_user_invalid_id {
    return Intl.message(
      'User could not be removed: ID invalid.',
      name: 'failed_removing_user_invalid_id',
      desc:
          'Error message if user couldn\'t be removed -> because ID is invalid',
      args: [],
    );
  }

  /// `User could not be placed on the race track: ID invalid.`
  String get failed_adding_user_on_track_invalid_id {
    return Intl.message(
      'User could not be placed on the race track: ID invalid.',
      name: 'failed_adding_user_on_track_invalid_id',
      desc: 'Error message if user couldn\'t be placed on the track',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
