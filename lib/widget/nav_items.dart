import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItem extends StatelessWidget {
  const NavItem(
      {super.key,
      required this.label,
      required this.selected,
      required this.onTap});

  final String label;
  final bool selected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF334790) : const Color(0xFFAFB6BE);

    String smallCase = label.toLowerCase();
    double screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    bool isPortrait = orientation == Orientation.portrait;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: double.infinity,
          height: isPortrait ?  screenWidth* 0.006 : screenWidth * 0.003 ,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF334790) : Colors.transparent,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(55),
          onLongPress: () {},
          onTap: () {
            onTap();
          },
          splashColor: const Color.fromARGB(255, 208, 206, 198),
          child: SizedBox(
            width: double.infinity,
            height: isPortrait? screenWidth * 0.17 : screenWidth * 0.06 ,
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/$smallCase.svg',
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                height: isPortrait ?  screenWidth * 0.07 : screenWidth * 0.023 , // Make SVG height responsive
              ),
            ),
          ),
        ),
      ],
    );
  }
}