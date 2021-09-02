import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textrcg/resultscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: HomePage.id,
      routes: {HomePage.id: (context) => HomePage()},
    );
  }
}

class HomePage extends StatelessWidget {
  static String id = 'initial';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('Text Recognition!')),
        ),
        body: Column(
          children: [
            Card(
                margin: EdgeInsets.all(22),
                elevation: 20,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(9),
                        child: Icon(Icons.add_a_photo_outlined)),
                    Text('Upload A Document'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              print('LL');
                              var pickedImage = await ImagePicker.platform
                                  .pickImage(source: ImageSource.gallery);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ResultScreen(img: pickedImage)));
                            } catch (e) {
                              //SnackBar sb = SnackBar(
                              //content: Text('Some Error Occured'));
                              //ScaffoldMessenger.of(context).showSnackBar(sb);
                            }
                          },
                          child: Text('Gallery'),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              try {
                                var pickedImage = await ImagePicker.platform
                                    .pickImage(source: ImageSource.camera);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ResultScreen(img: pickedImage)));
                              } catch (e) {
                                print(e);
                                //SnackBar sb = SnackBar(
                                //content: Text('Some Error Occured'));
                                //ScaffoldMessenger.of(context).showSnackBar(sb);
                              }
                            },
                            child: Text('Camera')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ))
          ],
        ));
  }
}
