import 'package:rxdart/rxdart.dart';

import 'custom_auth_manager.dart';

class CtrbackupAuthUser {
  CtrbackupAuthUser({required this.loggedIn, this.uid});

  bool loggedIn;
  String? uid;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<CtrbackupAuthUser> ctrbackupAuthUserSubject =
    BehaviorSubject.seeded(CtrbackupAuthUser(loggedIn: false));
Stream<CtrbackupAuthUser> ctrbackupAuthUserStream() => ctrbackupAuthUserSubject
    .asBroadcastStream()
    .map((user) => currentUser = user);
