import 'package:flutter/material.dart';

class ProfileItem extends StatefulWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
    this.onChangeTheme,
  });

  final String title;
  final IconData icon;
  final Color? color;
  final void Function() onTap;
  final void Function(ThemeMode theme)? onChangeTheme;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(.5),
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
        child: Icon(
          widget.icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          color: widget.color == null
              ? Theme.of(context).colorScheme.primary
              : Colors.red,
          fontSize: 18,
        ),
      ),
      trailing: widget.onChangeTheme != null
          ? Switch(
              value: isDarkMode,
              onChanged: (isChecked) {
                setState(() {
                  isDarkMode = isChecked;
                  widget.onChangeTheme!(
                      isDarkMode ? ThemeMode.dark : ThemeMode.light);
                });
              },
            )
          : widget.color == null
              ? Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.tertiary.withOpacity(.6),
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                )
              : null,
      onTap: widget.onTap,
    );
  }
}
