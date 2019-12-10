import 'package:dingn/blocs/number/bloc.dart';
import 'package:dingn/blocs/register/register_bloc.dart';
import 'package:dingn/repository/number_repository.dart';
import 'package:dingn/repository/word_repository.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dingn/ui/app/app.dart';

import 'package:dingn/repository/user_repository.dart';
import 'package:dingn/themes.dart';
import 'package:dingn/blocs/bloc.dart';
import 'package:dingn/blocs/simple_bloc_delegate.dart';

void main() {
  assert(() {
    fb.initializeApp(
      apiKey: 'AIzaSyDzWk1JfjsMi9o_yPBz69XSQmWBXfC8dWs',
      authDomain: 'dingn.com',
      databaseURL: 'https://dingn-193716.firebaseio.com',
      projectId: 'dingn-193716',
      storageBucket: 'dingn-193716.appspot.com',
      messagingSenderId: '211238433635'
    );
    BlocSupervisor.delegate = SimpleBlocDelegate();
    return true;
  }());

  runApp(AppProviders());
}

class AppProviders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    final numberRepository = NumberRepository(userRepository);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(builder: (context) {
          return AuthenticationBloc(userRepository);
        }),
        BlocProvider<LoginBloc>(builder: (context) {
          return LoginBloc(userRepository: userRepository);
        }),
        BlocProvider<RegisterBloc>(builder: (context) {
          return RegisterBloc(userRepository: userRepository);
        }),
        BlocProvider<NumberBloc>(
          builder: (context) {
            return NumberBloc(
              repository: numberRepository
            );
          },
        ),
        BlocProvider<NumberDetailBloc>(
          builder: (context) {
            return NumberDetailBloc(
              repository: numberRepository,
              userRepository: userRepository,
              wordRepository: WordRepository(),
            );
          },
        ),
        BlocProvider<PageBloc>(
          builder: (context) {
            return PageBloc();
          },
        )
      ],
      child: MaterialApp(
        title: 'dingn - mind improvement',
        theme: AppTheme.theme(),
        debugShowCheckedModeBanner: false,
        home: const App(),
      ),
    );
  }
}
