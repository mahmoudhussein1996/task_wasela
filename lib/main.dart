import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {

  @override
  _TodoListPageState createState() => _TodoListPageState();
}
class _TodoListPageState extends State<TodoListPage> {
  final List<String> _tasks = [];
  final List<bool> _completed = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    final task = _taskController.text.trim();
    if (task.isEmpty) {
      _showTaskError('Task name cannot be empty.');
      return;
    } else if (_tasks.contains(task)) {
      _showTaskError('Task with this name already exists.');
      return;
    }
      setState(() {
        _tasks.add(task);
        _completed.add(false);
        _taskController.clear();
      });
  }
  void _removeCompletedTasks() {
    setState(() {
      for (int indexOfTast = _tasks.length - 1; indexOfTast >= 0; indexOfTast--) {
        if (_completed[indexOfTast]) {
          _tasks.removeAt(indexOfTast);
          _completed.removeAt(indexOfTast);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _removeCompletedTasks,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                        labelText: 'Add a new task',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: _completed[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _completed[index] = value!;
                      });
                    },
                  ),
                  title: Text(_tasks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showTaskError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}