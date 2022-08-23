import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/cubit/import_cubit_cubit.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/ui/widgets/racego_appbar.dart';

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
      appBar: const RacegoAppBar(title: 'Import-df'),
      body: Center(
        child: BlocBuilder<ImportCubit, ImportCubitState>(
          bloc: _cubit,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _cubit.importCsv(),
                  child: const Text('Import starten'),
                ),
                if (state is ImportCubitReady && state.message != null)
                  Text(state.message!),
              ],
            );
          },
        ),
      ),
    );
  }
}
