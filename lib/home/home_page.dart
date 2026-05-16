import 'package:flutter/material.dart';

import '../add/add_page.dart';
import '../database/todo.dart';
import '../detail/detail_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todoList = [
    Todo(
      id: 1,
      title: "Записаться на курсы по flutter",
      isDone: true,
      createdAt: "01.03.2026",
    ),
    Todo(
      id: 2,
      title: "Прочесть Война и Мир",
      isDone: false,
      createdAt: "20.04.2026",
    ),
    Todo(
      id: 3,
      title: "Купить новый телефон",
      isDone: false,
      createdAt: "1.09.2026",
    ),
    Todo(
      id: 4,
      title: "Посмотреть сериал Игра престолов",
      isDone: false,
      createdAt: "10.05.2026",
    ),
  ];

  @override
  void initState() {
    super.initState();
    print("Home Page - initState");
  }

  @override
  Widget build(BuildContext context) {
    print("Home Page - build");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todo = todoList[index];

          return ListTile(
            title: Text(todo.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    todo: todo,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    print("Home Page - dispose");
    super.dispose();
  }

  void _navigateToAddPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddPage(),
      ),
    );

    // обработка result при необходимости
  }
}