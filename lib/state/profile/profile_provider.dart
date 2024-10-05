import 'package:genme_app/models/user_profile.dart';

class ProfileProvider{
// Fetch user data
  Future<UserProfile> getUserData() async {
    // Fetch user data from api with auth headers
    return UserProfile.fromJson({});
  }

  Future<void> refreshAccessToken() async {
    // Refresh access token

  }
}