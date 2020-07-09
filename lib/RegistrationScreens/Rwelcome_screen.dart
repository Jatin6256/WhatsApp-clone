import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsappclone/RegistrationScreens/RregistrationScreen.dart';
import 'package:whatsappclone/RegistrationScreens/error_screen.dart';
import 'package:provider/provider.dart';
import 'show_error.dart';
class RwelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height:  50.0,
            ),
            Text(
              'Welcome To WhatsAppClone',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 100.0,
              width: double.infinity,
            ),
            CircleAvatar(
              child: Image.asset('images/flutter_icon.png'),
              radius: 100.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
                'Made With Flutter',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
//            Container(
//              margin: EdgeInsets.all(10.0),
//              child: Text(
//                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Services',
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                  color: Colors.black,
//                  fontSize: 15.0,
//                ),
//              ),
//            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
                  text: 'Read our',
                  ),
                  TextSpan(
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15.0,
                    ),
                    text: ' Policy.',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = 'https://www.whatsapp.com/privacy';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                          );
                        }
                        else
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ErrorScreen()));
                      },
                  ),
                  TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                    text: 'Tap "Agree and continue" to accept the ',
                  ),
                  TextSpan(
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15.0,
                    ),
                    text: 'Terms of services.',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = 'https://www.whatsapp.com/legal?doc=terms-of-service&version=20120707';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                          );
                        }
                        else
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ErrorScreen()));
                      },
                  ),
                ],
              ),
            ),
              RawMaterialButton(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                fillColor: Colors.lightBlue,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                      create: (context) => ShowError(),
                      child: RregistarationScreen())));
                },
                padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 35.0),
                child: Text(
                    'Agree and Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                  ),
                ),
              ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'from',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              'FACEBOOK',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
