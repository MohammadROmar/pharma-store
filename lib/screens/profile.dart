import 'package:flutter/material.dart';
import 'package:project/auth/auth.dart';
import 'package:project/data/data.dart';
import 'package:project/generated/l10n.dart';
import 'package:project/models/medicine.dart';
import 'package:http/http.dart' as http;

import 'package:project/models/user.dart';
import 'package:project/screens/choose_language.dart';
import 'package:project/screens/orders.dart';
import 'package:project/widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.signedin,
    required this.onChangeLanguage,
    required this.user,
    required this.onChangeTheme,
    required this.onAddFavorite,
  });

  final User user;
  final void Function({required bool isSignedin, User user}) signedin;
  final void Function(String selectedLanguage) onChangeLanguage;
  final bool Function(Medicine medicine) onAddFavorite;
  final void Function(ThemeMode theme) onChangeTheme;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //final url = Uri.parse('http://127.0.0.1:8000/api/logout');
  final url = Uri.parse('http://192.168.43.246:8000/api/logout');

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PharmaStore'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(.5),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.user.name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              widget.user.phoneNum,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            ProfileItem(
              title: S.of(context).theme,
              icon: Icons.nights_stay,
              onChangeTheme: widget.onChangeTheme,
              onTap: () {
                setState(() {
                  widget.onChangeTheme(
                      isDarkMode ? ThemeMode.light : ThemeMode.dark);
                });
              },
            ),
            const SizedBox(height: 2),
            ProfileItem(
              title: S.of(context).language,
              icon: Icons.language,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChooseLanguageScreen(
                        onChangeLanguage: widget.onChangeLanguage),
                  ),
                );
              },
            ),
            const SizedBox(height: 2),
            ProfileItem(
              title: S.of(context).orders,
              icon: Icons.delivery_dining,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrdersScreen(
                      onAddFavorite: widget.onAddFavorite,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            ProfileItem(
              title: S.of(context).logOut,
              icon: Icons.logout_sharp,
              color: Colors.red,
              onTap: () async {
                final response = await http.post(url, headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer ${Auth.token}'
                });
                print(response.statusCode);
                setState(() {
                  Auth.setToken(null);
                  clearMeds();
                  widget.signedin(isSignedin: false);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
