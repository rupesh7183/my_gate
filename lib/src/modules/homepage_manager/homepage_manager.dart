// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:mygate_app/src/globals.dart';

import 'package:mygate_app/src/modules/icons/icons.dart';

import 'package:mygate_app/src/modules/inbox_module/ui/notification.dart';
import 'package:mygate_app/src/modules/member_module/ui/user_data.dart';
import 'package:mygate_app/src/modules/post_module/ui/information.dart';
import 'package:mygate_app/src/modules/security_inbox/ui/homepage.dart';
import 'package:mygate_app/src/widgets/appbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePageManager extends StatefulWidget {
  const HomePageManager({Key? key}) : super(key: key);

  @override
  _HomePageManagerState createState() => _HomePageManagerState();
}

PageController _pageController = PageController();

class _HomePageManagerState extends State<HomePageManager> {
  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: Globals.type == 'Security' ? 0 : 1);
  }

  int currentIndex = Globals.type == 'Security' ? 0 : 1;

  // _bloc1.add(HomeNotificationData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppbarPage(),
      ),
      body: body(),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  body() {
    return PageView(
      onPageChanged: (page) {
        setState(() {
          currentIndex = page;
        });
      },
      controller: _pageController,
      children: <Widget>[
        Globals.type == 'Security' ? HomePage() : NotificationPage(cameras: [],),
        InformationPage(),
        UserDataPage(),
      ],
    );
    // if (currentIndex == 0) {
    // if (Globals.type == 'Security') {
    //   return HomePage();
    // } else {
    //   return InformationPage();
    // }
    // } else if (currentIndex == 1) {
    //   if (Globals.type == 'Security') {
    //     return InformationPage();
    //   } else {
    //     return NotificationPage();
    //   }
    // } else if (currentIndex == 2) {
    //   return UserDataPage();
    // } else if (currentIndex == 3) {
    //   return ProfilePage();
    // }
  }

  // Widget bottomNavigationPage() {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Colors.orange,
  //     selectedItemColor: Colors.white,
  //     unselectedItemColor: Colors.black,
  //     currentIndex: currentIndex,
  //     onTap: (value) {
  //       setState(() {
  //         currentIndex = value;
  //       });
  //     },
  //     items: [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         label: 'Home',
  //       ),
  //       // BottomNavigationBarItem(
  //       //   icon: Icon(Icons.notification_important_rounded),
  //       //   label: 'Notification',
  //       // ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.details),
  //         label: 'UserData',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.person),
  //         label: 'Profile',
  //       ),
  //     ],
  //   );
  // }

  Widget bottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            // color: Colors.black.withOpacity(.1),
            color: Colors.transparent,
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            tabBorderRadius: 15,
            backgroundColor: Colors.transparent,
            curve: Curves.ease,
            rippleColor: Colors.grey[300]!,
            // hoverColor: Colors.grey[100]!,
            gap: 10,

            activeColor: currentIndex == 1
                ? Colors.green
                : currentIndex == 2
                    ? Colors.blue
                    : Colors.red,
            iconSize: 28,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: currentIndex == 1
                ? Colors.green[100]!
                : currentIndex == 2
                    ? Colors.blue[100]!
                    : Colors.red[100]!,
            color: Colors.black,
            tabs: [
              GButton(
                icon: MyFlutterApp.inbox_ico,
                text: 'Inbox',
              ),
              GButton(
                icon: MyFlutterApp.home_ico,
                text: 'Home',
              ),
              GButton(
                icon: MyFlutterApp.members_ico,
                text: 'Members',
              ),
            ],
            selectedIndex: currentIndex,
            onTabChange: (index) {
              _onTappedBar(index);
              // setState(() {
              //   currentIndex = index;
              // });
            },
          ),
        ),
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      currentIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
