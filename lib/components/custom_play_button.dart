import 'package:flutter/material.dart';

class CustomPlayButton extends StatelessWidget {
  final Icon icon;
  final void Function()? onTap;
  const CustomPlayButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        minimumSize: Size(
          MediaQuery.of(context).size.height / 15,
          MediaQuery.of(context).size.height / 15,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: const CircleBorder(),
      ),
      child: icon,
    );
  }
}
