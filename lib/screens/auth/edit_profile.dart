import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditation_alive/consts/collections.dart';
import 'package:meditation_alive/models/users.dart';
import 'package:meditation_alive/screens/auth/forget_password.dart';
import 'package:meditation_alive/screens/auth/landing_page.dart';
import 'package:meditation_alive/services/authentication_service.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController userNameController = TextEditingController();
  AppUserModel? user;
  String? newImageUrl;
  bool isLoading = false;
  bool _isUpdating = false;
  bool _userNameValid = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File? file;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await userRef.doc(currentUser!.id).get();
    user = AppUserModel.fromDocument(doc);
    userNameController.text = user!.name!;
    newImageUrl = user!.imageUrl;
    setState(() {
      isLoading = false;
    });
  }

  Column buildUserField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "User Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: userNameController,
          decoration: InputDecoration(
            hintText: "Update User Name",
            errorText: _userNameValid ? null : "Name Too Short",
          ),
        ),
      ],
    );
  }

  logout() async {
    await AuthenticationService().signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LandingPage();
    }));
  }

  updateProfileData() async {
    setState(() {
      userNameController.text.trim().length < 3 ||
              userNameController.text.isEmpty
          ? _userNameValid = false
          : _userNameValid = true;
      _isUpdating = true;
    });
    if (_userNameValid) {
      // ignore: unnecessary_statements
      // ignore: unnecessary_statements
      file == null ? null : newImageUrl = await uploadImage(file!);
      userRef.doc(currentUser!.id).update({
        "name": userNameController.text,
        "imageUrl": newImageUrl,
      });
      setState(() {
        _isUpdating = false;
      });

      Navigator.pop(context);
      BotToast.showText(text: 'Profile Updated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _isUpdating ? null : () => updateProfileData(),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                _isUpdating
                    ? Center(child: LinearProgressIndicator())
                    : Text(""),
                Container(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          file == null
                              ? CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      user!.imageUrl!),
                                  radius: 60.0,
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(file!),
                                  radius: 60.0,
                                ),
                          GestureDetector(
                            onTap: handleImageFromGallery,
                            child: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 20.0,
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  size: 20.0,
                                  color: Colors.white,
                                ))),
                          ),
                        ],
                        alignment: Alignment.bottomRight,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            buildUserField(),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ForgetPassword()));
                              },
                              child: Text("Change Password"),
                            ),
                            ElevatedButton(
                              onPressed: logout,
                              child: Text("Logout"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: ElevatedButton(
                          onPressed: () => logout(),
                          child: Row(
                            children: [
                              Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 40,
                              ),
                              Text(
                                "Log Out",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  handleImageFromGallery() async {
    var picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    File file;
    file = File(picker!.path);
    setState(() {
      this.file = file;
    });
  }

  Future<String> uploadImage(File imageFile) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('usersImages')
        .child(userNameController.text + '.jpg');
    String downloadUrl;
    //TaskSnapshot storageSnap = await
    await ref.putFile(imageFile);
    downloadUrl = await ref.getDownloadURL();
    //downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }
}
