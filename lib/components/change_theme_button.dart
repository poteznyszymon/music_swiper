import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        Provider.of<ThemeProvider>(context, listen: false).changeTheme();
      },
      style: FilledButton.styleFrom(
        minimumSize: Size(
          MediaQuery.of(context).size.height / 15,
          MediaQuery.of(context).size.height / 15,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Icon(
        Icons.sunny,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
