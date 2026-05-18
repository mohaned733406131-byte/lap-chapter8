import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class user {
  String name;
  int age;
  user({required this.name, required this.age});
  Map<String, dynamic> tojson() {
    return {'name': name, 'age': age};
  }

  factory user.fromjson(Map<String, dynamic> json) {
    return user(name: json['name'], age: json['age']);
  }
}

class task2 extends StatefulWidget {
  const task2({super.key});

  @override
  State<task2> createState() => _task2State();
}

class _task2State extends State<task2> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  user? user1;
  @override
  void initState() {
    super.initState();
  }

  Future<File> getFile() async {
    final dir = await getApplicationCacheDirectory();
    return File('${dir.path}/user.json');
  }

  Future<void> saveuser() async {
try {
   user user1 = user(
        name: nameController.text,
        age: int.parse(ageController.text),
      );
      String jsonuser = jsonEncode(user1.tojson());
      final File = await getFile();
      await File.writeAsString(jsonuser);
      print('successful writing');
} catch (e) {
 print('unsuccessful writing'); 
}

   
  }

  Future<void> loaduser() async {
    try {
      final File = await getFile();
      String jsonuser = await File.readAsString();
      Map<String, dynamic> data = jsonDecode(jsonuser);
      setState(() {
        user1 = user.fromjson(data);
        print('successful reading');
      });
    } catch (e) {
      print(' unsuccessful reading');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await saveuser();

                await loaduser();
                if (user1 != null)
                Navigator.push(context,MaterialPageRoute(builder:(context)=>UserPage(name: user1!.name, age: user1!.age)));
              },
              child: const Text("Save"),
            ),

            const SizedBox(height: 30),

            if (user1 != null)
              Column(
                children: [
                  Text("Name: ${user1!.name}"),

                  Text("Age: ${user1!.age}"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}




class UserPage extends StatelessWidget {
  final String name;
  final int age;

  const UserPage({
    super.key,
    required this.name,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Data"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              "Name: $name",
              style: const TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),

            Text(
              "Age: $age",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}