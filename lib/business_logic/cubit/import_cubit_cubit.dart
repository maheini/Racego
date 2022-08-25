import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
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

      if (result != null) {
        File file = File(result.files.single.path ?? '');
        if (await file.exists()) {
          String fileContent = await file.readAsString();
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
          // File doesn't exist
          emit(ImportCubitReady(message: S.current.csv_import_file_not_exists));
        }
      } else {
        // User canceled the picker
        emit(ImportCubitReady(message: S.current.csv_import_cancelled));
      }
    } catch (_) {
      emit(ImportCubitReady(message: S.current.unknown_error));
    }
  }

  bool _checkCsvContent(List<List<dynamic>> content) {
    int firstClassColumn = -1;
    int firstLapColumn = -1;

    for (int x = 0; x < content.length; x++) {
      List<dynamic> row = content[x];
      // if is first row, then check the headers
      if (x == 0) {
        for (int column = 0; column < row.length; column++) {
          if (row[column] is! String) {
            return false;
          }
          final String value = row[column];
          switch (column) {
            case 0:
              if (value != S.current.first_name) return false;
              break;
            case 1:
              if (value != S.current.last_name) return false;
              break;
            default:
              // Does column has a name "race_class" and firstClassColumn is not set
              if (value == S.current.race_class && firstLapColumn < 0) {
                if (firstClassColumn < 0) firstClassColumn = column;
              }
              // Does column has a name "race_class" and firstClassColumn is not set
              else if (value == S.current.lap && firstClassColumn > -1) {
                if (firstLapColumn < 0) firstLapColumn = column;
              } else {
                return false;
              }
          }
        }
      }
      // If row isn't header, then check if content is string, not empty and time is validTime
      else {
        for (int column = 0; column < row.length; column++) {
          // Is the value not String -> return false
          if (row[column] is! String) {
            return false;
          }
          // is the value first_name or last_name? check if empty
          else if (column < firstClassColumn && row[column].trim().isEmpty) {
            return false;
          }
          // if value is a time and not empty, then validate the timeString
          else if (column >= firstLapColumn && row[column].isNotEmpty) {
            if (!Time.fromTimeString(row[column]).isValid) return false;
          }
        }
      }
    }
    return true;
  }

  List<UserDetails> _convertCsvToUserDetails(List<List<dynamic>> content) {
    List<UserDetails> userList = [];
    for (var element in content) {
      List<String> classes = [];
      for (var i = 2; i < element.length; i++) {
        String className = element[i];
        if (className.trim().isNotEmpty) {
          classes.add(className);
        }
      }
      UserDetails user = UserDetails(0, element[0], element[1], classes, []);
      userList.add(user);
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
