import 'package:flutter/material.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> myTasks = [];

  Future<void> openAddPage() async {

    final text = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddPage(),
      ),
    );

    if (text != null && text.toString().isNotEmpty) {

      setState(() {

        myTasks.insert(0, text);

      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF3F5F7),

      appBar: AppBar(
        title: const Text("Task List"),
        centerTitle: true,
      ),

      body: myTasks.isEmpty
          ? const Center(
              child: Text(
                "Нет задач",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: myTasks.length,
              itemBuilder: (context, index) {

                return Container(

                  margin: const EdgeInsets.only(bottom: 10),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: ListTile(
                    leading: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.indigo,
                    ),

                    title: Text(
                      myTasks[index],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}