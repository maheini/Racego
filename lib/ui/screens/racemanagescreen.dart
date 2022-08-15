import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/listtoolbar/listtoolbar_cubit.dart';
import '../../business_logic/login/login_bloc.dart';
import '../../business_logic/race_manage_cubit/race_manage_cubit.dart';
import '../../data/api/racego_api.dart';
import '../../data/exceptions/racego_exception.dart';
import '../../generated/l10n.dart';
import '../widgets/coloredbutton.dart';
import '../widgets/generaldialog.dart';
import '../widgets/loggedoutdialog.dart';
import '../widgets/racelist.dart';
import '../widgets/titlebar.dart';

class RaceManagementScreen extends StatefulWidget {
  const RaceManagementScreen({Key? key}) : super(key: key);

  @override
  State<RaceManagementScreen> createState() => _RaceManagementScreenState();
}

class _RaceManagementScreenState extends State<RaceManagementScreen> {
  final ListToolbarCubit _listToolbarCubit = ListToolbarCubit();
  late final RaceManageCubit _cubit;

  @override
  void initState() {
    _cubit = RaceManageCubit(context.read<RacegoApi>())..loadRaces();
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
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  width: 800,
                  child: Column(
                    children: [
                      TitleBar(
                        S.current.manage_your_races,
                        fontSize: 20,
                      ),
                      const SizedBox(height: 5),
                      BlocProvider(
                        create: (context) => _cubit,
                        child: _manager(),
                      ),
                      const SizedBox(height: 5),
                      _toolbar(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
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
        S.current.management,
      ),
      centerTitle: true,
    );
  }

  Widget _manager() {
    return Expanded(
      child: BlocBuilder<RaceManageCubit, RaceManageState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is RaceManageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RaceManageLoaded) {
            return RaceList(
              races: state.races,
              selectionChanged: (int selection, bool isSelected) {
                isSelected
                    ? _listToolbarCubit.selectionChanged(selection)
                    : _listToolbarCubit.userUnselected();
              },
              onDoubleTap: (id) {
                // TODO: implement onDoubleTap
                // Push RaceDetailScreen here...
              },
            );
          } else if (state is RaceManageError) {
            if (state.exception is AuthException) {
              context.read<LoginBloc>().add(Logout());
            }
            return Center(
              child: Text(state.exception.errorMessage),
            );
          }
          return Center(child: Text(S.current.unknown_error));
        },
      ),
    );
  }

  Widget _toolbar() {
    return BlocBuilder<RaceManageCubit, RaceManageState>(
      bloc: _cubit,
      builder: (context, raceState) {
        return BlocBuilder<ListToolbarCubit, ListToolbarState>(
          bloc: _listToolbarCubit,
          builder: (context, state) {
            // Get values
            int index = -1;
            bool isAdmin = false;
            if (raceState is RaceManageLoaded) {
              index = raceState.races.indexWhere(
                  (element) => element.id == _listToolbarCubit.getSelectedId());
            }
            bool disabled = index < 0 || raceState is! RaceManageLoaded;
            if (disabled == false && raceState is RaceManageLoaded) {
              isAdmin = raceState.races[index].isAdmin;
            }

            return AbsorbPointer(
              absorbing: disabled,
              child: Row(
                children: [
                  Expanded(
                    child: ColoredButton(
                      const Icon(Icons.info),
                      color: Colors.blue,
                      onPressed: () => Navigator.of(context)
                          .pushNamed('/user', arguments: state),
                      isDisabled: disabled,
                    ),
                  ),
                  Expanded(
                    child: ColoredButton(
                      const Icon(Icons.remove_circle),
                      color: Colors.red,
                      onPressed: () async {
                        // TODO: Add removing function and translation
                        if (await generalDialog(
                            context, 'Wirklich entfernen?', 'jallo')) {
                          return;
                        }
                      },
                      isDisabled: disabled || !isAdmin,
                    ),
                  ),
                  Expanded(
                    child: ColoredButton(
                      const Icon(Icons.check_circle),
                      color: Colors.green,
                      onPressed: () async {
                        await _cubit
                            .setRaceId(_listToolbarCubit.getSelectedId());
                        Navigator.of(context).pop();
                      },
                      isDisabled: disabled,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
