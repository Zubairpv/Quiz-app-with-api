import 'package:flutter/material.dart';

class option extends StatelessWidget {
  const option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
    required this.volor,
    required this.icon,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;
  final Color volor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(179, 240, 236, 236),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: volor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(color: volor, fontSize: 14),
            ),
            Container(
              height: 26,
              width: 26,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Icon(
                  icon,
                  color: volor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
