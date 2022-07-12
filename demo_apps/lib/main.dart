import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'call_api/call.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = 'Flutter Home Page';
  Data data = Data(age: 12, name: "Thanh");

  void updateTitle() {
    setState(() {
      // title = 'Flutter Home Page1';
      data = Data(age: 18, name: "name");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotiData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: title,
          onPressed: updateTitle,
          data: data,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    this.title,
    this.onPressed,
    this.data,
  }) : super(key: key);

  Data? data;

  String? title;
  final VoidCallback? onPressed;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    // print('initState');
    // getDatas();
    _animationController = AnimationController(vsync: this);
  }

  onCheck() {
    setState(() {
      Provider.of<NotiData>(context, listen: false)
          .setData(Data(age: 20, name: "Lam sao"));
    });

    // setState(() {
    //   widget.data?.age = 19;
    // });
  }

  Data? data;

  @override
  void didChangeDependencies() {
    print("thay doi: " + MediaQuery.of(context).size.width.toString());

    // TODO: implement didChangeDependencies
    widget.data = Provider.of<NotiData>(context, listen: false).data;
    print(widget.data?.age.toString());
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // TODO: implement didUpdateWidget
    print('didUpdateWidget');
    if (this.widget.title != oldWidget.title) {
      print('Title has changed');
    } else {
      print('Title has no changed');
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose');
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              widget.data!.age.toString(),
            ),
            Text(
              Provider.of<NotiData>(context, listen: false).data.age.toString(),
            ),
            ElevatedButton(
              onPressed: onCheck,
              child: Text("bien"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ExampleRoutedPage()),
                );
              },
              child: Text('Dispose'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExampleRoutedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Data {
  String name;
  int age;
  Data({required this.age, required this.name});
}

class NotiData extends ChangeNotifier {
  Data _data = Data(age: 0, name: "Thanh");
  Data get data => _data;
  setData(Data valueData) {
    _data = valueData;
    notifyListeners();
  }
}
