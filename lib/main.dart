import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/authentication.dart';
import 'ui/home/home_page.dart';
import 'ui/login/login_page.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("Transition : $transition");
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print("Error : $error\n${stacktrace.toString()}");
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc()..add(AppStart());
      },
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        home: _getStartPage(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/login":
              return MyCustomRoute<void>(builder: (context) => settings.arguments as Widget, settings: settings, transitionMilliseconds: 4000);
            case "/home":
              return MyCustomRoute<void>(builder: (context) => HomePage(), settings: settings);
            default:
              return null;
          }
        }
    );
  }

  Widget _getStartPage() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationInit) {

          // ************* IT DOESN'T WORK when you click on the Logout button on the LoginPage !!!
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _navigator.pushNamedAndRemoveUntil("/login", (route) => false, arguments: LoginPage());
            return;
          });

          // return LoginPage(); // ---> IT WORKS !!!
        }
        if (state is AuthenticationOk) {
          return HomePage();
        }
        return HomePage();
      },
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  final int transitionMilliseconds;

  MyCustomRoute({WidgetBuilder builder, RouteSettings settings, this.transitionMilliseconds = 500}) : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => Duration(milliseconds: transitionMilliseconds);
}
