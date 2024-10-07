part of 'profile_bloc.dart';

@immutable
abstract class ProfileState  {
  const ProfileState();
}

final class ProfileStateInitial extends ProfileState {
  const ProfileStateInitial();
}

final class ProfileStateLoading extends ProfileState {
 const ProfileStateLoading();
}

final class ProfileStateDataFetched extends ProfileState {
  final UserProfile userProfile;
  const ProfileStateDataFetched({required this.userProfile});
}

final class ProfileStateDataRefreshed extends ProfileState {
  final UserProfile userProfile;
  const ProfileStateDataRefreshed({required this.userProfile});
}

final class ProfileStateAuthError extends ProfileState{
  const ProfileStateAuthError();
}

final class ProfileStateError extends ProfileState {
  final Exception exception;
  const ProfileStateError({required this.exception});
}