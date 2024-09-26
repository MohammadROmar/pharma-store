import 'package:flutter/material.dart';

import 'package:project/models/medicine.dart';

class Detail extends StatelessWidget {
  const Detail({
    super.key,
    required this.medicine,
    required this.icon,
    required this.name,
    required this.detail,
  });

  final Medicine medicine;
  final IconData icon;
  final String name;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary.withOpacity(.5),
              ),
              Text(
                ' $name: ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                ),
              ),
              const Spacer(),
              Text(
                detail,
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
