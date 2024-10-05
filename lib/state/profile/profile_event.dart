part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileEventInitialize extends ProfileEvent {
  const ProfileEventInitialize();
}

class ProfileEventGetData extends ProfileEvent {
  final UserProfile? currUser;
  const ProfileEventGetData({required this.currUser});
}

class ProfileEventRefreshData extends ProfileEvent {
  final UserProfile currUser;
  const ProfileEventRefreshData({required this.currUser});
}




