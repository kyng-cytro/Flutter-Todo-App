import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String btnText;
  final bool isloading;
  PrimaryButton({required this.btnText, required this.isloading});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFB40284A), borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: widget.isloading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Colors.white,
                ),
              )
            : Text(
                widget.btnText,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }
}
