import 'package:flutter/material.dart';

import '../models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final Function() onPlayPressed;
  final Function() onStopPressed;

  MessageWidget({
    required this.message,
    required this.onPlayPressed,
    required this.onStopPressed,
  });

  @override
  Widget build(BuildContext context) {
    return message.isAudio ? _buildAudioMessage() : _buildTextMessage();
  }

  Widget _buildAudioMessage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black
        ),
        borderRadius: BorderRadius.circular(25),

      ),
      child: Row(
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(message.text),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: onPlayPressed,
          ),
          IconButton(
            icon: Icon(Icons.stop),
            onPressed: onStopPressed,
          ),

        ],
      ),
    );
    // return ListTile(
    //   title: Text(message.text),
    //   trailing: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       IconButton(
    //         icon: Icon(Icons.play_arrow),
    //         onPressed: onPlayPressed,
    //       ),
    //       IconButton(
    //         icon: Icon(Icons.stop),
    //         onPressed: onStopPressed,
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _buildTextMessage() {
    return Container(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        margin: EdgeInsets.all(4),
        color: message.isMe ? Colors.blue : Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message.text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
