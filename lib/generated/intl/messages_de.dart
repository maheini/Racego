// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(errorCode) =>
      "Ungültige Serverantwort: Fehlercode: ${errorCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "back": MessageLookupByLibrary.simpleMessage("Zurück"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "create_class_hint":
            MessageLookupByLibrary.simpleMessage("Klasse erstellen..."),
        "edit_user":
            MessageLookupByLibrary.simpleMessage("Benutzer bearbeiten"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "email_empty": MessageLookupByLibrary.simpleMessage("Email is empty"),
        "failed_adding_user_invalid_id": MessageLookupByLibrary.simpleMessage(
            "Benutzer konnte nicht erstellt werden: Datenbank ID ist ungültig."),
        "failed_adding_user_on_track_invalid_id":
            MessageLookupByLibrary.simpleMessage(
                "Benutzer konnte nicht auf die Rennstrecke gestellt werden: ID ungültig."),
        "failed_cancelling_lap_invalid_id": MessageLookupByLibrary.simpleMessage(
            "Benutzer konnte nicht von der Rennstrecke entfernt werden: ID ungültig."),
        "failed_finishing_lap_invalid_id": MessageLookupByLibrary.simpleMessage(
            "Rundenzeit konnte nicht erfasst werden: Id oder Zeit ungültig."),
        "failed_login":
            MessageLookupByLibrary.simpleMessage("Login fehlgeschlagen."),
        "failed_parsing_response": MessageLookupByLibrary.simpleMessage(
            "Fehler beim Parsen der Serverantwort."),
        "failed_removing_user_invalid_id": MessageLookupByLibrary.simpleMessage(
            "Benutzer konnte nicht entfernt werden: Id ungültig."),
        "failed_send_conflicting_data": MessageLookupByLibrary.simpleMessage(
            "Konflikt in den gesendeten Daten."),
        "failed_server_timeout": MessageLookupByLibrary.simpleMessage(
            "Der Server kann nicht erreicht werden: Zeitüberschreitung."),
        "failed_updating_user_invalid_data":
            MessageLookupByLibrary.simpleMessage(
                "Die Benutzerangaben sind unzureichend."),
        "failed_updating_user_unexpected_response":
            MessageLookupByLibrary.simpleMessage(
                "Benutzer konnte nicht aktualisiert werden: Unerwartete Serverantwort."),
        "first_name": MessageLookupByLibrary.simpleMessage("Vorname"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "invalid_server_response": m0,
        "language": MessageLookupByLibrary.simpleMessage("Deutsch"),
        "laps": MessageLookupByLibrary.simpleMessage("Runden"),
        "last_name": MessageLookupByLibrary.simpleMessage("Nachname"),
        "loading_user_error": MessageLookupByLibrary.simpleMessage(
            "Fehler beim laden des Benutzers."),
        "login_invalid": MessageLookupByLibrary.simpleMessage(
            "Ungültiger Benutzername oder Passwort."),
        "no_permission":
            MessageLookupByLibrary.simpleMessage("Fehlende Berechtigung."),
        "ok_flat": MessageLookupByLibrary.simpleMessage("OK"),
        "participants": MessageLookupByLibrary.simpleMessage("Teilnehmer"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "password_empty":
            MessageLookupByLibrary.simpleMessage("Password is empty"),
        "race_classes": MessageLookupByLibrary.simpleMessage("Rennklassen"),
        "race_track": MessageLookupByLibrary.simpleMessage("Rennstrecke"),
        "requestet_entity_not_found": MessageLookupByLibrary.simpleMessage(
            "Die Angeforderten Daten wurden nicht gefunden.."),
        "retry": MessageLookupByLibrary.simpleMessage("Neu versuchen"),
        "retry_login": MessageLookupByLibrary.simpleMessage(
            "Bitte melden Sie sich erneut an."),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "search_hint": MessageLookupByLibrary.simpleMessage("Suchen..."),
        "session_expired":
            MessageLookupByLibrary.simpleMessage("Sitzung abgelaufen"),
        "session_expired_details": MessageLookupByLibrary.simpleMessage(
            "Ihre Sitzung ist abgelaufen. Bitte melden Sie sich neu an."),
        "sign_in": MessageLookupByLibrary.simpleMessage("Login"),
        "sign_in_title": MessageLookupByLibrary.simpleMessage("Racego login"),
        "sync_errormessage": MessageLookupByLibrary.simpleMessage(
            "Error: Synchronization interrupted!"),
        "unknown_error":
            MessageLookupByLibrary.simpleMessage("Unbekannter Fehler"),
        "unprocessable_entity": MessageLookupByLibrary.simpleMessage(
            "Die Anfrage konnte nicht bearbeitet werden."),
        "welcome": MessageLookupByLibrary.simpleMessage("Willkommen zurück")
      };
}
