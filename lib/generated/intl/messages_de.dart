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

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: '1 Benutzer hinzugefügt', other: '${howMany} Benutzer hinzugefügt')}";

  static String m1(errorCode) =>
      "Ungültige Serverantwort: Fehlercode: ${errorCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_race_failed_invalid_input_data":
            MessageLookupByLibrary.simpleMessage(
                "Fehler beim erstellen des Rennens: Fehlerhafte Eingabedaten"),
        "add_ranking_hint":
            MessageLookupByLibrary.simpleMessage("Rennen hinzufügen..."),
        "add_username":
            MessageLookupByLibrary.simpleMessage("Benutzername hinzufügen"),
        "all_classes": MessageLookupByLibrary.simpleMessage("Alle Klassen"),
        "back": MessageLookupByLibrary.simpleMessage("Zurück"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "cancel_flat": MessageLookupByLibrary.simpleMessage("ABBRECHEN"),
        "create_class_hint":
            MessageLookupByLibrary.simpleMessage("Klasse erstellen..."),
        "csv_file_must_contain_headers": MessageLookupByLibrary.simpleMessage(
            "Die CSV Datei muss folgende Spaltenüberschriften enthalten: "),
        "csv_import": MessageLookupByLibrary.simpleMessage(
            "CSV Import (UTF-8, Semikolon-getrennt)"),
        "csv_import_cancelled":
            MessageLookupByLibrary.simpleMessage("Import abgebrochen"),
        "csv_import_description": MessageLookupByLibrary.simpleMessage(
            "Importiere mehrere Benutzer schnell und einfach mittels CSV Datei. Du kannst diese Datei zum Beispiel mit Excel erstellen durch drücken auf Speichern unter ->  Dateityp -> CSV UTF-8."),
        "csv_import_file_invalid": MessageLookupByLibrary.simpleMessage(
            "Die ausgewählte Datei ist ungültig"),
        "csv_import_file_not_exists": MessageLookupByLibrary.simpleMessage(
            "Die ausgewählte Datei existiert nicht"),
        "csv_import_successful": m0,
        "edit_user":
            MessageLookupByLibrary.simpleMessage("Benutzer bearbeiten"),
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
        "failed_registration": MessageLookupByLibrary.simpleMessage(
            "Registrierung fehlgeschlagen."),
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
        "import": MessageLookupByLibrary.simpleMessage("Importieren"),
        "invalid_server_response": m1,
        "language": MessageLookupByLibrary.simpleMessage("Deutsch"),
        "lap": MessageLookupByLibrary.simpleMessage("Runde"),
        "lap_time": MessageLookupByLibrary.simpleMessage("Zeit"),
        "laps": MessageLookupByLibrary.simpleMessage("Runden"),
        "last_name": MessageLookupByLibrary.simpleMessage("Nachname"),
        "loading_user_error": MessageLookupByLibrary.simpleMessage(
            "Fehler beim laden des Benutzers."),
        "log_out": MessageLookupByLibrary.simpleMessage("Abmelden"),
        "login_invalid": MessageLookupByLibrary.simpleMessage(
            "Ungültiger Benutzername oder Passwort."),
        "login_now": MessageLookupByLibrary.simpleMessage(
            "Konto bereits vorhanden? Hier anmelden!"),
        "manage_your_races":
            MessageLookupByLibrary.simpleMessage("Deine Rennen"),
        "management": MessageLookupByLibrary.simpleMessage("Verwaltung"),
        "management_subtitle": MessageLookupByLibrary.simpleMessage(
            "Erstelle, bearbeite oder wähle ein Rennen aus um fortzufahren"),
        "manager": MessageLookupByLibrary.simpleMessage("Verwalter"),
        "manager_subtitle": MessageLookupByLibrary.simpleMessage(
            "Füge Verwalter oder zusätzliche Administratoren hinzu. Wichtig: Der Benutzername muss stimmen."),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "name_empty": MessageLookupByLibrary.simpleMessage("Name ist leer"),
        "no_permission":
            MessageLookupByLibrary.simpleMessage("Fehlende Berechtigung."),
        "ok_flat": MessageLookupByLibrary.simpleMessage("OK"),
        "participants": MessageLookupByLibrary.simpleMessage("Teilnehmer"),
        "password": MessageLookupByLibrary.simpleMessage("Passwort"),
        "password_empty":
            MessageLookupByLibrary.simpleMessage("Passwort ist leer"),
        "password_too_short":
            MessageLookupByLibrary.simpleMessage("Passwort ist zu kurz"),
        "race_class": MessageLookupByLibrary.simpleMessage("Rennklasse"),
        "race_classes": MessageLookupByLibrary.simpleMessage("Rennklassen"),
        "race_track": MessageLookupByLibrary.simpleMessage("Rennstrecke"),
        "rank": MessageLookupByLibrary.simpleMessage("Rang"),
        "ranking": MessageLookupByLibrary.simpleMessage("Rangliste"),
        "register": MessageLookupByLibrary.simpleMessage("Registrieren"),
        "register_now": MessageLookupByLibrary.simpleMessage(
            "Kein Konto? Jetzt registrieren!"),
        "register_title":
            MessageLookupByLibrary.simpleMessage("Racego Registrierung"),
        "remove_race_warning": MessageLookupByLibrary.simpleMessage(
            "Wollen Sie dieses Rennen wirklich entfernen?"),
        "remove_title": MessageLookupByLibrary.simpleMessage("Entfernen"),
        "requestet_entity_not_found": MessageLookupByLibrary.simpleMessage(
            "Die Angeforderten Daten wurden nicht gefunden.."),
        "retry": MessageLookupByLibrary.simpleMessage("Neu versuchen"),
        "retry_login": MessageLookupByLibrary.simpleMessage(
            "Bitte melden Sie sich erneut an."),
        "role": MessageLookupByLibrary.simpleMessage("Rolle"),
        "role_administrator": MessageLookupByLibrary.simpleMessage("Admin"),
        "role_manager": MessageLookupByLibrary.simpleMessage("Nutzer"),
        "save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "search_hint": MessageLookupByLibrary.simpleMessage("Suchen..."),
        "session_expired":
            MessageLookupByLibrary.simpleMessage("Sitzung abgelaufen"),
        "session_expired_details": MessageLookupByLibrary.simpleMessage(
            "Ihre Sitzung ist abgelaufen. Bitte melden Sie sich neu an."),
        "sign_in": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "sign_in_title": MessageLookupByLibrary.simpleMessage("Racego Login"),
        "start_import": MessageLookupByLibrary.simpleMessage("Import starten"),
        "switch_role": MessageLookupByLibrary.simpleMessage("Rolle ändern"),
        "sync_errormessage": MessageLookupByLibrary.simpleMessage(
            "Fehler: Synchronisation unterbrochen!"),
        "unknown_error":
            MessageLookupByLibrary.simpleMessage("Unbekannter Fehler"),
        "unprocessable_entity": MessageLookupByLibrary.simpleMessage(
            "Die Anfrage konnte nicht bearbeitet werden."),
        "username": MessageLookupByLibrary.simpleMessage("Benutzername"),
        "username_empty":
            MessageLookupByLibrary.simpleMessage("Benutzername ist leer"),
        "username_too_short":
            MessageLookupByLibrary.simpleMessage("Benutzername ist zu kurz"),
        "welcome": MessageLookupByLibrary.simpleMessage("Willkommen zurück")
      };
}
