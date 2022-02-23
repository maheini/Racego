import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/business_logic/userlist_cubit/userlist_cubit.dart'
    as listcubit;
import 'package:racego/business_logic/tracklist_cubit/tracklist_cubit.dart'
    as trackcubit;
import 'package:racego/data/api/racego_api.dart';
import 'package:racego/data/locator/locator.dart';
import 'package:racego/data/models/user.dart';
import 'package:racego/ui/widgets/user_list.dart';
import 'package:racego/ui/widgets/timeinput.dart';
import 'package:racego/business_logic/listtoolbar/listtoolbar_cubit.dart';
import 'package:racego/ui/widgets/coloredbutton.dart';

import '../widgets/loggedoutdialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ListToolbarCubit _userToolsCubit = ListToolbarCubit();
  final ListToolbarCubit _trackToolsCubit = ListToolbarCubit();

  final listcubit.UserlistCubit _userlistCubit =
      listcubit.UserlistCubit(locator<RacegoApi>());
  final trackcubit.TracklistCubit _tracklistCubit =
      trackcubit.TracklistCubit(locator<RacegoApi>());

  bool _forcedLogout = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: ((context, state) async {
        if (state is LoggedOut || state is LoginError) {
          if (_forcedLogout) {
            Navigator.pushReplacementNamed(context, '/');
          } else {
            await loggedOutDialog(context);
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/');
            });
          }
        }
      }),
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
      backgroundColor: const Color.fromARGB(255, 175, 0, 6),
      title: const Text(
        'Racego',
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
          ),
          onPressed: () async {
            _forcedLogout = true;
            context.read<LoginBloc>().add(Logout());
          },
        )
      ],
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'Willkommen zurück',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 20),
                Expanded(child: _userList()),
                const SizedBox(width: 30),
                Expanded(child: _trackList()),
                const SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // _userToolBar(),
        ],
      ),
    );
  }

  Widget _userList() {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => _userlistCubit.reload(), child: Text('reload')),
        Expanded(
          child: BlocBuilder<listcubit.UserlistCubit, listcubit.UserlistState>(
            bloc: _userlistCubit,
            builder: (context, state) {
              if (state is listcubit.Loaded) {
                return UserList(
                  state.list,
                  searchChanged: (text) => _userlistCubit.setFilter(text),
                  title: 'Teilnehmer',
                  onSelectionChanged: (index, userID, isSelected) {
                    isSelected
                        ? _userToolsCubit.selectionChanged(userID)
                        : _userToolsCubit.userUnselected();
                  },
                  onDoubleTap: (index, userID) => Navigator.of(context)
                      .pushNamed('/user', arguments: userID),
                  onAddPressed: (searchtest) =>
                      Navigator.of(context).pushNamed('/user'),
                );
              } else {
                // TODO: implement error-message and reloading indicator
                List<User> newList = [];
                if (state is listcubit.Loading) {
                  newList = state.previousList;
                } else if (state is listcubit.Error) {
                  newList = state.previousList;
                }
                return UserList(
                  newList,
                  searchChanged: (text) => _userlistCubit.setFilter(text),
                  title: 'Teilnehmer',
                  onSelectionChanged: (index, userID, isSelected) {
                    isSelected
                        ? _userToolsCubit.selectionChanged(userID)
                        : _userToolsCubit.userUnselected();
                  },
                  onDoubleTap: (index, userID) => Navigator.of(context)
                      .pushNamed('/user', arguments: userID),
                  onAddPressed: (searchtest) =>
                      Navigator.of(context).pushNamed('/user'),
                );
              }
            },
          ),
        ),
        BlocBuilder<ListToolbarCubit, ListToolbarState>(
          bloc: _userToolsCubit,
          builder: (context, state) {
            bool disabled = true;
            if (state is UserSelected) disabled = false;
            return AbsorbPointer(
              absorbing: disabled,
              child: Row(
                children: [
                  Expanded(
                    child: ColoredButton(
                      const Icon(Icons.info),
                      color: Colors.blue,
                      onPressed: () => Navigator.of(context).pushNamed('/user',
                          arguments: _userToolsCubit.getSelectedId()),
                      isDisabled: disabled,
                    ),
                  ),
                  Expanded(
                    child: ColoredButton(
                      const Icon(Icons.remove_circle),
                      color: Colors.red,
                      onPressed: () => _userlistCubit
                          .removeUser(_userToolsCubit.getSelectedId()),
                      isDisabled: disabled,
                    ),
                  ),
                  Expanded(
                    child: ColoredButton(
                      const Icon(Icons.assistant_photo),
                      color: Colors.green,
                      onPressed: () => _userlistCubit
                          .addToTrack(_userToolsCubit.getSelectedId()),
                      isDisabled: disabled,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _trackList() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _tracklistCubit.reload(),
          child: Text('reload'),
        ),
        Expanded(
          child:
              BlocBuilder<trackcubit.TracklistCubit, trackcubit.TracklistState>(
            bloc: _tracklistCubit,
            builder: (context, state) {
              if (state is trackcubit.Loaded) {
                return UserList(
                  state.list,
                  searchChanged: (text) => _tracklistCubit.setFilter(text),
                  title: 'Rennstrecke',
                  onSelectionChanged: (index, userID, isSelected) {
                    isSelected
                        ? _trackToolsCubit.selectionChanged(userID)
                        : _trackToolsCubit.userUnselected();
                  },
                  onDoubleTap: (index, userID) => Navigator.of(context)
                      .pushNamed('/user', arguments: userID),
                );
              } else {
                // TODO: implement error-message and reloading indicator
                List<User> newList = [];
                if (state is trackcubit.Loading) {
                  newList = state.previousList;
                } else if (state is trackcubit.Error) {
                  newList = state.previousList;
                }
                return UserList(
                  newList,
                  searchChanged: (text) => _tracklistCubit.setFilter(text),
                  title: 'Rennstrecke',
                  onSelectionChanged: (index, userID, isSelected) {
                    isSelected
                        ? _trackToolsCubit.selectionChanged(userID)
                        : _trackToolsCubit.userUnselected();
                  },
                  onDoubleTap: (index, userID) => Navigator.of(context)
                      .pushNamed('/user', arguments: userID),
                );
              }
            },
          ),
        ),
        BlocBuilder<ListToolbarCubit, ListToolbarState>(
          bloc: _trackToolsCubit,
          builder: (context, state) {
            bool disabled = true;
            bool validTime = false;
            bool userHasChanged = false;

            if (state is UserSelected) {
              disabled = false;
              validTime = state.isValidLaptime;
              userHasChanged = state.userHasChanged;
            }
            return AbsorbPointer(
              absorbing: disabled,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TimeInput(
                      reset: userHasChanged | disabled ? true : false,
                      onChanged: (time) =>
                          _trackToolsCubit.lapTimeChanged(time),
                    ),
                  ),
                  Expanded(
                    child: ColoredButton(
                      const Icon(Icons.access_alarm),
                      color: Colors.green,
                      onPressed: !validTime
                          ? null
                          : () => _tracklistCubit.finishLap(
                              _trackToolsCubit.getSelectedId(),
                              _trackToolsCubit.getCurrentTime()),
                      isDisabled: disabled || !validTime,
                    ),
                  ),
                  Expanded(
                    child: ColoredButton(
                      const Icon(Icons.dangerous),
                      color: Colors.red,
                      onPressed: () => _tracklistCubit
                          .cancelLap(_trackToolsCubit.getSelectedId()),
                      isDisabled: disabled,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
