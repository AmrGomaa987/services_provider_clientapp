import 'dart:io';
import 'package:clientphase/controllers/profile_controller.dart';
import 'package:clientphase/screens/accountsetup/InputTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends ChangeNotifier {
  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final ProfileController profileController= Get.put(ProfileController());



  final picker = ImagePicker();
   File? _image ;
  File? get image => _image;

Future<void> pickImage(BuildContext context) async {
  final pickedFile = await showDialog<XFile>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 120,
          child: Column(
            children: [
              ListTile(
                onTap: () async {
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 100,
                  );
                   if (pickedFile != null) {
                              _image = File(pickedFile.path);
                              profileController.updateProfile(profileImage: _image);
                          }
                  Navigator.pop(context, pickedFile);
                },
                leading: Icon(Icons.camera, color: Colors.black),
                title: Text('Camera'),
              ),
              ListTile(
                onTap: () async {
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 100,
                  );
                  if (pickedFile != null) {
                          _image = File(pickedFile.path);
                            profileController.updateProfile(profileImage: _image);
                      }
                  Navigator.pop(context, pickedFile);
                },
                leading: Icon(Icons.image, color: Colors.black),
                title: Text('Gallery'),
              ),
            ],
          ),
        ),
      );
    },
  );

if (pickedFile != null) {
    _image = File(pickedFile.path);
    profileController.updateProfile(profileImage: _image);

    notifyListeners();
  }
}
  Future pickGalleryImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = pickedFile as File;
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = pickedFile as File;
      notifyListeners();
    }
  }

  void pickImagee(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera, color: Colors.black),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    pickGalleryImage(context);
                  },
                  leading: Icon(Icons.image, color: Colors.black),
                  title: Text('Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

Future<void> showUserName(BuildContext context, String name) {
  nameController.text = name;
  String errorMessage = ''; // Error message for short name
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(child: Text('تعديل الاسم')),
        content: SingleChildScrollView(
          child: Column(
            children: [
              InputTextField(
                myController: nameController,
                keyBoardType: TextInputType.text,
                obscureText: false,
                hint: '',
                enable: true, // Add this parameter
                autoFocus: false, // Add this parameter
              ),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('الغاء'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isEmpty) {
                      errorMessage = 'يرجى ادخال اسم';
                 
                    Fluttertoast.showToast(
                  msg: 'يرجى ادخال اسم',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                    
                    return;
              }  else if (nameController.text.length < 3) {
                  errorMessage = 'الاسم قصير جدا';
                
                    Fluttertoast.showToast(
                  msg: 'الاسم قصير جدا',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                    
                  return;
                } else {
                profileController.updateProfile(name: nameController.text);
                Fluttertoast.showToast(
                  msg: 'تم تحديث الاسم بنجاح',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Navigator.pop(context);
                return;
              }
            
            },
            child: Text('تم'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
          ),
        ],
      );
    },
  );
}

  Future<void> showUserbio(BuildContext context, String name) {
    bioController.text = name;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('تعديل الكنية')),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InputTextField(
                  myController: bioController,
                  keyBoardType: TextInputType.text,
                  obscureText: false,
                  hint: '',
                  enable: true, // Add this parameter
                  autoFocus: false, // Add this parameter
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('الغاء'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                 if (bioController.text.isEmpty) {
                 
                    Fluttertoast.showToast(
                  msg: 'يرجى ادخال الكنية',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                     
                    return;
                 } else{
              profileController.updateProfile(bio: bioController.text);
              Fluttertoast.showToast(
                        msg: 'تم تحديث الكنية بنجاح',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                Navigator.pop(context);
              }},
              child: Text('تم'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

 Future<void> showUseremail(BuildContext context, String name) {
  emailController.text = name;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(child: Text('تعديل الايميل')),
        content: SingleChildScrollView(
          child: Column(
            children: [
              InputTextField(
                myController: emailController,
                keyBoardType: TextInputType.text,
                obscureText: false,
                hint: '',
                enable: true, // Add this parameter
                autoFocus: false, // Add this parameter
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('الغاء'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              if (!emailController.text.toLowerCase().endsWith('.com')) {
                Fluttertoast.showToast(
                  msg: 'البريد الإلكتروني يجب أن ينتهي بـ ".com"',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                return;
              }
              if (emailController.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: 'يرجى ادخال الايميل',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                return;
              }
              if (emailController.text.contains(profileController.profileData.value.email)) {
                Fluttertoast.showToast(
                  msg: ' الايميل موجود بالفعل',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                return;
              }
              else
              {profileController.updateProfile(email: emailController.text);
              Fluttertoast.showToast(
                msg: 'تم تحديث الايميل بنجاح',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Navigator.pop(context);}
            },
            child: Text('تم'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> showPassword(BuildContext context) async {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String errorMessage = '';
  bool obscureText = true; // Initially password is obscured

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Center(child: Text('تغير كلمة المرور')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  TextField(
                    controller: oldPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: obscureText, // Use obscureText property
                    decoration: InputDecoration(
                      hintText: 'كلمة السر القديمه',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText; // Toggle visibility
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: newPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: obscureText, // Use obscureText property
                    decoration: InputDecoration(
                      hintText: 'كلمة السر الجديدة',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText; // Toggle visibility
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: obscureText, // Use obscureText property
                    decoration: InputDecoration(
                      hintText: 'تأكيد كلمة السر',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText; // Toggle visibility
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('الغاء'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty || oldPasswordController.text.isEmpty) {
                    setState(() {
                      errorMessage = ' برجاء ادخال كل البيانات';
                    });
                    // Close the dialog after 5 seconds
                    // Future.delayed(Duration(seconds: 3), () {
                    //   Navigator.pop(context);
                    // });
                    return;
                  } else if (newPasswordController.text != confirmPasswordController.text) {
                    setState(() {
                      errorMessage = 'كلمة السر غير متطابقتين';
                    });
                    
                    return;
                  } else if (newPasswordController.text.length <8 || confirmPasswordController.text.length<8) {
                    setState(() {
                      errorMessage = 'كلمة السر  يجب ان تكون من 8 حروف او ارقام اواكثر';
                    });
                    
                    return;
                  } 
                  else {
                    try {
                      await profileController.updateMyPassword(
                        oldPassword: oldPasswordController.text,
                        newPassword: newPasswordController.text,
                        passwordConfirm: confirmPasswordController.text,
                      );
                      // Close the dialog
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'تم تحديث كلمة المرور بنجاح',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }catch (e) {
                      errorMessage = 'فشل تحديث كلمة المرور';
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'كلمة السر القديمة غير صحيحة',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,);
                    }
                  }
                },
                child: Text('تم'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}


}
