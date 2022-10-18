import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/models/userdetails.dart';
import 'package:racego/generated/l10n.dart';
import 'package:racego/data/models/time.dart';

part 'import_cubit_state.dart';

class ImportCubit extends Cubit<ImportCubitState> {
  ImportCubit(this._api) : super(ImportCubitReady());
  final RacegoApi _api;

  Future<void> importCsv() async {
    emit(ImportCubitLoading());
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        String fileContent = '';

        // convert file to String
        if (kIsWeb) {
          final Uint8List fileBytes = result.files.first.bytes ?? Uint8List(0);
          fileContent = utf8.decode(fileBytes);
        } else {
          fileContent =
              await File(result.files.single.path ?? '').readAsString();
        }

        List<List<dynamic>> content = const CsvToListConverter()
            .convert(fileContent, fieldDelimiter: ';');

        if (!_checkCsvContent(content)) {
          emit(ImportCubitReady(message: S.current.csv_import_file_invalid));
          return;
        }

        // upload list
        List<UserDetails> userDetails = _convertCsvToUserDetails(content);

        // check result
        int inserted = await _uploadNewUsers(userDetails);
        emit(ImportCubitReady(
            message: S.current.csv_import_successful(inserted)));
      } else {
        // User canceled the picker
        emit(ImportCubitReady(message: S.current.csv_import_cancelled));
      }
    } catch (_) {
      emit(ImportCubitReady(message: S.current.unknown_error));
    }
  }

  bool _checkCsvContent(List<List<dynamic>> content) {
    int lapColumn = -1;

    for (int row = 0; row < content.length; row++) {
      List<dynamic> rowData = content[row];

      if (!rowData.every((element) => element is String)) return false;

      if (row == 0) {
        for (int column = 0; column < rowData.length; column++) {
          switch (column) {
            case 0:
              if (rowData[column] != S.current.first_name) return false;
              break;
            case 1:
              if (rowData[column] != S.current.last_name) return false;
              break;
            default:
              if (lapColumn < 0 && rowData[column] == S.current.race_class) {
                break;
              } else if (rowData[column] == S.current.lap) {
                if (lapColumn < 0) lapColumn = column;
                break;
              } else {
                return false;
              }
          }
        }
      } else {
        for (int column = 0; column < rowData.length; column++) {
          if ((column == 0 || column == 1) && rowData[column].isEmpty) {
            return false;
          } else if (lapColumn > -1 &&
              column >= lapColumn &&
              rowData[column].isNotEmpty) {
            if (!Time.fromTimeString(rowData[column]).isValid) return false;
          }
        }
      }
    }
    return true;
  }

  /// Convert csv data to UserDetails -> IMPORTANT: use checkCsvContent before!
  List<UserDetails> _convertCsvToUserDetails(List<List<dynamic>> content) {
    List<UserDetails> userList = [];

    int firstLapTime = -1;
    for (int row = 0; row < content.length; row++) {
      List<dynamic> values = content[row];
      // if row is header? then determine the first laptime column
      if (row == 0) {
        for (int column = 0; column < values.length; column++) {
          if (values[column] == S.current.lap) {
            firstLapTime = column;
            break;
          }
        }
      } else {
        // Add classes
        List<String> classes = [];
        for (int column = 2;
            column < (firstLapTime > -1 ? firstLapTime : values.length);
            column++) {
          if (values[column].isNotEmpty) classes.add(values[column]);
        }

        // Add lap times
        List<Time> laps = [];
        if (firstLapTime > -1) {
          for (int column = firstLapTime; column < values.length; column++) {
            if (values[column].isNotEmpty) {
              laps.add(Time.fromTimeString(values[column]));
            }
          }
        }

        // Generate UserDetails
        UserDetails user = UserDetails(0, values[0], values[1], classes, laps);

        userList.add(user);
      }
    }
    return userList;
  }

  Future<int> _uploadNewUsers(List<UserDetails> userList) async {
    int success = 0;
    for (var element in userList) {
      try {
        if (await _api.addUser(element) > 0) {
          success++;
        }
      } catch (_) {
        // Ignored...
      }
    }
    return success;
  }
}
