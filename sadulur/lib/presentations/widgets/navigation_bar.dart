import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/assessment.dart';
import 'package:sadulur/presentations/edit_store_detail.dart';
import 'package:sadulur/presentations/event/event_page.dart';
import 'package:sadulur/presentations/event/event_detail_page.dart';
import 'package:sadulur/presentations/event/event_form_page.dart';
import 'package:sadulur/presentations/forum.dart';
import 'package:sadulur/presentations/coaching/coaching_page.dart';
import 'package:sadulur/presentations/home/home_page.dart';
import 'package:sadulur/presentations/store_detail.dart';
import 'package:sadulur/presentations/widgets/forum/new_post_editor.dart';

class BottomNavigation extends StatefulWidget {
  final BuildContext menuScreenContext;
  final UMKMUser user;
  const BottomNavigation(
      {Key? key, required this.menuScreenContext, required this.user})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  getRoutes(BuildContext context) {
    return {
      "/store/edit": (final context) => const EditStoreDetailPage(),
      "/store/assessment": (final context) => const AssessmentUMKMPage(),
      '/event/add': (final context) => const EventFormPage(),
    };
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      // EntrepreneurialAssessmentPage(),
      const EventPage(title: "Events"),
      const ForumPage(title: "Networking"),
      const CoachingPage(title: "Coaching Meeting"),
      StoreDetailPage(id: widget.user.id)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: AppColor.darkDatalab,
        inactiveColorPrimary: AppColor.darkGrey,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //     initialRoute: '/',
        //     onGenerateRoute: (RouteSettings settings) {
        //       if (settings.name == '/store') {
        //         // return MaterialPageRoute(
        //         //     builder: (context) => StoreDetailPage(id: arg['id']));
        //         _controller.jumpToTab(4);
        //       } else if (settings.name == '/store/edit') {
        //         return MaterialPageRoute(
        //             builder: (context) => const EditStoreDetailPage());
        //       } else if (settings.name == '/store/assessment') {
        //         return MaterialPageRoute(
        //             builder: (context) => const AssessmentUMKMPage());
        //       }
        //     })
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: getRoutes(context),
          onGenerateRoute: (settings) {
            var arg = settings.arguments as Map;
            if (settings.name == "/store") {
              return MaterialPageRoute(
                  builder: (context) => StoreDetailPage(id: arg['id']));
            }
          },
        ),
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.event),
          title: "Event",
          activeColorPrimary: AppColor.darkDatalab,
          inactiveColorPrimary: AppColor.darkGrey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: '/event',
              routes: getRoutes(context),
              onGenerateRoute: (RouteSettings settings) {
                var arg = settings.arguments as Map;
                if (settings.name == '/event/detail') {
                  return MaterialPageRoute(
                      builder: (context) =>
                          EventDetailPage(event: arg['event']));
                }
                return MaterialPageRoute(
                    builder: (context) => const EventFormPage());
              })),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.forum),
          title: "Forum",
          activeColorPrimary: AppColor.darkDatalab,
          inactiveColorPrimary: AppColor.darkGrey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: '/forum',
              onGenerateRoute: (RouteSettings settings) {
                if (settings.name == '/forum/create') {
                  return MaterialPageRoute(
                      builder: (context) => const NewForumEditor());
                } else if (settings.name == '/forum') {
                  return MaterialPageRoute(
                    builder: (context) => const ForumPage(title: "Networking"),
                  );
                }
              })),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.video_call),
          title: "Coaching",
          activeColorPrimary: AppColor.darkDatalab,
          inactiveColorPrimary: AppColor.darkGrey,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(initialRoute: '/coaching')),
      PersistentBottomNavBarItem(
          icon: Icon(MdiIcons.faceManProfile),
          title: "Profile",
          activeColorPrimary: AppColor.darkDatalab,
          inactiveColorPrimary: AppColor.darkGrey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: '/profile',
              onGenerateRoute: (RouteSettings settings) {
                var arg = settings.arguments as Map;
                logger.d(settings.name);
                if (settings.name == '/store') {
                  return MaterialPageRoute(
                      builder: (context) => StoreDetailPage(id: arg['id']));
                } else if (settings.name == '/store/edit') {
                  return MaterialPageRoute(
                      builder: (context) => const EditStoreDetailPage());
                } else if (settings.name == '/store/assessment') {
                  return MaterialPageRoute(
                      builder: (context) => const AssessmentUMKMPage());
                }
              })),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 64,
      hideNavigationBarWhenKeyboardShows: true,
      margin: EdgeInsets.only(
          left: screenWidth * 0.01, right: screenWidth * 0.01, bottom: 5.0),
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0.0,
      hideNavigationBar: _hideNavBar,
      decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 6))
          ]),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style13, // Choose the nav bar style with this property
    );
  }
}
