import 'package:flutter/material.dart';
import 'data_model.dart';
import 'api_service.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Future<DataModel> _dataModel;

  @override
  void initState() {
    super.initState();
    _dataModel = ApiService().fetchData();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataModel>(
      future: _dataModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return FadeTransition(
            opacity: _animation,
            child: Text('Hello, ${snapshot.data!.name}'),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}