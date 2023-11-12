import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


import '../Widgets/message_mannager.dart';
import '../Widgets/message_widget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final MessageManager _messageManager = MessageManager();
  final TextEditingController _textController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _messageManager.startConversation();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _messageManager.messages.length,
                itemBuilder: (context, index) {
                  final message = _messageManager.messages[index];
                  return MessageWidget(
                    message: message,
                    onPlayPressed: () => _playAudio(message.audioSrc),
                    onStopPressed: _stopAudio,
                  );
                },
              ),
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Digite sua mensagem...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messageManager.userSendMessage(text);
        _textController.clear();
      });
    }
  }

  void _playAudio(String audioSrc) async {
    await _audioPlayer.play(AssetSource(audioSrc));
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseAudio() {
    _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _stopAudio() {
    _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _stopAudio();
    }
  }
}
