import 'package:clientphase/chat/chat_api.dart';
import 'package:clientphase/chat/message.dart';
import 'package:clientphase/chat/user_chat.dart';
import 'package:clientphase/models/user_model.dart';
import 'package:clientphase/services/api/profile_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // get instance of firestore
  final _firestore = FirebaseFirestore.instance;
  final ChatApi _chateApi = ChatApi();
  
  final User user;
  ChatService({required this.user}); //{
  //   _profileApi.getMe().then((value) {
  //   user =  User.fromJson(value.data["data"]);
  //   });
  // }

  // get user messages
  Future<void> getUserChats() async {
    try {
      final chats = await _chateApi.getAllUserChats();
      List<UserChat> allChats = chats.data["data"];
      // mosalam
    } catch (e) {
      print("Error in getting users chat in chat service ----- $e");
    }
  }

  // create new Chat
  Future<void> createNewChat(String reciverID) async {
    try {
      await _chateApi.createNewUserChat(reciverID);
      // mosalam
    } catch (e) {
      print("Error in creating user new chat in chat service ----- $e");
    }
  }

  // send message
  Future<void> sendMessage(String reciverID, message) async {
    // get current user info
    final String currentUserID =
        user.id; // get current user id from profileProvider
    final String currentUserEmail =
        user.email; // get current user email from profileProvider
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        reciverID: reciverID,
        message: message,
        timestamp: timestamp);

    // construct chat chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, reciverID];
    ids.sort(); // sort the ids (this ensure chatroomID)
    String chatroomID = ids.join("_");

    // add new messages to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatroomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String otherUserID) {
    final userID = user.id;

    print("$userID ---- $otherUserID");
    // construct chat chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [userID, otherUserID];
    ids.sort(); // sort the ids (this ensure chatroomID)
    String chatroomID = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatroomID)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
