import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TopSectionButton(iconData: Icons.menu),
          Text(
            "Employee Database",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          _TopSectionButton(iconData: Icons.notifications),
        ],
      ),
    );
  }
}

class _TopSectionButton extends StatelessWidget {
  const _TopSectionButton({
    required this.iconData,
  });

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}
