import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/body.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 400,
            height: 800,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          Center(child: WebsafeSvg.asset('assets/icons/bg.svg')),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's Play Quiz",
                  style: GoogleFonts.poppins(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 81, 205, 100)),
                ),
                Text(
                  "“Cheating on a quiz show? That's sort of like plagiarizing\n a comic strip.”",
                  style: GoogleFonts.kanit(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Body()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                          gradient: const LinearGradient(
                            colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )),
                      child: Text(
                        "Let's Start",
                        style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
