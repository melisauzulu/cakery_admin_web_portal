import 'package:cakery_admin_web_portal/widgets/simple_app_bar.dart';
import 'package:flutter/material.dart';

class AllVerifiedUsersScreen extends StatefulWidget {
  const AllVerifiedUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllVerifiedUsersScreen> createState() => _AllVerifiedUsersScreenState();
}



class _AllVerifiedUsersScreenState extends State<AllVerifiedUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "All Activated User Accounts",),
    );
  }
}
