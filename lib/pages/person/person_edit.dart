import 'package:flutter/material.dart';

class PersonEditPage extends StatefulWidget {
  @override
  _PersonEditPageState createState() => _PersonEditPageState();
}

class _PersonEditPageState extends State<PersonEditPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  String _avatarUrl =
      "https://www.itying.com/images/flutter/1.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Info'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveProfile();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_avatarUrl),
              radius: 28.0,
            ),
            title: Text('Avatar'),
            subtitle: Text('Your avatar:'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editAvatar();
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Name'),
            subtitle: Text('Your name:'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editName();
              },
            ),
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter your name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text('Your email address:'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editEmail();
              },
            ),
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your email address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Bio'),
            subtitle: Text('Your bio:'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editBio();
              },
            ),
          ),
          TextFormField(
            controller: _bioController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Enter your bio',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Location'),
            subtitle: Text('Your location:'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editLocation();
              },
            ),
          ),
          TextFormField(
            controller: _locationController,
            decoration: InputDecoration(
              hintText: 'Enter your location',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  void _editAvatar() {
    // TODO: 实现头像编辑功能
  }

  void _editName() {
    setState(() {});
  }

  void _editEmail() {
    print("nn");
    print(_emailController.text);
    setState(() {});
  }

  void _editBio() {
    setState(() {});
  }

  void _editLocation() {
    setState(() {});
  }

  void _saveProfile() {
    // TODO: 提交表单并更新用户信息
    Navigator.of(context).pop();
  }
}

