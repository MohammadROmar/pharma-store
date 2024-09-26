import 'package:flutter/material.dart';
import 'package:project/data/data.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:project/generated/l10n.dart';

import 'package:project/screens/profile.dart';
import 'package:project/screens/search.dart';
import 'package:project/screens/favorite.dart';
import 'package:project/screens/main.dart';
import 'package:project/models/medicine.dart';
import 'package:project/models/user.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    super.key,
    required this.onChangeLanguage,
    required this.user,
    required this.signedin,
    required this.onChangeTheme,
  });

  final User user;
  final void Function({required bool isSignedin, User user}) signedin;
  final void Function(String selectedLanguage) onChangeLanguage;
  final void Function(ThemeMode theme) onChangeTheme;

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;

  Widget get _currentScreen {
    return _currentIndex == 0
        ? MainScreen(user: widget.user)
        : _currentIndex == 1
            ? FavoriteScreen(onAddFavorite: onAddFavorite)
            : _currentIndex == 2
                ? SearchScreen(
                    onAddFavorite: onAddFavorite,
                  )
                : ProfileScreen(
                    user: widget.user,
                    signedin: widget.signedin,
                    onAddFavorite: onAddFavorite,
                    onChangeLanguage: widget.onChangeLanguage,
                    onChangeTheme: widget.onChangeTheme,
                  );
  }

  bool onAddFavorite(Medicine medicine) {
    final isFavorites = loadedFavorites.contains(medicine);

    if (isFavorites) {
      removeFav(medicine);
      return false;
    } else {
      addFav(medicine);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_currentIndex == 0){
      clearMeds();
      clearFavorite();
    }

    return Scaffold(
      body: _currentScreen,
      bottomNavigationBar: SalomonBottomBar(
        margin: const EdgeInsets.all(16.0),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            unselectedColor: Theme.of(context).colorScheme.primary,
            selectedColor: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.home),
            title: Text(
              S.of(context).home,
            ),
          ),
          SalomonBottomBarItem(
            unselectedColor: Theme.of(context).colorScheme.primary,
            selectedColor: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.bookmark),
            title: Text(
              S.of(context).saved,
            ),
          ),
          SalomonBottomBarItem(
            unselectedColor: Theme.of(context).colorScheme.primary,
            selectedColor: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.search),
            title: Text(
              S.of(context).search,
            ),
          ),
          SalomonBottomBarItem(
            unselectedColor: Theme.of(context).colorScheme.primary,
            selectedColor: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.person),
            title: Text(
              S.of(context).profile,
            ),
          ),
        ],
      ),
    );
  }
}
