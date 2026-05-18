import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class task1 extends StatefulWidget {
  const task1({super.key});

  @override
  State<task1> createState() => _task1State();
}

class _task1State extends State<task1> {
  int counter = 0;
  @override
  void initState() {
    super.initState();
    loadcounter();
  }

  Future<File> getFile() async {
    final dir = await getApplicationCacheDirectory();
    return File('${dir.path}/counter.txt');
  }

  Future<void> savecounter() async {
    final File = await getFile();
    await File.writeAsString(counter.toString());
  }

  Future<void> loadcounter() async {
    final File = await getFile();
    try {
      String value = await File.readAsString();
      setState(() {
        counter = int.parse(value);
      });
    } catch (e) {
      setState(() {
        counter = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Text('$counter'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
            savecounter();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
