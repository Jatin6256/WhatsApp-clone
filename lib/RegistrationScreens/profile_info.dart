import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/Screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

FirebaseStorage storage = FirebaseStorage.instance;
Firestore fireStore = Firestore.instance;

class ProfileInfo  extends StatefulWidget {
  final FirebaseUser _user;
  ProfileInfo(this._user);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
    File profileImage;
    String url = 'no profile photo added';
    bool showProgressIndicator = false;
    bool showErrorMessage = false;
  void getImage() async
  {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      profileImage = image;
    });
  }
  void updateFireStore(String userName)
  {
    fireStore.collection('users').document('${widget._user.phoneNumber}').setData(
     {
       'name': userName,
       'url' : url
     }
    );
  }
  Future<void> uploadImage()  async
  {
    StorageReference imageFolderRef = storage.ref().child(
        'images/${widget._user.phoneNumber}');
      if(profileImage != null)
      {
        StorageUploadTask upload = imageFolderRef.putFile(profileImage);
        final StorageTaskSnapshot downloadUrl =  await upload.onComplete;
        url = (await downloadUrl.ref.getDownloadURL());
      }
  }
  @override
  Widget build(BuildContext context) {
    String userName;
    return ModalProgressHUD(
      inAsyncCall: showProgressIndicator,
      child: SafeArea(
        child: Scaffold(
          body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Profile Info',
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 30.0),
                  child: Text(
                    'Please provide your name and an optional profile photo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: CircleAvatar(
                  backgroundColor: Color(0xFFDFE5E6),
                  child: profileImage ==  null ? Icon(
                      Icons.add_a_photo,
                    color: Colors.black54,
                    size: 45.0,
                  ):null,
                  backgroundImage: profileImage != null ? FileImage(profileImage):null ,
                  radius: 60.0,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                width: 280.0,
                child: TextField(
                  onChanged: (newValue) {
                    userName = newValue;
                  },
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                  decoration: InputDecoration(
                    errorText: showErrorMessage?'sorry,some problem occurred':null,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Type Your name',
                  ),
                ),
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
                  setState(() {
                    showProgressIndicator = true;
                    showErrorMessage = false;
                  });
                    try
                    {
                      await uploadImage();
                      updateFireStore(userName);
                    }
                    catch(error)
                  {
                    print(error);
                    setState(() {
                      showErrorMessage = true;
                    });
                  }
                  setState(() {
                    showProgressIndicator = false;
                  });
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) => HomeScreen(widget._user)),(route) => false);
                },
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
