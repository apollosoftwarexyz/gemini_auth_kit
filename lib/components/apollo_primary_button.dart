import 'package:flutter/material.dart';

class ApolloPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ApolloPrimaryButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12.5, horizontal: 25)),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF8147ff)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontFamily: "Jost", fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
