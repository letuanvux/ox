import 'package:flutter/material.dart';
import 'package:ox/ui/auth/components/profile_info.dart';

import '../../configs/routes.dart';
import '../themes.dart';
import '../commons/app_background.dart';
import '../commons/app_logo.dart';
import 'components/profile_banner.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3, 
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                expandedHeight: 200,
                backgroundColor: Colors.transparent,
                leading: Builder(builder: (context) {
                  return IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black38),
                      onPressed: () => Navigator.of(context).pop());
                }),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.home, color: Colors.black38),
                    onPressed: () {
                      Navigator.pushNamed(context, VLTxRoutes.home);
                    },                    
                  ),
                ],
                flexibleSpace: const FlexibleSpaceBar(
                  background: ProfileBanner(),
                ),
                pinned: true,
              ),
              const SliverToBoxAdapter(
                child: ProfileInfo(),
              ),
            ];
          }, 
          body: Container(),
        ), 
      ),      
    );
  }
}