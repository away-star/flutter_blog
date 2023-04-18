import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/dio.dart';

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  List<File> _imageFiles = [];
  final TextEditingController _textEditingController = TextEditingController();
  IconData _selectedMood = Icons.mood_outlined;

  Future<void> _selectAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

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

  Widget _buildMoodIcon(IconData iconData) {
    final selected = _selectedMood == iconData;
    return GestureDetector(
      onTap: () => Navigator.pop(context, iconData),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color:
                selected ? Theme.of(context).accentColor : Colors.transparent,
          ),
          child: Icon(
            iconData,
            size: 30,
            color: selected ? Colors.white : Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }

  Future<void> _selectMood() async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Choose Mood',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 5,
                  children: [
                    _buildMoodIcon(Icons.mood_rounded),
                    _buildMoodIcon(Icons.mood_bad_rounded),
                    _buildMoodIcon(Icons.sentiment_very_dissatisfied_rounded),
                    _buildMoodIcon(Icons.sentiment_dissatisfied_rounded),
                    _buildMoodIcon(Icons.sentiment_neutral_rounded),
                    _buildMoodIcon(Icons.sentiment_satisfied_rounded),
                    _buildMoodIcon(Icons.sentiment_very_satisfied_rounded),
                    _buildMoodIcon(Icons.favorite_rounded),
                    _buildMoodIcon(Icons.favorite_border_rounded),
                    _buildMoodIcon(Icons.thumb_up_rounded),
                    _buildMoodIcon(Icons.thumb_down_rounded),
                    _buildMoodIcon(Icons.whatshot_rounded),
                    _buildMoodIcon(Icons.face_rounded),
                    _buildMoodIcon(Icons.phone_android_rounded),
                    _buildMoodIcon(Icons.local_airport_rounded),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );

    if (result != null && result is IconData) {
      setState(() {
        _selectedMood = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'New Post',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () async {
                // 发布按钮点击事件
                Map<String, dynamic> data = {
                  "content": "${_textEditingController.text}",
                  "coverUrl": "",
                  "mood": "${_selectedMood}",
                  "open": true,
                  "urls": []
                };
                Response response = await dio.post(
                  '/service-content/essay', // 替换成您的API接口URL
                  data: data,
                );
                print(response.data);
              },
              child: Center(
                child: Text(
                  'Publish',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GestureDetector(
        onTap: _selectMood,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(_selectedMood, color: Colors.white, size: 35),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Type your post here',
                    border: InputBorder.none,
                  ),
                  // expands: true,
                  minLines: 1,
                  maxLines: 15,
                ),
              ),
            ),
          ),
          Divider(thickness: 1.5, height: 1.0),
          SizedBox(height: 8.0),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children: List.generate(
                  _imageFiles.length < 9
                      ? _imageFiles.length + 1
                      : _imageFiles.length,
                  (index) {
                    if (index == _imageFiles.length && _imageFiles.length < 9) {
                      return InkWell(
                        onTap: _selectAndUploadImage,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 50.0,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Upload Image',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Image.file(_imageFiles[index],
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            top: 10.0,
                            right: 10.0,
                            child: GestureDetector(
                              onTap: () => _removeImage(index),
                              child: Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                child: Icon(Icons.close, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
