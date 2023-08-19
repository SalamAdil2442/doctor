import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/chats/model/message.dart';
import 'package:tandrustito/features/chats/view/chat_screen.dart';

class RemoveCHatSource extends ChangeNotifier {
  static final RemoveCHatSource _singleton = RemoveCHatSource._();
  static RemoveCHatSource get instance => _singleton;
  RemoveCHatSource._();
  Status status = Status.initial;
  List<MessageModel> list = [];
  StreamSubscription<DatabaseEvent>? steam;
  Future getMessages(String userId) async {
    steam?.cancel();
    status = Status.initial;
    list = [];
    notifyListeners();
    steam = FirebaseDatabase.instance
        .ref("messages")
        .child(userId)
        .orderByChild("date")
        .onChildAdded
        .listen((event) {
      logger("event ${event.snapshot.ref.key} ${event.snapshot.value}");
      final model = MessageModel.fromMap(Map<String, dynamic>.from(
          ((event.snapshot.value as Map<dynamic, dynamic>))));
      list.add(model);
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
      notifyListeners();
    });
  }

  Future addMessage(String collectionId, String userId, String text) async {
    try {
      await FirebaseDatabase.instance
          .ref("messages")
          .child(collectionId)
          .child(generateUid())
          .set(MessageModel(senderId: userId, text: text, date: DateTime.now())
              .toMap());
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    } catch (e) {
      logger(e);
    }
  }

  Future createUser(UserModel user) async {
    SharedPrefsHalper.instance.setUser(user);
    try {
      await FirebaseDatabase.instance
          .ref("clients/${user.uuid}")
          .set(user.toMap());
      logger("saved");
    } catch (e, c) {
      logger(e);
      recoredError(e, c);
    }
  }

  Future<List<UserModel>> getUsers() async {
    {
      final res = await FirebaseDatabase.instance.ref("clients").get();

      return (res.children.map((e) {
        return UserModel.fromMap(
            Map<String, dynamic>.from(((e.value as Map<dynamic, dynamic>))));
      }).toList());
    }
  }
}
