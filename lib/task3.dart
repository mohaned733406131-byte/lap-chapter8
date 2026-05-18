import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Task3 extends StatefulWidget {
  const Task3({super.key});

  @override
  State<Task3> createState() => _Task3State();
}

class _Task3State extends State<Task3> {
  final TextEditingController controller = TextEditingController();
  List<String> notes = [];
  void initState() {
    super.initState();
    loadnotes();
  }

  Future<File> getFile() async {
    final dir = await getApplicationCacheDirectory();
    return File('${dir.path}/notes.json');
  }

  Future<void> savenotes() async {
    try {
      String jsonuser = jsonEncode(notes);
      final File = await getFile();
      await File.writeAsString(jsonuser);
      print('successful writing');
    } catch (e) {
      print('unsuccessful writing');
    }
  }

  Future<void> loadnotes() async {
    try {
      final File = await getFile();
      String jsonuser = await File.readAsString();
      List<String> data = jsonDecode(jsonuser);
      setState(() {
        notes = data;
        print('successful reading');
      });
    } catch (e) {
      print(' unsuccessful reading');
    }
  }

  Future<void> addNote() async {
    if (controller.text.trim().isEmpty) {
      return;
    }

    setState(() {
      notes.add(controller.text.trim());
    });
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
              controller: controller,
              decoration: const InputDecoration(labelText: "notes"),
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await addNote();

                await savenotes();
               
              },
              child: const Text("add"),
            ),

            const SizedBox(height: 30),
            Expanded(
              child: notes.isEmpty
                  ? const Center(
                      child: Text("No Notes", style: TextStyle(fontSize: 20)),
                    )
                  : ListView.builder(
                      itemCount: notes.length,

                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),

                          child: ListTile(title: Text(notes[index])),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
