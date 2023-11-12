class Message {
  final String text;
  final bool isMe;
  final bool isAudio;
  final String audioSrc;

  Message({
    required this.text,
    required this.isMe,
    this.isAudio = false,
    this.audioSrc = '',
  });
}
