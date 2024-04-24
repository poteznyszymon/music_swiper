import 'package:flutter/material.dart';

class ProfileImageTile extends StatelessWidget {
  const ProfileImageTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      width: (MediaQuery.of(context).size.height / 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Icon(Icons.person),
      ),
    );
  }
}
