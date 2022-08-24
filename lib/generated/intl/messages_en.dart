// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: '1 user added', other: '${howMany} users added')}";

  static String m1(errorCode) =>
      "Invalid server response: Errorcode: ${errorCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_race_failed_invalid_input_data":
            MessageLookupByLibrary.simpleMessage(
                "Error while creating the race: Incorrect input data"),
        "add_ranking_hint":
            MessageLookupByLibrary.simpleMessage("Add ranking..."),
        "add_username": MessageLookupByLibrary.simpleMessage("Add username"),
        "all_classes": MessageLookupByLibrary.simpleMessage("All classes"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cancel_flat": MessageLookupByLibrary.simpleMessage("CANCEL"),
        "create_class_hint":
            MessageLookupByLibrary.simpleMessage("Create Class..."),
        "csv_file_must_contain_headers": MessageLookupByLibrary.simpleMessage(
            "The CSV file must contain following headers: "),
        "csv_import": MessageLookupByLibrary.simpleMessage(
            "CSV import (UTF-8, semicolon seperated)"),
        "csv_import_cancelled":
            MessageLookupByLibrary.simpleMessage("Import cancelled"),
        "csv_import_description": MessageLookupByLibrary.simpleMessage(
            "Import multiple users quick and easy via CSV file. You can create this file for example with Excel by selecting Save as -> Save as type -> CSV UTF-8."),
        "csv_import_file_invalid": MessageLookupByLibrary.simpleMessage(
            "The selected file is invalid"),
        "csv_import_file_not_exists": MessageLookupByLibrary.simpleMessage(
            "The selected file does not exist"),
        "csv_import_successful": m0,
        "edit_user": MessageLookupByLibrary.simpleMessage("Edit User"),
        "failed_adding_user_invalid_id": MessageLookupByLibrary.simpleMessage(
            "User could not be created: Database ID is invalid."),
        "failed_adding_user_on_track_invalid_id":
            MessageLookupByLibrary.simpleMessage(
                "User could not be placed on the race track: ID invalid."),
        "failed_cancelling_lap_invalid_id":
            MessageLookupByLibrary.simpleMessage(
                "User could not be removed from the race track: ID invalid."),
        "failed_finishing_lap_invalid_id": MessageLookupByLibrary.simpleMessage(
            "Lap time could not be recorded: ID or time invalid."),
        "failed_login": MessageLookupByLibrary.simpleMessage("Login failed."),
        "failed_parsing_response": MessageLookupByLibrary.simpleMessage(
            "Error parsing the server response."),
        "failed_registration":
            MessageLookupByLibrary.simpleMessage("Registration failed"),
        "failed_removing_user_invalid_id": MessageLookupByLibrary.simpleMessage(
            "User could not be removed: ID invalid."),
        "failed_send_conflicting_data":
            MessageLookupByLibrary.simpleMessage("Conflict in the sent data."),
        "failed_server_timeout": MessageLookupByLibrary.simpleMessage(
            "The server cannot be reached: Timeout."),
        "failed_updating_user_invalid_data":
            MessageLookupByLibrary.simpleMessage(
                "The user details are insufficient."),
        "failed_updating_user_unexpected_response":
            MessageLookupByLibrary.simpleMessage(
                "User could not be updated: Unexpected server response."),
        "first_name": MessageLookupByLibrary.simpleMessage("First Name"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "import": MessageLookupByLibrary.simpleMessage("Import"),
        "invalid_server_response": m1,
        "language": MessageLookupByLibrary.simpleMessage("English"),
        "lap": MessageLookupByLibrary.simpleMessage("Lap"),
        "lap_time": MessageLookupByLibrary.simpleMessage("Time"),
        "laps": MessageLookupByLibrary.simpleMessage("Laps"),
        "last_name": MessageLookupByLibrary.simpleMessage("Last Name"),
        "loading_user_error":
            MessageLookupByLibrary.simpleMessage("Error loading the user."),
        "log_out": MessageLookupByLibrary.simpleMessage("Logout"),
        "login_invalid": MessageLookupByLibrary.simpleMessage(
            "Incorrect username or password."),
        "login_now": MessageLookupByLibrary.simpleMessage(
            "Already have an account? Login here!"),
        "manage_your_races": MessageLookupByLibrary.simpleMessage("Your races"),
        "management": MessageLookupByLibrary.simpleMessage("Verwaltung"),
        "management_subtitle": MessageLookupByLibrary.simpleMessage(
            "Add, edit or select a race to continue"),
        "manager": MessageLookupByLibrary.simpleMessage("Manager"),
        "manager_subtitle": MessageLookupByLibrary.simpleMessage(
            "Add Manager or additional administrators. Important: The username must be correct."),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "name_empty": MessageLookupByLibrary.simpleMessage("Name is empty"),
        "no_permission":
            MessageLookupByLibrary.simpleMessage("No authorization."),
        "ok_flat": MessageLookupByLibrary.simpleMessage("OK"),
        "participants": MessageLookupByLibrary.simpleMessage("Participants"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "password_empty":
            MessageLookupByLibrary.simpleMessage("Password is empty"),
        "password_too_short":
            MessageLookupByLibrary.simpleMessage("Password is too short"),
        "race_class": MessageLookupByLibrary.simpleMessage("Race class"),
        "race_classes": MessageLookupByLibrary.simpleMessage("Race Classes"),
        "race_track": MessageLookupByLibrary.simpleMessage("Race Track"),
        "rank": MessageLookupByLibrary.simpleMessage("Rank"),
        "ranking": MessageLookupByLibrary.simpleMessage("Ranking"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "register_now":
            MessageLookupByLibrary.simpleMessage("No Account? Register now!"),
        "register_title":
            MessageLookupByLibrary.simpleMessage("Racego registration"),
        "remove_race_warning": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this race?"),
        "remove_title": MessageLookupByLibrary.simpleMessage("Remove"),
        "requestet_entity_not_found": MessageLookupByLibrary.simpleMessage(
            "Requested entity was not found.."),
        "retry": MessageLookupByLibrary.simpleMessage("Try again"),
        "retry_login":
            MessageLookupByLibrary.simpleMessage("Please login again"),
        "role": MessageLookupByLibrary.simpleMessage("Role"),
        "role_administrator": MessageLookupByLibrary.simpleMessage("Admin"),
        "role_manager": MessageLookupByLibrary.simpleMessage("User"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search_hint": MessageLookupByLibrary.simpleMessage("Search..."),
        "session_expired":
            MessageLookupByLibrary.simpleMessage("Session expired"),
        "session_expired_details": MessageLookupByLibrary.simpleMessage(
            "Your session has expired. Please log in again."),
        "sign_in": MessageLookupByLibrary.simpleMessage("Login"),
        "sign_in_title": MessageLookupByLibrary.simpleMessage("Racego login"),
        "start_import": MessageLookupByLibrary.simpleMessage("Start import"),
        "switch_role": MessageLookupByLibrary.simpleMessage("Switch role"),
        "sync_errormessage": MessageLookupByLibrary.simpleMessage(
            "Error: Synchronization interrupted!"),
        "unknown_error":
            MessageLookupByLibrary.simpleMessage("Unbekannter Fehler"),
        "unprocessable_entity": MessageLookupByLibrary.simpleMessage(
            "Couldn\'t process the request."),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "username_empty":
            MessageLookupByLibrary.simpleMessage("Username is empty"),
        "username_too_short":
            MessageLookupByLibrary.simpleMessage("Username is too short"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome back")
      };
}
