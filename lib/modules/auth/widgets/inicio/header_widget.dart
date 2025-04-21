import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String userName;
  final String userInitial;
  final String? userPhotoUrl;
  final VoidCallback onMenuPressed;

  const HeaderWidget({
    required this.userName,
    required this.userInitial,
    this.userPhotoUrl,
    required this.onMenuPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onMenuPressed,
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Hola, $userName!",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue,
            backgroundImage:
                userPhotoUrl != null ? NetworkImage(userPhotoUrl!) : null,
            child:
                userPhotoUrl == null
                    ? Text(
                      userInitial,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    )
                    : null,
          ),
        ],
      ),
    );
  }
}
