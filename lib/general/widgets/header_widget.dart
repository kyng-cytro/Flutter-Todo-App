import 'package:flutter/material.dart';
import 'package:todo_app/core/auth/functions/auth_state.dart';

Container headerWidget(BuildContext context, AuthState _state) => Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60.0),
            Text(
              "What's up, " + _state.user.name.split(" ")[0] + "!",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  wordSpacing: 1.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            Text(
              "YOUR TODO'S",
              style: TextStyle(
                color: Color(0xffbbc2d8),
                fontSize: 12.0,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
