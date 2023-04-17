import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SlideViewEdit extends StatefulWidget {
  // final List<File> imageFiles;


  // SlideViewEdit({Key? key, required this.imageFiles}) : super(key: key);
  List<File> imageFiles = [];

  @override
  _SlideViewEditState createState() => _SlideViewEditState();
}

class _SlideViewEditState extends State<SlideViewEdit> {
  List<File> _imageFiles = [];

  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageFiles = widget.imageFiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Image View'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: _imageFiles.length + 1,
                itemBuilder: (context, index) {
                  if (index == _imageFiles.length) {
                    return GestureDetector(
                      onTap: _getImage,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Icon(Icons.add, color: Colors.grey[400], size: 48),
                        ),
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () => _showImageDialog(context, _imageFiles[index]),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: FileImage(_imageFiles[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -5,
                          right: -5,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: Icon(Icons.close, size: 20, color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  void _showImageDialog(BuildContext context, File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.file(imageFile, fit: BoxFit.cover),
          ),
        );
      },
    );
  }

  void _saveChanges() {
    // 将 _imageFiles 中的图片保存到服务器或本地数据库等
    // 做相应的状态更新并返回上个页面

    print(_imageFiles);
    Navigator.pop(context, _imageFiles);
  }
}
