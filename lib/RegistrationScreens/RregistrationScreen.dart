import 'package:flutter/material.dart';
import 'package:whatsappclone/RegistrationScreens/show_error.dart';
import 'package:whatsappclone/RegistrationScreens/type_verification_code_screen.dart';
import 'countryList.dart';
import 'country.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import 'show_error.dart';
import 'package:progress_dialog/progress_dialog.dart';


class RregistarationScreen extends StatefulWidget {
  @override
  _RregistarationScreenState createState() => _RregistarationScreenState();
}

class _RregistarationScreenState extends State<RregistarationScreen> {
  //Country selectedCountry = Country(countryName: 'India',countryCode: '+91');
  String selectedCountry = '                          India                      ';
  String selectedCountryCode = '+91';
  String typedPhoneNumber;
   var errorMessage  = 'Invalid phone Number';
   ProgressDialog pr;

  DropdownButton<String> getDropDownButtonWithCountries() {
    List <DropdownMenuItem<String>> dropDownItem = [];
    for (Country country in countries) {
      var newItem = DropdownMenuItem<String>(
        value: country.countryName,
        child: Text(country.countryName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
        ),
      );
      dropDownItem.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCountry,
      items: dropDownItem,
      underline: Container(
        height: 2.0,
        color: Colors.blue,
      ),
      onChanged: (newValue) {
        setState(() {
          selectedCountry = newValue;
          for (Country country in countries) {
            if (country.countryName == newValue) {
              selectedCountryCode = country.countryCode;
              break;
            }
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(
      message: 'connecting...',
      progressWidget: CircularProgressIndicator(),
    );
    return Consumer<ShowError>(
      builder: (context,provider,child) {
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
                  child: Text('Enter  your phone number',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 0.0),
                  child: Text(
                    'WhatsApp Will send an SMS message to verify your phone number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                getDropDownButtonWithCountries(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 35.0,
                      child: TextField(
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 15.0,

                        ),
                        decoration: InputDecoration(
                          errorText: provider
                              .showError ? '' : null,
                          hintText: selectedCountryCode,
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    Container(
                      width: 180.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (newValue) {
                          typedPhoneNumber = newValue;
                        },
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                        decoration: InputDecoration(
                          errorText: provider
                              .showError ? errorMessage : null,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          hintText: 'phone number',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Carrier SMS charges may apply'),
                ),
                Expanded(
                  child: SizedBox(),
                ),

                RaisedButton(
                  elevation: 5.0,
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(15.0),
                  child: Text('Next',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    provider.setShowErrorFalse();
                    pr.show();
                    await Future.delayed(Duration(seconds: 3),).then((value) => pr.hide()) ;
                    Alert(
                      context: context,
                      title: '',
                      content: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0.0, 0.0, 15.0, 15.0),
                            child: Text(
                              'We will be verifying the phone number:',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 80.0,),
                            child: Text(
                              selectedCountryCode + '  ' + typedPhoneNumber,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0.0, 10.0, 15.0, 0.0),
                            child: Text(
                              'Is this OK, or would you like to edit the number ?',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          child: Text(
                            'EDIT',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        DialogButton(
                          child: Text('OK',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) =>
                                    TypeVerificationCode(
                                      typedPhoneNumber: typedPhoneNumber,
                                      selectedCountryCode: selectedCountryCode,
                                        callBack: (var exception)
                                        {
                                          provider.setShowErrorTrue();
                                          print(exception.message);
                                        }
                                    ),
                            ),
                            );
                          },
                        ),
                      ],
                    ).show();
                  },
                ),
                SizedBox(height: 50.0,),
              ],
            ),
          ),
        );
      },
    );
  }
}






