import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_and_task_manager/providers/user_provider.dart';
import 'user_detail_screen.dart';


class UserListsScreen extends StatefulWidget {
  const UserListsScreen({super.key});

  @override
  State<UserListsScreen> createState() => _UserListsScreenState();
}

class _UserListsScreenState extends State<UserListsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().LoadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    if (provider.isLoading){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),

      );

    }

    if (provider.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(provider.errorMessage!)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Users"),),
      body: ListView.builder(
          itemCount: provider.users.length,
          itemBuilder: (context, index){
            final user = provider.users[index];
            return ListTile(
              title: Text("${user.name}"),
              subtitle: Text("${user.email}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserDetailScreen(user: user),
                  ),
                );
              }
            );
    }

    )
    );
  }
}
