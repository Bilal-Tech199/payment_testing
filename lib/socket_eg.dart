import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketEGView extends StatefulWidget {
  const SocketEGView({super.key});

  @override
  State<SocketEGView> createState() => _SocketEGViewState();
}

class _SocketEGViewState extends State<SocketEGView> {
  late Socket socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  connect() {
     socket = io(
        'http://103.149.165.142:9091',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.emit("addUser", 1);
    socket.onConnect((data) {
      print("connected");
      socket.on("getMessage", (msg) {
        print(msg);
        // setMessage("destination", msg["message"]);
        // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
  }

  void sendMessage(
      {required String senderId, required String receiverId, required String text, required String messageType,}) {
    // setMessage("source", message);
    socket.emit("sendMessage", {
      "senderId": senderId,
      "receiverId": receiverId,
      "text": text,
      "messageType": messageType
    });
  }

  // void setMessage(String type, String message) {
  //   MessageModel messageModel = MessageModel(
  //       type: type,
  //       message: message,
  //       time: DateTime.now().toString().substring(10, 16));
  //   print(messages);
  //
  //   setState(() {
  //     messages.add(messageModel);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      bottomNavigationBar: Center(
        child: RawMaterialButton(
          onPressed: () {
              sendMessage(senderId: "1",receiverId: "2",text: "Hello world",messageType: "text");
          },
          child: Text("Send Message"),
        ),
      ),
    );
  }
}
