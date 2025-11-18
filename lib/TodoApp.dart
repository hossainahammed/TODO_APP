import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  TextEditingController taskTEcontroller = TextEditingController();
  List<String> _tasks = [];

  void _addtask() {
    if (taskTEcontroller.text.trim().isNotEmpty) {
      setState(() {
        _tasks.add(taskTEcontroller.text.trim());
        taskTEcontroller.clear();
      });
    }
  }

  void _deletetask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO APP'),
        backgroundColor: Colors.teal,
        elevation: 4, // Adds shadow for depth
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Input Row with improved styling
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.task, color: Colors.teal),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: taskTEcontroller,
                        decoration: InputDecoration(
                          labelText: 'Enter your task',
                          labelStyle: TextStyle(color: Colors.teal),
                          border: InputBorder.none,
                          hintText: 'e.g., Buy groceries',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      onPressed: _addtask,
                      label: Text('Add Task'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Expanded(
                child: _tasks.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, size: 80, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        'No tasks yet. Add one above!',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.check_circle_outline, color: Colors.teal),
                          title: Text(
                            _tasks[index],
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: IconButton(
                            onPressed: () => _deletetask(index),
                            icon: Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Delete Task',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}