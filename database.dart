import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByName(String userName) async {
    return await Firestore.instance
        .collection('users')
        .where('userName', isGreaterThanOrEqualTo: userName)
        .getDocuments();
  }

  QuerySnapshot snapshot;
  lookingForMembers(String members) {
    if (members == members) {
      return Firestore.instance
          .collection('members')
          .where('nameOfMbr', isEqualTo: members)
          .getDocuments();
    }
  }

  getUserByEmail(String userEmail) {
    return Firestore.instance
        .collection('users')
        .where('userEmail', isEqualTo: userEmail)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection('users').add(userMap);
  }

  addUser(addUser) {
    Firestore.instance.collection('members').add(addUser);
  }

  createChatRoom(String chatRoomId, chatMap) {
    Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .setData(chatMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  createMembersRoom(String membersRoomId, memberMap) {
    Firestore.instance
        .collection('members')
        .document(membersRoomId)
        .setData(memberMap);
  }

  addMessageConversation(String chatRoomId, messageMap) {
    Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addMembersConversation(String chatRoomId, messageMap) {
    Firestore.instance
        .collection('members')
        .document(chatRoomId)
        .collection('memberschats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getMessageConversation(String chatRoomId) async {
    return await Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }

  getMembersConversation(String chatRoomId) async {
    return await Firestore.instance
        .collection('members')
        .document(chatRoomId)
        .collection('memberschats')
        .orderBy('time', descending: false)
        .snapshots();
  }

  getChatRoom(String userName) async {
    return await Firestore.instance
        .collection('chatRoom')
        .where('users', arrayContains: userName)
        .snapshots();
  }

  getMembersRoom(String userName) async {
    return await Firestore.instance
        .collection('members')
        .where('members', arrayContains: userName)
        .snapshots();
  }
}
