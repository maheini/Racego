import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/models/userdetails.dart';
import 'package:racego/generated/l10n.dart';

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
    for (var element in content) {
      if (element.length >= 3 &&
          element.every(
              (element) => element is String && element.trim().isNotEmpty)) {
        return true;
      }
    }
    return false;
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
