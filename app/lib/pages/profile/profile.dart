import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/pages/messages/messages_list.dart';
import 'package:chat-game/pages/widgets/avatar.dart';
import 'package:chat-game/pages/widgets/drawer.dart';
import 'package:chat-game/providers/shared_prefs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? _imageFile;
  String? userName;
  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameController =
      TextEditingController(text: Settings.i.userName);

  Future<void> _onImageButtonPressed() async {
    {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        setState(() => _imageFile = pickedFile);
      } catch (e) {
        setState(() => _pickImageError = e);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return kIsWeb
          ? Image.network(_imageFile!.path)
          : Image.file(File(_imageFile!.path));
    } else if (_pickImageError != null) {
      return Text(
        'Error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'Pick your profile picture',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) return;
    if (response.file != null)
      setState(() => _imageFile = response.file);
    else
      _retrieveDataError = response.exception!.code;
  }

  @override
  Widget build(BuildContext context) {
    return DrawerWidget(title: 'Edit Profile', child: buildProfile());
  }

  Widget buildProfile() {
    return Container(
      padding: EdgeInsets.only(top: 80, left: 10, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            enableFeedback: false,
            customBorder: const CircleBorder(),
            onTap: _onImageButtonPressed,
            child: Avatar(
                animate: true,
                radius: 60,
                image: (_imageFile?.path) ?? Settings.i.userAvatar),
          ),
          SizedBox(height: 20),
          // build textfield for Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextField(
              maxLength: 15,
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Name',
              ),
            ),
          ),
          Spacer(),
          // BlockPicker(
          //   pickerColor: Colors.red, //default color
          //   onColorChanged: (Color color) {
          //     //on color picked
          //     print(color);
          //   },
          // ),
          Btn(
            onPressed: () async {
              Settings.i.userName = nameController.text;
              Settings.save();
              if (_imageFile != null) {
                File tmpFile = File(_imageFile!.path);
                final String savePath =
                    (await getApplicationDocumentsDirectory()).path;
                tmpFile = await tmpFile
                    .copy('$savePath/${Random().nextInt(9999)}.jpg');
                Settings.i.userAvatar = tmpFile.path;
                Settings.save();
              }
              context.go('/');
            },
            label: 'Save',
          ),
        ],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
