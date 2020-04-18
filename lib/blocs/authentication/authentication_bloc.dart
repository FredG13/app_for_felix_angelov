
import 'package:bloc/bloc.dart';
import 'authentication.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {

    if (event is AppStart) {
      yield AuthenticationInit();
    }

    if (event is AuthSuccess) {
      // ***************** IT DOESN'T WORK !!! *****************
      yield AuthenticationOk();
    }

    if (event is LogOut) {
      yield AuthenticationInit();
    }

  }

  @override
  AuthenticationState get initialState => AuthenticationInit();
}
