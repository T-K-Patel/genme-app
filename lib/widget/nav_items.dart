import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItem extends StatelessWidget {
  const NavItem({super.key, required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF334790) : const Color(0xFFAFB6BE);

    String smallCase = label.toLowerCase();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Container(
        //   width: double.infinity,
        //   height: 12,
        //   color: Colors.orange,
        //   margin: EdgeInsets.only(bottom: 0),
        //
        //
        // ),
        SizedBox(
          width: double.infinity,
          height: 2.0,
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
          child: Container(
            child: SizedBox(
              width: double.infinity,
              height: 68,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/icons/$smallCase.svg',
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                    height: 25,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    label,
                    style: TextStyle(color: color),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
