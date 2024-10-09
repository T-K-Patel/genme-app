import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:genme_app/models/user_profile.dart';
import 'package:genme_app/state/profile/profile_provider.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileProvider profileProvider) : super(const ProfileStateInitial()) {
    on<ProfileEventInitialize>((event, emit) async {
      emit(const ProfileStateLoading());
      try {
        final UserProfile userData = await profileProvider.getUserData();
        emit(ProfileStateDataFetched(userProfile: userData));
      } on Exception catch (e) {
        print('profileblocprovider$e');
        emit(ProfileStateError(exception: e));
      }
    });

    on<ProfileEventGetData>((event, emit) async {
      emit(const ProfileStateLoading());
      try {
        final UserProfile userData = await profileProvider.getUserData();
        emit(ProfileStateDataFetched(userProfile: userData));
      } on Exception catch (e) {
        emit(ProfileStateError(exception: e));
      }
    });

    on<ProfileEventRefreshData>((event, emit) async {
      emit(const ProfileStateLoading());
      try {
        final UserProfile userData = await profileProvider.getUserData();
        emit(ProfileStateDataRefreshed(userProfile: userData));
      } on Exception catch (e) {
        emit(ProfileStateError(exception: e));
      }
    });
  }
}
