import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/business_logic/userscreen_cubit/userscreen_cubit.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:racego/data/models/time.dart';
import 'package:racego/data/models/userdetails.dart';
import 'package:racego/ui/widgets/coloredbutton.dart';
import 'package:racego/ui/widgets/lapseditor.dart';
import 'package:racego/ui/widgets/loggedoutdialog.dart';
import 'package:racego/generated/l10n.dart';

import '../widgets/selectablelist.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key, int? userId})
      : _id = userId,
        super(key: key);

  final int? _id;

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final UserscreenCubit _userCubit;

  int _id = 0;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  List<String> _raceClasses = [];
  List<String> _allRaceClasses = [];
  List<Time> _laps = [];

  @override
  void initState() {
    _userCubit = UserscreenCubit(context.read<RacegoApi>());
    if (widget._id == null) {
      _userCubit.loadAddScreen();
    } else {
      _id = widget._id!;
      _userCubit.loadEditUser(widget._id!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // show logout popup if user got logged out
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoggedOut || state is LoginError) {
              await loggedOutDialog(context);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/');
              });
            }
          },
        ),
        // show snackbar on error
        BlocListener<UserscreenCubit, UserscreenState>(
          bloc: _userCubit,
          listener: (context, state) {
            if (state is UserScreenAddError || state is UserScreenEditError) {
              RacegoException? exception;
              if (state is UserScreenAddError) {
                exception = state.exception;
              } else if (state is UserScreenEditError) {
                exception = state.exception;
              }
              if (exception is AuthException) {
                context.read<LoginBloc>().add(Logout());
                return;
              }
              Flushbar(
                animationDuration: const Duration(milliseconds: 500),
                margin: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8),
                message: exception != null
                    ? exception.errorMessage
                    : S.current.unknown_error,
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
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(2),
            child: Image.asset('assets/racego_r.png', fit: BoxFit.cover),
          ),
          automaticallyImplyLeading: false,
          title: Text(
            S.current.edit_user,
          ),
          centerTitle: true,
        ),
        body: _userEditor(),
      ),
    );
  }

  Widget _userEditor() {
    return Column(
      children: [
        Expanded(
          child: _content(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocBuilder<UserscreenCubit, UserscreenState>(
              bloc: _userCubit,
              builder: (context, state) {
                if (state is UserScreenLoading ||
                    (state is UserScreenEditError && _dataNeverLoaded)) {
                  return const SizedBox(width: 10);
                } else if (state is UserScreenStored) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pop(context);
                  });
                }
                bool isAddMode =
                    state is UserScreenAdd || state is UserScreenAddError;
                bool isEditMode =
                    state is UserScreenEdit || state is UserScreenEditError;
                bool enabled = isEditMode || isAddMode;
                bool isLoading = state is UserScreenAddSaving ||
                    state is UserScreenEditSaving;

                return ColoredButton(
                  Text(
                    S.current.save,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  isDisabled: !isLoading && !enabled,
                  isLoading: isLoading,
                  color: Colors.green,
                  onPressed: () {
                    if (isAddMode) {
                      UserDetails details = UserDetails(
                          0, _firstName.text, _lastName.text, [], []);
                      _userCubit.addUser(details);
                    } else if (isEditMode) {
                      UserDetails details = UserDetails(_id, _firstName.text,
                          _lastName.text, _raceClasses, _laps);
                      _userCubit.editUser(details);
                    }
                  },
                );
              },
            ),
            const SizedBox(width: 20),
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
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  bool _dataNeverLoaded = true;
  Widget _content() {
    return BlocBuilder<UserscreenCubit, UserscreenState>(
      bloc: _userCubit,
      buildWhen: (context, state) => state is UserScreenStored ? false : true,
      builder: (context, state) {
        state = _userCubit
            .state; // set real state (state from builder isn't accurate)

        if (state is UserScreenEdit) {
          if (_dataNeverLoaded) {
            _dataNeverLoaded = false;
            _id = state.user.id;
            _firstName.text = state.user.firstName;
            _lastName.text = state.user.lastName;
            _raceClasses = state.user.classes;
            _allRaceClasses = state.categories;
            _laps = state.user.lapTimes;
          }
        }
        // is error on initial load?
        if (state is UserScreenEditError && _dataNeverLoaded) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.current.loading_user_error),
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
                  onPressed: () => _userCubit.loadEditUser(widget._id ?? _id),
                ),
              ],
            ),
          );
        }
        bool isAddState = state is UserScreenAdd ||
            state is UserScreenAddError ||
            state is UserScreenAddSaving;
        bool isEditState = state is UserScreenEdit ||
            state is UserScreenEditError ||
            state is UserScreenEditSaving;

        if (isAddState || isEditState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_box_rounded,
                size: 120,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration:
                          InputDecoration(hintText: S.current.first_name),
                      controller: _firstName,
                    ),
                    TextField(
                      decoration:
                          InputDecoration(hintText: S.current.last_name),
                      controller: _lastName,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (isEditState)
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: SelectableList(
                          items: _allRaceClasses,
                          selectedItems: _raceClasses,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(child: LapsEditor(_laps)),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
