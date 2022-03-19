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

  static String m0(errorCode) =>
      "Invalid server response: Errorcode: ${errorCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "all_classes": MessageLookupByLibrary.simpleMessage("All classes"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "create_class_hint":
            MessageLookupByLibrary.simpleMessage("Create Class..."),
        "edit_user": MessageLookupByLibrary.simpleMessage("Edit User"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "email_empty": MessageLookupByLibrary.simpleMessage("Email is empty"),
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
        "invalid_server_response": m0,
        "language": MessageLookupByLibrary.simpleMessage("English"),
        "lap_time": MessageLookupByLibrary.simpleMessage("Time"),
        "laps": MessageLookupByLibrary.simpleMessage("Laps"),
        "last_name": MessageLookupByLibrary.simpleMessage("Last Name"),
        "loading_user_error":
            MessageLookupByLibrary.simpleMessage("Error loading the user."),
        "login_invalid": MessageLookupByLibrary.simpleMessage(
            "Incorrect username or password."),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "no_permission":
            MessageLookupByLibrary.simpleMessage("No authorization."),
        "ok_flat": MessageLookupByLibrary.simpleMessage("OK"),
        "participants": MessageLookupByLibrary.simpleMessage("Participants"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "password_empty":
            MessageLookupByLibrary.simpleMessage("Password is empty"),
        "race_classes": MessageLookupByLibrary.simpleMessage("Race Classes"),
        "race_track": MessageLookupByLibrary.simpleMessage("Race Track"),
        "rank": MessageLookupByLibrary.simpleMessage("Rank"),
        "ranking": MessageLookupByLibrary.simpleMessage("Ranking"),
        "requestet_entity_not_found": MessageLookupByLibrary.simpleMessage(
            "Requested entity was not found.."),
        "retry": MessageLookupByLibrary.simpleMessage("Try again"),
        "retry_login":
            MessageLookupByLibrary.simpleMessage("Please login again"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search_hint": MessageLookupByLibrary.simpleMessage("Search..."),
        "session_expired":
            MessageLookupByLibrary.simpleMessage("Session expired"),
        "session_expired_details": MessageLookupByLibrary.simpleMessage(
            "Your session has expired. Please log in again."),
        "sign_in": MessageLookupByLibrary.simpleMessage("Login"),
        "sign_in_title": MessageLookupByLibrary.simpleMessage("Racego login"),
        "sync_errormessage": MessageLookupByLibrary.simpleMessage(
            "Error: Synchronization interrupted!"),
        "unknown_error":
            MessageLookupByLibrary.simpleMessage("Unbekannter Fehler"),
        "unprocessable_entity": MessageLookupByLibrary.simpleMessage(
            "Couldn\'t process the request."),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome back")
      };
}
