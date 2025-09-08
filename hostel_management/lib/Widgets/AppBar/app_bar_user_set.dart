import 'package:flutter/material.dart';

class AppBarUserSet extends StatelessWidget {
  const AppBarUserSet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 102,
          height: 32,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: 33,
                  height: 33,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 33,
                          height: 33,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.50, -0.00),
                              end: Alignment(0.50, 1.00),
                              colors: [
                                const Color(0xFF01ADD3),
                                const Color(0xFF00388F),
                              ],
                            ),
                            shape: OvalBorder(),
                          ),
                          child: Image.asset(
                            'assets/PlusMath.png',
                            width: 25.3,
                            height: 16.5,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 3.30,
                        top: 7.70,
                        child: Container(
                          width: 25.30,
                          height: 16.50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/25x16"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 0,
                child: SizedBox(
                  width: 80,
                  height: 32,
                  // decoration: ShapeDecoration(
                  //   color: Colors.black.withValues(alpha: 0),
                  //   shape: RoundedRectangleBorder(
                  //     side: BorderSide(color: const Color(0xFFE5E7EB)),
                  //   ),
                  // ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 33,
                          height: 33,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/33x33"),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2,
                                color: const Color(0xFFEEEEEE),
                              ),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/img.jpeg',
                              width: 33,
                              height: 33,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 24,
                        top: 0,
                        child: Container(
                          width: 33,
                          height: 33,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/33x33"),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2,
                                color: const Color(0xFFEEEEEE),
                              ),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/img.jpeg',
                              width: 33,
                              height: 33,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 48,
                        top: 0,
                        child: Container(
                          width: 33,
                          height: 33,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/33x33"),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2,
                                color: const Color(0xFFEEEEEE),
                              ),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/img.jpeg',
                              width: 33,
                              height: 33,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
