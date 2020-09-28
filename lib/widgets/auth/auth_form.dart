import 'dart:io';
import 'package:flutter/material.dart';
import '../../widgets/picker/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;

  final void Function(
    String email,
    String userName,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitAuthForm;

  AuthForm(this.submitAuthForm, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  var _isLogIn = true;
  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    //for closing soft keyboard
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogIn) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Please pick an image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitAuthForm(
        _userEmail,
        _userName,
        _userPassword,
        _isLogIn,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogIn) UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey("email"),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email address",
                  ),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return "Please eneter a valid email address";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _userEmail = value.trim();
                    // trim to remove white space
                  },
                ),
                if (!_isLogIn)
                  TextFormField(
                    key: ValueKey("useName"),
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return "Please enter at lest 4 Characters";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userName = value.trim();
                    },
                  ),
                TextFormField(
                  key: ValueKey("password"),
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return "Passowrd is too small";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  onSaved: (value) {
                    _userPassword = value.trim();
                  },
                ),
                SizedBox(height: 12),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogIn ? "Login" : "Sign Up"),
                    onPressed: () {
                      _trySubmit();
                    },
                  ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(_isLogIn
                      ? "Create new Account"
                      : "I alredy have an account"),
                  onPressed: () {
                    setState(() {
                      _isLogIn = !_isLogIn;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
