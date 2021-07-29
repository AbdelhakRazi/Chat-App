import 'package:chat_app/AuthManagment/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void addUser(em, pass, uid, name) async {
    await _firestore
        .collection("Users")
        .doc(uid)
        .set({"email": em, "password": pass, "uid": uid, "name": name});
  }

  Future sendMessage(Message mess, String uid1, String uid2) async {
    String chatid;
    if (uid1.substring(0, 1).codeUnitAt(0) >
        uid2.substring(0, 1).codeUnitAt(0)) {
      chatid = "$uid2\_$uid1";
    } else {
      chatid = "$uid1\_$uid2";
    }
    var docref = await _firestore.collection("chatroom");
    await docref.doc(chatid).set({"id": chatid});
    await docref.doc(chatid).collection("messages").add({
      "by": mess.sender,
      "message": mess.message,
      "time": mess.time,
    });
  }

  Stream<QuerySnapshot> showUsers(String _name) {
    if (_name.isEmpty) {
      return _firestore.collection("Users").snapshots();
    } else {
      return _firestore
          .collection("Users")
          .where("name", isEqualTo: _name)
          .snapshots();
    }
  }

  Stream<QuerySnapshot> showMessages(String chatid) {
    var snapshot = _firestore.collection("chatroom").doc(chatid);
    return snapshot
        .collection("messages")
        .orderBy("time", descending: true)
        .snapshots();
  }
}
