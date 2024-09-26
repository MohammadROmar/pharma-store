import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    this.leading,
    this.title,
    this.subTitle,
    required this.onTap,
    this.trailing,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final Widget? trailing;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary.withOpacity(.6),
        borderRadius: BorderRadius.circular(
          100,
        ),
      ),
      child: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );

    if (trailing != null) {
      content = trailing!;
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary.withOpacity(.4),
          Theme.of(context).colorScheme.primary.withOpacity(.1),
        ]),
      ),
      child: ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          leading: leading,
          title: title,
          subtitle: subTitle,
          trailing: content,
          onTap: onTap),
    );
  }
}
