import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:jagvault/constants/constants.dart';
import 'package:jagvault/screens/home_screen/home_screen.dart';
import 'package:jagvault/screens/letters/letters_screen.dart';
import 'package:jagvault/services/auth_service.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1; // Indice actual para la pestaña seleccionada

  // IndexedStack para mantener el estado de las pantallas
  final List<Widget> _children = [
    const HomeScreen(),
    const LettersScreen(),
    const MemoriesScreen(),
    const TodosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _children,
          ),
          // bottomNavigationBar: Nav,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
              bottom: true,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: kBlueChalk, width: .8),
                    borderRadius: BorderRadius.circular(100)),
                width: size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GNav(
                      rippleColor:
                          kBlueBell, // tab button ripple color when pressed
                      hoverColor: kBackgroundColor, // tab button hover color
                      haptic: true, // haptic feedback
                      tabBorderRadius: 100,
                      tabActiveBorder: Border.all(
                          color: kBlueChalk, width: 1), // tab button border
                      tabBorder: Border.all(
                          color: kBlueChalk, width: 1), // tab button border
                      curve: Curves.ease, // tab animation curves
                      duration: const Duration(
                          milliseconds: 300), // tab animation duration
                      gap: 8, // the tab button gap between icon and text
                      color: kBlueChalk,
                      // unselected icon color
                      activeColor: Colors.black, // selected icon and text color
                      iconSize: 20, // tab button icon size

                      tabBackgroundColor:
                          kBlueChalk, // selected tab background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10), // navigation bar padding
                      onTabChange: ((value) {
                        if (value == 2) {
                          Provider.of<AuthenticationService>(context,
                                  listen: false)
                              .signOut();
                          Navigator.of(context).pushReplacementNamed('/login');
                        }
                        setState(() {
                          _currentIndex = value;
                        });
                      }),
                      tabs: const [
                        GButton(
                          icon: Iconsax.home,
                        ),
                        GButton(
                          icon: Iconsax.sms,
                        ),
                        GButton(
                          icon: Iconsax.search_favorite,
                        ),
                        GButton(
                          icon: Iconsax.user,
                        )
                      ]),
                ),
              )),
        )
      ],
    );
  }
}

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Memories Screen'));
  }
}

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('To-dos Screen'));
  }
}
