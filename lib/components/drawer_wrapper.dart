import 'package:flutter/material.dart';
import 'package:genme_app/routes/router.dart';
import 'package:go_router/go_router.dart';

import 'package:genme_app/widget/nav_items.dart'; // Import flutter_svg package

void Function()? goBackToDash;

class DrawerWrapper extends StatefulWidget {
  const DrawerWrapper(
      {super.key, required this.child, required this.routerState});

  final Widget child;
  final GoRouterState routerState;

  @override
  State<DrawerWrapper> createState() => _DrawerWrapperState();
}

class _DrawerWrapperState extends State<DrawerWrapper> {
  int sideDrawerItemIndex = 0;

  void onTapSideDrawerItem(int idx) {
    setState(() {
      sideDrawerItemIndex = idx;
    });
  }

  final List<String> navItems = const [
    'Home',
    'Search',
    'Cart',
    'Orders',
    // 'Profile',
  ];
  void onClick(index, context, currIdx) {
    if (index == 0) {
      GoRouter.of(context).go('/');
    } else if (index == 1) {
      GoRouter.of(context).go('/search');
    } else if (index == 2) {
      GoRouter.of(context).go('/cart');
    } else if (index == 3) {
      GoRouter.of(context).go('/orders');
      // } else if (index == 4) {
      //   GoRouter.of(context).go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    var homeCurrIdx = 0;
    final String path = widget.routerState.fullPath ?? '/';
    bool hideBottomNav = path.contains('/profile') ||
        path.contains('/orders/') ||
        path.contains('/orderdetail');
    final firstRoute = path.split('/')[1];

    switch (firstRoute) {
      case 'search':
        homeCurrIdx = 1;
        break;
      case 'cart':
        homeCurrIdx = 2;
        break;
      case 'orders':
        homeCurrIdx = 3;
        break;
      // case 'profile':
      //   homeCurrIdx = 4;
      //   break;
    }
    double screenWidth = MediaQuery.of(context).size.width;
    // double screen = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    bool isPortrait = orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color.fromARGB(255, 18, 21, 114),
      ),
      key: drawerKey,
      body: widget.child,
      bottomNavigationBar: hideBottomNav
          ? null
          : NavigationBar(
              height: isPortrait ?  screenWidth * 0.18 : screenWidth * 0.07,
              indicatorShape: const CircleBorder(eccentricity: 1),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              selectedIndex: homeCurrIdx,
              destinations: navItems.asMap().entries.map(
                (entry) {
                  return NavigationDestination(
                    icon: NavItem(
                      label: entry.value,
                      selected: entry.key == homeCurrIdx,
                      onTap: () => onClick(entry.key, context, homeCurrIdx),
                    ),
                    label: entry.value,
                    tooltip: '',
                  );
                },
              ).toList(),
            ),
    );
  }
}
