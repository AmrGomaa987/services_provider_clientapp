import 'dart:async';

import 'package:clientphase/chat/chat_service.dart';
import 'package:clientphase/chat/user_chat.dart';
import 'package:clientphase/models/user_model.dart';
import 'package:clientphase/noconn.dart';
import 'package:clientphase/services/api/profile_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final UserChat? userchat;
  final String? username;

  ChatScreen({Key? key, required this.receiverId, this.userchat, this.username}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  late User _currentUser;
  late ChatService _firebaseService;
  StreamSubscription<QuerySnapshot>? _messageSubscription;

  @override
  void initState() {
    super.initState();
    _getUser().then((user) {
      setState(() {
        _currentUser = user;
        _firebaseService = ChatService(user: _currentUser);
        _subscribeToMessages();
      });
    });
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }

  Future<User> _getUser() async {
    final ProfileApi _profileApi = ProfileApi();
    final response = await _profileApi.getMe();
    return User.fromJson(response.data["data"]);
  }

  void _sendMessage(ChatService chat) async {
    if (_textController.text.isNotEmpty) {
      await chat.sendMessage(widget.receiverId, _textController.text);
      _textController.clear();
    }
  }

  void _subscribeToMessages() {
    _messageSubscription = _firebaseService.getMessages(widget.receiverId).listen((snapshot) {
      // Handle message stream updates here, e.g., updating UI or handling new messages.
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.username ?? widget.userchat?.name ?? 'لا يوجد'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
            backgroundColor: Colors.white, // Set background to white
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.username ?? widget.userchat?.name ?? 'لا يوجد'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
            backgroundColor: Colors.white, // Set background to white
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.username ?? widget.userchat?.name ?? 'لا يوجد'),
            ),
            body: const Center(
              child: Text('User data is not available.'),
            ),
            backgroundColor: Colors.white, // Set background to white
          );
        }

        final User user = snapshot.data!;
        final ChatService firebaseService = ChatService(user: user);

        return  StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data==ConnectivityResult.none?
          const NoConnectionWidget()
          : 
         Scaffold(
          appBar: AppBar(
            title: Text(widget.username ?? widget.userchat?.name ?? 'لا يوجد'),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: firebaseService.getMessages(widget.receiverId),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('لا توجد رسائل متاحة.'),
                      );
                    }

                    final messages = snapshot.data!.docs;

                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final bool isSentByCurrentUser = message['senderID'] == user.id;

                        return Align(
                          alignment: isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: isSentByCurrentUser ? Color(0xFF7210ff) : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              message['message'],
                              style: TextStyle(
                                color: isSentByCurrentUser ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelText: 'ارسل رسالة...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFF7210ff)),
                      onPressed: () => _sendMessage(firebaseService),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white, // Set background to white
        );
       }); },
    );
  }
}
