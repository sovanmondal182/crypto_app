import 'package:crypto_app/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GreetingText extends StatefulWidget {
  const GreetingText({super.key});

  @override
  State<GreetingText> createState() => _GreetingTextState();
}

class _GreetingTextState extends State<GreetingText> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context, listen: false);
    DateTime now = DateTime.now();
    String greeting = now.hour < 12
        ? 'Good Morning'
        : now.hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Hi,',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                theme.toggleTheme();
              },
              child:
                  // (theme.themeMode == ThemeMode.dark)
                  //     ? const Icon(CupertinoIcons.sun_min_fill, size: 30)
                  //     : const Icon(CupertinoIcons.moon_stars_fill, size: 30),
                  IconButton(
                icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, anim) => RotationTransition(
                          turns: child.key == const ValueKey('icon1')
                              ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                              : Tween<double>(begin: 0.75, end: 1)
                                  .animate(anim),
                          child: FadeTransition(opacity: anim, child: child),
                        ),
                    child: (theme.themeMode == ThemeMode.dark)
                        ? const Icon(CupertinoIcons.sun_min_fill,
                            size: 30, key: ValueKey('icon1'))
                        : const Icon(
                            CupertinoIcons.moon_stars_fill,
                            size: 30,
                            key: ValueKey('icon2'),
                          )),
                onPressed: () {
                  theme.toggleTheme();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          greeting,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
