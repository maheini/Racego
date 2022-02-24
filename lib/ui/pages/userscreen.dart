import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/business_logic/userscreen_cubit/userscreen_cubit.dart';
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/exceptions/racego_exception.dart';
import 'package:racego/data/locator/locator.dart';
import 'package:racego/data/models/time.dart';
import 'package:racego/data/models/userdetails.dart';
import 'package:racego/ui/widgets/coloredbutton.dart';
import 'package:racego/ui/widgets/lapseditor.dart';
import 'package:racego/ui/widgets/loggedoutdialog.dart';

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
  final UserscreenCubit _userCubit = UserscreenCubit(locator<RacegoApi>());

  int _id = 0;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  List<String> _raceClasses = [];
  List<String> _allRaceClasses = [];
  List<Time> _laps = [];

  @override
  void initState() {
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
              WidgetsBinding.instance?.addPostFrameCallback((_) {
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 5),
                  content: Text(exception != null
                      ? exception.errorMessage
                      : 'Unbekannter Fehler'),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ),
                ),
              );
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
          backgroundColor: const Color.fromARGB(255, 175, 0, 6),
          title: const Text(
            'Benutzer bearbeiten',
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
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
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
                  const Text(
                    'Speichern',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  isDisabled: !enabled,
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
              const Text(
                'Zurück',
                style: TextStyle(
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
                const Text('Fehler beim Laden des Benutzers. Neu versuchen?'),
                const SizedBox(height: 20),
                ColoredButton(
                  const Text(
                    'Neu versuchen',
                    style: TextStyle(
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
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: const InputDecoration(hintText: 'Vorname'),
                      controller: _firstName,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: 'Nachname'),
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
