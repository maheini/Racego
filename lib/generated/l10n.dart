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

  /// `CANCEL`
  String get cancel_flat {
    return Intl.message(
      'CANCEL',
      name: 'cancel_flat',
      desc: 'Cancel label for flat buttons',
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

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Name is empty`
  String get name_empty {
    return Intl.message(
      'Name is empty',
      name: 'name_empty',
      desc: '',
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
      desc: '',
      args: [],
    );
  }

  /// `Racego registration`
  String get register_title {
    return Intl.message(
      'Racego registration',
      name: 'register_title',
      desc: '',
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

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get log_out {
    return Intl.message(
      'Logout',
      name: 'log_out',
      desc: '',
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

  /// `No Account? Register now!`
  String get register_now {
    return Intl.message(
      'No Account? Register now!',
      name: 'register_now',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Login here!`
  String get login_now {
    return Intl.message(
      'Already have an account? Login here!',
      name: 'login_now',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Username is too short`
  String get username_too_short {
    return Intl.message(
      'Username is too short',
      name: 'username_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Username is empty`
  String get username_empty {
    return Intl.message(
      'Username is empty',
      name: 'username_empty',
      desc: '',
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

  /// `Password is too short`
  String get password_too_short {
    return Intl.message(
      'Password is too short',
      name: 'password_too_short',
      desc: '',
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
      desc: 'Username or Password is incorrrect',
      args: [],
    );
  }

  /// `Registration failed`
  String get failed_registration {
    return Intl.message(
      'Registration failed',
      name: 'failed_registration',
      desc: '',
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

  /// `Ranking`
  String get ranking {
    return Intl.message(
      'Ranking',
      name: 'ranking',
      desc: 'Text translation for ranking',
      args: [],
    );
  }

  /// `All classes`
  String get all_classes {
    return Intl.message(
      'All classes',
      name: 'all_classes',
      desc: 'Text translation for \'all classes\'',
      args: [],
    );
  }

  /// `Time`
  String get lap_time {
    return Intl.message(
      'Time',
      name: 'lap_time',
      desc: '',
      args: [],
    );
  }

  /// `Rank`
  String get rank {
    return Intl.message(
      'Rank',
      name: 'rank',
      desc: 'Name of a rank',
      args: [],
    );
  }

  /// `Verwaltung`
  String get management {
    return Intl.message(
      'Verwaltung',
      name: 'management',
      desc: '',
      args: [],
    );
  }

  /// `Your races`
  String get manage_your_races {
    return Intl.message(
      'Your races',
      name: 'manage_your_races',
      desc: '',
      args: [],
    );
  }

  /// `Manager`
  String get manager {
    return Intl.message(
      'Manager',
      name: 'manager',
      desc: '',
      args: [],
    );
  }

  /// `Add ranking...`
  String get add_ranking_hint {
    return Intl.message(
      'Add ranking...',
      name: 'add_ranking_hint',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get role_manager {
    return Intl.message(
      'User',
      name: 'role_manager',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get role_administrator {
    return Intl.message(
      'Admin',
      name: 'role_administrator',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove_title {
    return Intl.message(
      'Remove',
      name: 'remove_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this race?`
  String get remove_race_warning {
    return Intl.message(
      'Are you sure you want to delete this race?',
      name: 'remove_race_warning',
      desc: '',
      args: [],
    );
  }

  /// `Error while creating the race: Incorrect input data`
  String get add_race_failed_invalid_input_data {
    return Intl.message(
      'Error while creating the race: Incorrect input data',
      name: 'add_race_failed_invalid_input_data',
      desc: '',
      args: [],
    );
  }

  /// `Add username`
  String get add_username {
    return Intl.message(
      'Add username',
      name: 'add_username',
      desc: '',
      args: [],
    );
  }

  /// `Switch role`
  String get switch_role {
    return Intl.message(
      'Switch role',
      name: 'switch_role',
      desc: '',
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

  /// `User could not be created: Database ID is invalid.`
  String get failed_adding_user_invalid_id {
    return Intl.message(
      'User could not be created: Database ID is invalid.',
      name: 'failed_adding_user_invalid_id',
      desc: 'Error message if user couldn\'t be created',
      args: [],
    );
  }

  /// `User could not be updated: Unexpected server response.`
  String get failed_updating_user_unexpected_response {
    return Intl.message(
      'User could not be updated: Unexpected server response.',
      name: 'failed_updating_user_unexpected_response',
      desc:
          'Error message if user couldn\'t be updated because of a unexpected server response',
      args: [],
    );
  }

  /// `Error parsing the server response.`
  String get failed_parsing_response {
    return Intl.message(
      'Error parsing the server response.',
      name: 'failed_parsing_response',
      desc: 'Error message if server response couldn\'t be parsed.',
      args: [],
    );
  }

  /// `Login failed.`
  String get failed_login {
    return Intl.message(
      'Login failed.',
      name: 'failed_login',
      desc: 'Error message if login wasn\'t successful.',
      args: [],
    );
  }

  /// `The user details are insufficient.`
  String get failed_updating_user_invalid_data {
    return Intl.message(
      'The user details are insufficient.',
      name: 'failed_updating_user_invalid_data',
      desc: 'Error message if user couldn\'t be updated',
      args: [],
    );
  }

  /// `No authorization.`
  String get no_permission {
    return Intl.message(
      'No authorization.',
      name: 'no_permission',
      desc: 'Error message if user has no permission',
      args: [],
    );
  }

  /// `Requested entity was not found..`
  String get requestet_entity_not_found {
    return Intl.message(
      'Requested entity was not found..',
      name: 'requestet_entity_not_found',
      desc: 'Error message if entity couldn\'t be found',
      args: [],
    );
  }

  /// `Conflict in the sent data.`
  String get failed_send_conflicting_data {
    return Intl.message(
      'Conflict in the sent data.',
      name: 'failed_send_conflicting_data',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't process the request.`
  String get unprocessable_entity {
    return Intl.message(
      'Couldn\'t process the request.',
      name: 'unprocessable_entity',
      desc: 'Error message if send data couldn\'t be processed',
      args: [],
    );
  }

  /// `Invalid server response: Errorcode: {errorCode}`
  String invalid_server_response(Object errorCode) {
    return Intl.message(
      'Invalid server response: Errorcode: $errorCode',
      name: 'invalid_server_response',
      desc: 'Error message if the server response is invalid',
      args: [errorCode],
    );
  }

  /// `The server cannot be reached: Timeout.`
  String get failed_server_timeout {
    return Intl.message(
      'The server cannot be reached: Timeout.',
      name: 'failed_server_timeout',
      desc: 'Error message if the server cannot be reached',
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
