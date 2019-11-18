import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import '../widgets/inputButton.dart';
import 'dart:async';
import 'registerPage.dart';
import 'package:flutter/services.dart';
import 'dart:collection';
import 'package:image/image.dart' as ex;
import 'package:image_cropper/image_cropper.dart';

class IdCardCameraPage extends StatefulWidget {
  IdCardCameraPage({Key key}) : super(key: key);

  _IdCardCameraPageState createState() => _IdCardCameraPageState();
}

class _IdCardCameraPageState extends State<IdCardCameraPage> {
  List<CameraDescription> cameras;
  CameraController _cameraController;
  bool isReady = false;
  String photoPath;
  String _num;
  String _name;
  String _gender;
  File imageFile;
  Map map=Map();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    try {
      cameras = await availableCameras();
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      await _cameraController.initialize();
    } on CameraException catch (_) {
      debugPrint("Some error occured!");
    }
    setState(() {
      isReady = true;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera Demo'),
        ),
        body: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: <Widget>[
                        _cameraPreviewWidget(),
                        _cameraFloatImage(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _takePictureLayout(),
                  )
                ],
              ),
              //getPhotoPreview(), //图片预览布局
            ],
          ),
        ),
      ),
    );
  }

//相机界面
  Widget _cameraPreviewWidget() {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return const Text(
        ' ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return new Container(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: _cameraController.value.aspectRatio,
          child: CameraPreview(_cameraController),
        ),
      );
    }
  }

//身份证悬浮照片的界面
  Widget _cameraFloatImage() {
    return new Positioned(
        child: new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: new Image.asset('images/camera_idcard_front.png'),
    ));
  }

//拍照按钮界面
  Widget _takePictureLayout() {
    return new Align(
        alignment: Alignment.bottomCenter,
        child: new Container(
          color: Colors.blueAccent,
          alignment: Alignment.center,
          child: new IconButton(
            iconSize: 50.0,
            onPressed: _cameraController != null &&
                    _cameraController.value.isInitialized &&
                    !_cameraController.value.isRecordingVideo
                ? onTakePictureButtonPressed
                : null,
            icon: Icon(
              Icons.photo_camera,
              color: Colors.white,
            ),
          ),
        ));
  }

  //相机按钮拍照
  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (filePath != null) {
        //showInSnackBar('Picture saved to $filePath');
        photoPath = filePath;
        setState(() {
          imageFile=File(filePath);
        }); // 通过设置photoPath 的状态展示图片预览页
        //getIDCardInfo(File(filePath));//进行身份证识别
        _resizeIdcard();
        _cropImage();
      }
    });
  }
 _resizeIdcard(){
//    ex.Image image = ex.decodeImage(imageFile.readAsBytesSync());
//    //ex.Image thumbnail = ex.copyResize(image, width: 320,height: 240);
//    //File('/storage/emulated/0/1/picture2.jpg')..writeAsBytesSync(ex.encodePng(thumbnail));
//    ex.Image picuureroate=ex.copyRotate(image,270);
//    imageFile..writeAsBytesSync(ex.encodePng(picuureroate));

 }
  Future<String> takePicture() async {
    if (!_cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final dateTime = DateTime.now();
    final path = join((await getTemporaryDirectory()).path,
        '${dateTime.millisecondsSinceEpoch}.jpg');
    // final Directory extDir = await getApplicationDocumentsDirectory();
    // final String dirPath = '${extDir.path}/Pictures/flutter_test';
    // await Directory(dirPath).create(recursive: true);
    // final String filePath = '$dirPath/${timestamp()}.jpg';

    if (_cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await _cameraController.takePicture(path);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return path;
  }
Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: '请将身份证框出',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio7x5,
          lockAspectRatio: false,
          showCropGrid:false,
          hideBottomControls:true,),
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      _addMap();
      Navigator.pop(context,map);
      // setState(() {
      // });
    }
  }
   _addMap(){
    map.addAll({
      "src":imageFile.path
    });
  }
  // Widget getPhotoPreview() {
  //   if (null != photoPath) {
  //     return Column(
  //       children: <Widget>[
  //         Expanded(
  //           flex: 5,
  //           child: Container(
  //             width: double.infinity,
  //             height: double.infinity,
  //             color: Colors.black,
  //             alignment: Alignment.center,
  //             child: Image.file(File(photoPath)),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: Row(
  //             children: <Widget>[
  //               Expanded(
  //                   flex: 1,
  //                   child: Container(
  //                     color: Colors.black,
  //                   )),
  //               Expanded(
  //                   flex: 1,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Container(
  //                       child: Image.asset("images/cancel.png"),
  //                       color: Colors.black,
  //                     ),
  //                   )),
  //               Expanded(
  //                   flex: 1,
  //                   child: GestureDetector(onTap:(){
  //                     Navigator.pop(context,"${photoPath}");
  //                   },
  //                   child: Container(
  //                       child: Image.asset("images/ok.png"),
  //                       color: Colors.black,
  //                     ),)),
  //               Expanded(
  //                   flex: 1,
  //                   child: Container(
  //                     color: Colors.black,
  //                   ))
  //             ],
  //           ),
  //         )
  //       ],
  //     );
  //   } else {
  //     return Container(
  //       height: 1.0,
  //       width: 1.0,
  //       color: Colors.black,
  //       alignment: Alignment.bottomLeft,
  //     );
  //   }
  // }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
