import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:user_and_task_manager/models/user_model.dart';
import 'package:user_and_task_manager/hive/task_model.dart';

class UserDetailScreen extends StatefulWidget {
  final UserModel user;
  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Box<TaskModel> taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<TaskModel>('tasks');
  }

  void _editTask(TaskModel task){
    final titleController = TextEditingController(text: task.title);
    
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Edit Task"),
      content: TextField(
        controller: titleController,
        decoration: const InputDecoration(hintText: 'Task Title'),
      ),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('cancel')),
        ElevatedButton(onPressed: (){
          final index = taskBox.values.toList().indexOf(task);
          taskBox.putAt(index, TaskModel(userId: task.userId, title: titleController.text, createdAt: task.createdAt));
          Navigator.pop(context);
          setState(() {});
        }, child: const Text('save'))
      ],
    ));
  }
  void _deleteTask(TaskModel task) {
    final index = taskBox.values.toList().indexOf(task);
    taskBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user.name)),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(widget.user.email),
          const SizedBox(height: 20),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: taskBox.listenable(),
              builder: (context, Box<TaskModel> box, _) {
                final userTasks = box.values
                    .where((task) => task.userId == widget.user.id)
                    .toList();

                if (userTasks.isEmpty) {
                  return const Center(child: Text("No tasks yet!"));
                }

                return ListView.builder(
                  itemCount: userTasks.length,
                  itemBuilder: (context, index) {
                    final task = userTasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text("Created: ${task.createdAt}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: () {
                          _editTask(task);},
                         icon: const Icon(Icons.edit, color: Colors.blue),),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteTask(task);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          final titleController = TextEditingController();

          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Add Task"),
              content: TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Task title"),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final newTask = TaskModel(
                      userId: widget.user.id,
                      title: titleController.text,
                      createdAt: DateTime.now(),
                    );
                    taskBox.add(newTask);
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );

          setState(() {}); // refresh UI
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
