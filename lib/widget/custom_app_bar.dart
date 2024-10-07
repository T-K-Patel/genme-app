import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/state/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatefulWidget {
  final bool isHome;
  final String title;
  const CustomAppBar(
      {super.key, this.title = "Add Items to your cart", this.isHome = false});

  @override
  State<CustomAppBar> createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 18, 21, 114),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).go('/profile');
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person, // Default human icon in Material Design
                    size: 30,
                    color: Colors.grey[700], // Customize icon color
                  ),
                  // backgroundImage: NetworkImage(
                  //   "https://imgv3.fotor.com/images/slider-image/A-clear-image-of-a-woman-wearing-red-sharpened-by-Fotors-image-sharpener.jpg",
                  //   scale: 1,
                  // )
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 20)),
              const Text(
                "genme",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Hello",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is AuthStateLoggedIn;
                },
                builder: (context, state) {
                  if (state is AuthStateLoggedIn) {
                    return Text(
                      '${state.user.legalName} !',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    );
                  }
                  return const Text(
                    " User !",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  );
                },
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ],
          ),
          if (widget.isHome == true)
            const Padding(padding: EdgeInsets.only(top: 10)),
          //   Search Input field
          if (widget.isHome == true)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onTap: () {
                  GoRouter.of(context).go('/search');
                },
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Search Medicine to Buy',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search_sharp,
                    color: Colors.grey,
                    size: 24,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
