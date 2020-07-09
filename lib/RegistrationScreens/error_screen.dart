import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'OOPS !!',
              style: TextStyle(
                color:  Colors.black,
                fontSize: 50.0,
              ),
            ),
            SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            Text(
              'Something Went Wrong.',
              style: TextStyle(
                color:  Colors.black,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
