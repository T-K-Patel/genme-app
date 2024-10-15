import 'package:flutter/material.dart';

class GenmeAppBar extends StatelessWidget {
  const GenmeAppBar({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leadingWidth: 65,
      titleSpacing: 15,
      toolbarHeight: 75,
      leading: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              'https://portfolio-tkpatel.vercel.app/assets/AboutMeImage-aPbed6c7.jpg'),
        ),
      ),
      title: const Text('genme',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          )),
      backgroundColor: const Color.fromARGB(255, 18, 21, 114),
      actions: const [
        Icon(
          Icons.notifications,
          size: 35,
          color: Colors.white,
        ),
        Padding(padding: EdgeInsets.only(right: 10)),
      ],
    );
  }
}
