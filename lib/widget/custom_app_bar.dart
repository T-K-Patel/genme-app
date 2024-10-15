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
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    bool isPortrait = orientation == Orientation.portrait;
    return Container(
      padding: isPortrait
          ? EdgeInsets.fromLTRB(screenWidth * 0.038, screenWidth * 0.036,
              screenWidth * 0.038, screenWidth * 0.03)
          : EdgeInsets.fromLTRB(screenWidth * 0.02, screenWidth * 0.02,
              screenWidth * 0.02, screenWidth * 0.02),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 18, 21, 114),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
              isPortrait ? screenWidth * 0.08 : screenWidth * 0.04),
          bottomRight: Radius.circular(
              isPortrait ? screenWidth * 0.08 : screenWidth * 0.04),
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
                  radius: isPortrait ? screenWidth * 0.05 : screenWidth * 0.02,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person, // Default human icon in Material Design
                    size: isPortrait ? screenWidth * 0.08 : screenWidth * 0.03,
                    color: Colors.grey[700], // Customize icon color
                  ),
                ),
              ),
              SizedBox(
                  width: isPortrait ? screenWidth * 0.045 : screenWidth * 0.01),
              Text(
                "genme",
                style: TextStyle(
                  fontSize:
                      isPortrait ? screenWidth * 0.075 : screenWidth * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          SizedBox(
              height: isPortrait ? screenWidth * 0.02 : screenWidth * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Hello",
                style: TextStyle(
                    fontSize:
                        isPortrait ? screenWidth * 0.06 : screenWidth * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(width: screenWidth * 0.02),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is AuthStateLoggedIn;
                },
                builder: (context, state) {
                  if (state is AuthStateLoggedIn) {
                    return Expanded(
                      child: Text(
                        '${state.user.legalName} !',
                        style: TextStyle(
                            fontSize: isPortrait
                                ? screenWidth * 0.06
                                : screenWidth * 0.025,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                        overflow:
                            TextOverflow.ellipsis, // Add ellipsis for overflow
                        maxLines: 1,
                      ),
                    );
                  }
                  return Text(
                    " User !",
                    style: TextStyle(
                        fontSize: isPortrait
                            ? screenWidth * 0.06
                            : screenWidth * 0.025,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  );
                },
              ),
            ],
          ),
          SizedBox(
              height: isPortrait ? screenWidth * 0.02 : screenWidth * 0.005),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    fontSize:
                        isPortrait ? screenWidth * 0.04 : screenWidth * 0.025,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ],
          ),
          if (widget.isHome == true) SizedBox(height: isPortrait ?  screenWidth * 0.025 : screenWidth * 0.01),
          //   Search Input field
          if (widget.isHome == true)
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      isPortrait ? screenWidth * 0.04 : screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
              ),
              child: TextField(
                onTap: () {
                  GoRouter.of(context).go('/search');
                },
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Search Medicine to Buy',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontSize:
                          isPortrait ? screenWidth * 0.04 : screenWidth * 0.02),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search_sharp,
                    color: Colors.grey,
                    size: isPortrait ? screenWidth * 0.06 : screenWidth * 0.03,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
