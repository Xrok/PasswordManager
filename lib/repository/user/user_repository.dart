import 'package:password_manager/repository/user/user_provider.dart';

class UserRepository {
  final UserProvider _userProvider;

  UserRepository({UserProvider? userProvider})
      : _userProvider = userProvider ?? UserProvider();
}
