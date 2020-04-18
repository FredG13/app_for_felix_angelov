import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {

        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Login Page"),
            ),
            body: Container(
              child: Center(
                  child: RaisedButton(
                    child: Text("Home Page"),
                    onPressed: () {
                      authenticationBloc.add(AuthSuccess());
                    },
                  )),
            )
        )
    );
  }
}
