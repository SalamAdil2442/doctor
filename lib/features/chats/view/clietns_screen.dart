import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/chats/data_source/remote_chat.dart';
import 'package:tandrustito/features/chats/view/chat_screen.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/status_widgets/loading_widget.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<UserModel>>(
        future: RemoveCHatSource.instance.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Text((snapshot.error?.toString() ?? "")),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    context.to(ChatScreen(
                        title: snapshot.data![index].name,
                        collectionId: snapshot.data![index].uuid,
                        userModel: UserModel(name: "Admin", uuid: "uuid")));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(snapshot.data![index].name),
                  ),
                ),
              );
            },
          );
        },
      ),
      appBar: AppBar(title: Text(Trans.users.trans())),
    );
  }
}
