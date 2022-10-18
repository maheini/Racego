import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/racedetails_cubit/race_details_cubit.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/models/racedetails.dart';
import 'package:racego/ui/widgets/racemanager_list.dart';

import '../../business_logic/login/login_bloc.dart';
import '../../data/exceptions/racego_exception.dart';
import '../../generated/l10n.dart';
import '../widgets/coloredbutton.dart';
import '../widgets/loggedoutdialog.dart';

class RaceDetailScreen extends StatefulWidget {
  const RaceDetailScreen(this.id, {Key? key}) : super(key: key);

  final int id;

  @override
  State<RaceDetailScreen> createState() => _RaceDetailScreenState();
}

class _RaceDetailScreenState extends State<RaceDetailScreen> {
  late final RaceDetailsCubit _cubit;
  final TextEditingController _nameController = TextEditingController();
  RaceDetails? _details;
  // List<RaceManager> _raceManager = [];

  @override
  void initState() {
    _cubit = RaceDetailsCubit(context.read<RacegoApi>())
      ..loadDetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoggedOut || state is LoginError) {
          await loggedOutDialog(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/');
          });
        }
      },
      child: Scaffold(
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(2),
        child: Image.asset('assets/racego_r.png', fit: BoxFit.cover),
      ),
      automaticallyImplyLeading: false,
      title: Text(
        S.of(context).management,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column(
      children: [
        const SizedBox(height: 20),
        _content(),
        const SizedBox(height: 20),
        _toolButtons(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _content() {
    return Expanded(
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          width: 800,
          child: BlocBuilder<RaceDetailsCubit, RaceDetailsState>(
            bloc: _cubit,
            builder: (context, state) {
              if (state is RaceDetailsLoaded) {
                _details = state.details;
                _nameController.text = _details!.name;
              }

              if (state is RaceDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RaceDetailsLoaded ||
                  state is RaceDetailsSaving ||
                  state is RaceDetailsSaveFailure ||
                  state is RaceDetailsSaveSuccess) {
                if (state is RaceDetailsSaveSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pop(context);
                  });
                } else if (state is RaceDetailsSaveFailure) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showWarning(exception: state.error);
                  });
                }
                return _editor();
              } else {
                String error = S.of(context).unknown_error;
                if (state is RaceDetailsError) {
                  error = state.error.errorMessage;
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(error),
                      const SizedBox(height: 20),
                      ColoredButton(
                        Text(
                          S.current.retry,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: () => _cubit.loadDetails(widget.id),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _editor() {
    return Column(
      children: [
        TextField(
          textAlign: TextAlign.center,
          controller: _nameController,
          style: const TextStyle(fontSize: 25),
          decoration: InputDecoration(
            hintText: S.of(context).name,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.edit),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: RaceManagerList(manager: _details!.managers),
        ),
      ],
    );
  }

  Widget _toolButtons() {
    return BlocBuilder<RaceDetailsCubit, RaceDetailsState>(
      bloc: _cubit,
      builder: (context, state) {
        bool backVisible = false;
        bool saveVisible = false;
        bool saveLoading = false;

        if (state is RaceDetailsLoaded ||
            state is RaceDetailsSaveFailure ||
            state is RaceDetailsSaveSuccess) {
          backVisible = true;
          saveVisible = true;
          saveLoading = false;
        } else if (state is RaceDetailsSaving) {
          backVisible = true;
          saveVisible = true;
          saveLoading = true;
        } else {
          backVisible = true;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (saveVisible)
              ColoredButton(
                Text(
                  S.current.save,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isLoading: saveLoading,
                onPressed: () {
                  if (_nameController.text.isEmpty) {
                    _showWarning(errorMessage: S.current.name_empty);
                  } else {
                    _details!.name = _nameController.text;
                    _cubit.saveDetails(_details!);
                  }
                },
                color: Colors.green,
              ),
            if (saveVisible) const SizedBox(width: 20),
            if (backVisible)
              ColoredButton(
                Text(
                  S.current.back,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                color: Colors.red,
              ),
            const SizedBox(width: 20),
          ],
        );
      },
    );
  }

  void _showWarning({RacegoException? exception, String? errorMessage}) {
    Flushbar(
      animationDuration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      message: exception != null ? exception.errorMessage : errorMessage ?? '',
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      isDismissible: true,
      icon: const Icon(
        Icons.warning_amber_rounded,
        size: 28.0,
        color: Colors.red,
      ),
      mainButton: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          S.of(context).ok_flat,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
    ).show(context);
  }
}
