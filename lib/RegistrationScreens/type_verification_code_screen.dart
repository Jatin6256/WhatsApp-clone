import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/RegistrationScreens/profile_info.dart';
import 'package:whatsappclone/RegistrationScreens/show_error.dart';
import 'package:whatsappclone/Screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'show_error.dart';

class TypeVerificationCode extends StatefulWidget {
  final String typedPhoneNumber;
  final String selectedCountryCode;
  final Function callBack;
  TypeVerificationCode({this.typedPhoneNumber,this.selectedCountryCode,this.callBack});

  @override
  _TypeVerificationCodeState createState() => _TypeVerificationCodeState();
}

class _TypeVerificationCodeState extends State<TypeVerificationCode> {
  String _sentVerificationCode;
  String typedVerificationCode;
  String errorMessage = 'Invalid code';
  bool showError = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  var otpController = TextEditingController();
  Future<void> verifyPhoneNumber(BuildContext context) async
  {
    await _auth.verifyPhoneNumber(
        phoneNumber: widget.selectedCountryCode + widget.typedPhoneNumber,
        timeout: Duration(seconds: 8),
        verificationCompleted: (authCredential) async  {
          AuthResult authResult = await  _auth.signInWithCredential(authCredential);
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileInfo(authResult.user)),);
    },
        verificationFailed: (authException){
          Navigator.pop(context);
          widget.callBack(authException);
        },
        codeSent: (verificationId,[code]){
          _sentVerificationCode = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          _sentVerificationCode = verificationId;
        },
    );
  }
  @override
  void initState() {

    verifyPhoneNumber(context);
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
    child: Scaffold(
    body: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
        ),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Verify  ${widget.selectedCountryCode} ${widget.typedPhoneNumber}',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 0.0),
          child: Text(
            'Waiting to automatically detect an SMS sent to ${widget.selectedCountryCode} ${widget.typedPhoneNumber}.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
        ),
      Container(
        width: 180.0,
        child: TextField(
          controller: otpController,
          maxLength: 6,
          onChanged: (newValue){
            typedVerificationCode = newValue;
          },
          keyboardType: TextInputType.number,
//          onChanged: (newValue){
//            typedPhoneNumber = newValue;
//          },
          style: TextStyle(
            fontSize: 15.0,
          ),
          decoration: InputDecoration(
            hintText:' --- --- ---  --- --- ---',
            contentPadding: EdgeInsets.only(left: 30.0,),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            errorText: showError ? errorMessage :null,
          ),
        ),
      ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Enter 6-digit verification code',
          style: TextStyle(
            color: Colors.grey,
          ),
          ),
        ),
        RaisedButton(
          elevation: 5.0,
          color: Colors.lightBlue,
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Verify',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            showError = false;
            AuthCredential  credential = PhoneAuthProvider.getCredential(verificationId: _sentVerificationCode, smsCode: typedVerificationCode);
            try
                {
                  AuthResult authResult =  await _auth.signInWithCredential(credential);
                  if(authResult.user !=  null){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfileInfo(authResult.user)),);
                  }

                }
             catch(e)
            {
              print('hello');
              setState(() {
                showError = true;
              });
            }

          },
        ),
      ],
      ),
    ),
   );
  }
}
