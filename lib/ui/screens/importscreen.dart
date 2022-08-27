import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/import_cubit/import_cubit_cubit.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/generated/l10n.dart';
import 'package:racego/ui/widgets/coloredbutton.dart';
import 'package:racego/ui/widgets/racego_appbar.dart';
import 'package:racego/ui/widgets/titlebar.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({Key? key}) : super(key: key);

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  late final ImportCubit _cubit;

  @override
  void initState() {
    _cubit = ImportCubit(context.read<RacegoApi>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RacegoAppBar(title: S.of(context).import),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _csvImport(),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ColoredButton(
                  Text(
                    S.of(context).back,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.red,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _csvImport() {
    return BlocBuilder<ImportCubit, ImportCubitState>(
      bloc: _cubit,
      builder: (context, state) {
        return Column(
          children: [
            TitleBar(
              S.of(context).csv_import,
              subtitle: S.of(context).csv_import_description +
                  '\n\n' +
                  S.of(context).csv_file_must_contain_headers +
                  S.current.first_name +
                  ', ' +
                  S.of(context).last_name +
                  ', ' +
                  S.of(context).race_class +
                  ', ...,' +
                  S.of(context).lap +
                  ', ...',
            ),
            const SizedBox(height: 5),
            if (state is ImportCubitReady && state.message != null)
              Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    state.message ?? '',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            if (state is ImportCubitLoading)
              Column(
                children: const [
                  SizedBox(height: 10),
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                ],
              ),
            ColoredButton(
              Text(
                S.of(context).start_import,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.blue,
              onPressed: () => _cubit.importCsv(),
              isDisabled: state is! ImportCubitReady,
            ),
          ],
        );
      },
    );
  }
}
