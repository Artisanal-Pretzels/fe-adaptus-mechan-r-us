import 'package:fe_adaptus_mechan_r_us/screens/authentication/user-authentication.dart';
import 'package:fe_adaptus_mechan_r_us/screens/home/userHome.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // return Authenticate widget or userHome widget depepending on login status
    return UserAuthenticate();
  }
}
