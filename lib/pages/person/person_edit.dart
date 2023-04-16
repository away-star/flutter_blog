import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class PersonEditPage extends StatefulWidget {
  @override
  _PersonEditPageState createState() => _PersonEditPageState();
}

class _PersonEditPageState extends State<PersonEditPage> {
  String _avatarUrl = "https://www.itying.com/images/flutter/1.png";
  String _name = 'xingxing';
  String _email = "123456@qq.com";
  String _signature = 'So far all life is written with failure, but this does not prevent me from moving forward';

  List<String> _items = [
    "home",
    "spring boot",
    "spring cloud",
    "react",
    "umi.js",
    "H5",
    "flutter",
    "CSS3",
    "Music",
    "Entertainment"
  ];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _signatureController = TextEditingController();


  void _addListItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _removeListItem(String item) {
    setState(() {
      _items.remove(item);
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('My List'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _addNewItemDialog(context);
          },
        ),
      ],
    );
  }

  void _addNewItemDialog(BuildContext context) async {
    String? newItemName;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('New Item'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Item name',
          ),
          onChanged: (value) {
            setState(() {
              newItemName = value;
            });
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newItemName);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (newItemName != null) {
      _addListItem(newItemName!);
    }
  }

  Future<void> _showList() async {
    final String result = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _items.isEmpty
              ? Center(
                  child: Text(
                    'No items',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              : ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String item = _items[index];
                    return ListTile(
                      title: Text(item),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeListItem(item);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

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
            subtitle: Text('Your name: ${_name}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editName();
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text('Your email address: ${_email}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editEmail();
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.pending_actions),
            title: Text('Signature'),
            subtitle: Text('Your signature: ${_signature}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editSign();
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Home: List'),
            subtitle: Text('Manage your lists'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: _showList,
              // child: Text('Show List'),
            ),
          ),
        ],
      ),
    );
  }

  void _editAvatar() {
    // TODO: 实现头像编辑功能
  }

  void _editName() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Name'),
            content: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _name = _nameController.text;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('SAVE'),
              ),
            ],
          );
        });
  }

  void _editEmail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Email Address'),
            content: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Enter your email address',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _email = _emailController.text;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('SAVE'),
              ),
            ],
          );
        });
  }

  void _editSign() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Signature'),
            content: TextFormField(
              controller: _signatureController,
              decoration: const InputDecoration(
                labelText: 'Enter your signature',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _signature = _signatureController.text;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('SAVE'),
              ),
            ],
          );
        });
  }

  void _saveProfile() {
    // TODO: 提交表单并更新用户信息
    Navigator.of(context).pop();
  }
}
