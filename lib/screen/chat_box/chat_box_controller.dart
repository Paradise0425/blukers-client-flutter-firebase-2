import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:blukers_client_app/common/widgets/helper.dart';
import 'package:blukers_client_app/screen/chat_box_user/chat_box_usercontroller.dart';
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';
import 'package:blukers_client_app/utils/string.dart';
import 'chat_box_live_screen.dart';

ChatBoxUserController chatBoxUserController = Get.put(ChatBoxUserController());

class ChatBoxController extends GetxController implements GetxService {
  TextEditingController searchController = TextEditingController();
  RxInt selectedJobs = 0.obs;
  RxBool loader = false.obs;
  String? roomId;
  DateTime lastMsg = DateTime.now();
  TextEditingController msController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  List countM = [];
  List dataChat = [];

  RxString searchText = ''.obs;

  RxList jobs = [
    Strings.allChat,
    Strings.unread,
    Strings.archived,
  ].obs;

  onTapJobs(int index) {
    selectedJobs.value = index;
    update(["searchChat"]);
  }

  int currentTab = 0;

  void onBottomBarChange(int index) {
    currentTab = index;
    if (index == 0) {
      debugPrint("INDEX IS 0");

      // homeController.init();
    } else if (index == 1) {
      debugPrint("INDEX IS 1");
      // searchController.init();
    } else if (index == 2) {
      debugPrint("INDEX IS 2");
      Get.put(ChatBoxController());
      // messageController.init();
    } else {
      debugPrint("INDEX IS 3");
      // profileController.init();
    }
    update(['bottom_bar']);
  }

  bool validation() {
    if (msController.text.isEmpty) {
      if (kDebugMode) {
        print("Please enter message");
      }

      return false;
    }
    return true;
  }

  String userUid = PrefService.getString(PrefKeys.userId).toString();

  String getChatId(String uid1, String uid2) {
    if (uid1.hashCode > uid2.hashCode) {
      return '${uid1}_$uid2';
    } else {
      return '${uid2}_$uid1';
    }
  }

  getRoomId(String otherUi) async {
    String otherUid = otherUi;

    DocumentReference doc = FirebaseFirestore.instance
        .collection("chats")
        .doc(getChatId(PrefService.getString(PrefKeys.userId), otherUid));

    await doc
        .collection(getChatId(userUid, otherUid))
        .get()
        .then((value) async {
      DocumentSnapshot<Object?> i = await doc.get();
      if (i.exists == false) {
        await doc.set({
          "uidList": [userUid, otherUid],
        });
      }
      if (value.docs.isNotEmpty) {
        roomId = getChatId(userUid, otherUid);
      } else {
        await FirebaseFirestore.instance
            .collection("chats")
            .doc(getChatId(userUid, otherUid))
            .collection(getChatId(userUid, otherUid))
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            roomId = getChatId(userUid, otherUid);
          } else {
            roomId = getChatId(userUid, otherUid);
          }
        });
      }
    });
  }

  void gotoChatScreen(
      BuildContext context, String otherUid, name, deviceToken) async {
    loader.value = true;
    await getRoomId(otherUid);
    loader.value = false;

    Get.to(() => ChatBoxLiveScreenM(
        roomId: roomId,
        name: name,
        otherUserUid: otherUid,
        userUid: userUid,
        deviceToken: deviceToken));
  }

  int? msgCount;

  void sendMessage(String roomId, otherUid) async {
    if (isToday(lastMsg) == false) {
      await sendAlertMsg();
    }

    String msg = msController.text;

    await FirebaseFirestore.instance
        .collection("chats")
        .doc(getChatId(userUid, otherUid))
        .get()
        .then((value) {
      if (value['countM'] == null) {
        countM.add(msg);
      } else {
        msgCount = value['countM'];
        if (msgCount == null) {
          countM = [];
          countM.add(msg);
        } else {
          if (kDebugMode) {
            print(msgCount);
          }

          countM.add(msg);
        }

        if (kDebugMode) {
          print(countM);
        }
      }
    });

    setLastMsgInDoc(msg);
    await setMessage(roomId, msg, userUid);

    update(['message']);
  }

  Future<void> setMessage(String roomId, msg, userUid) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomId)
        .collection(roomId)
        .doc()
        .set({
      "content": msg,
      "type": "text",
      "senderUid": userUid,
      "time": DateTime.now(),
      "read": false,
    });
    msController.clear();
    update(['message']);
  }

  Future<void> deleteUserChat(String otherUid) async {
    await FirebaseFirestore.instance.collection("chats").doc(roomId).delete();

    update(["message"]);
  }

  Future<void> lastMessageTrue(String otherUid) async {
    countM = [];
    chatBoxUserController.countU = [];
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(getChatId(userUid, otherUid))
        .update({"lastMessageRead": true, "countU": null});
  }

  Future<void> setReadTrue(String docId) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomId)
        .collection(roomId!)
        .doc(docId)
        .update({"read": true});
    //await setReadInChatDoc(true);
  }

  Future<void> setLastMsgInDoc(String msg) async {
    if (kDebugMode) {
      print(countM.length);
    }
    await FirebaseFirestore.instance.collection("chats").doc(roomId).update({
      "lastMessage": msg,
      "lastMessageSender": userUid,
      "lastMessageTime": DateTime.now(),
      "lastMessageRead": false,
      "countM": countM.length,
      "deviceTokenM": PrefKeys.deviceToken
    });
  }

  Future<void> sendAlertMsg() async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomId)
        .collection(roomId!)
        .doc()
        .set({
      "content": "new Day",
      "senderUid": userUid,
      "type": "alert",
      "time": DateTime.now()
    });
  }

  /*Future<void> setReadInChatDoc(bool status) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(roomId)
        .update({"lastMessageRead": status});
  }*/

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }
}
