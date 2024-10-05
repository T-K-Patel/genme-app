import 'package:bloc/bloc.dart';
import 'package:genme_app/models/user_profile.dart';
import 'package:genme_app/state/auth/auth_provider.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider authProvider) : super(const AuthStateUninitialized()) {
    on<AuthEventCheck>((event, emit) async  {
      // TODO: implement event handler
      try {
        // Check if user is logged in
        // If logged in, emit AuthStateLoggedIn
        // If not logged in, emit AuthStateLoggedOut
        await Future.delayed(const Duration(seconds: 2), () {
          emit(
            AuthStateLoggedIn(
              user: UserProfile.fromJson({
                'legal_name': "Kapadi Tirth",
                'gstin': "24AABCU9603R1ZV",
                'dl_no': "GJ01-2021-2022-0001",
                'pan_number': "AABCU9603R",
                'address': "B-1, 2nd Floor, Shreeji Complex, Opp. GEB, Gotri Road, Vadodara, Gujarat, India - 390021",
                'date_joined': '2021-01-01',
                'role': 'retailer',
              }),
            ),
          );
        });
      } on Exception catch (e) {
        emit(AuthStateError(exception: e));
      }
    });
  }
}
