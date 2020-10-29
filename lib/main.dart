
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter File Upload Example',
      home: UploadPage(),
    );
  }
}

class UploadPage extends StatefulWidget {
  UploadPage({Key key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    var res = await request.send();
    return res.statusCode.toString();
  }
  String state = "";
  String url="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter File Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(state)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var file = await ImagePicker.pickImage(source: ImageSource.gallery);
          var res = await uploadImage(file.path, url);
          setState(() {
            state = res;
            print(res);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
