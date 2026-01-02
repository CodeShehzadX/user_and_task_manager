import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_and_task_manager/providers/user_provider.dart';
import 'package:user_and_task_manager/screens/user_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();

  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=> UserProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UserListsScreen(),
    ),
    );
  }
}

