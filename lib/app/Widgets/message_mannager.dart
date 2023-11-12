import '../models/message_model.dart';

class MessageManager {
  final List<Message> _messages = [];
  bool _userNameProvided = false;

  List<Message> get messages => _messages;

  void startConversation() {
    _addAssistantMessage('Olá! Seja bem-vindo. Qual é o seu nome?');
  }

  void userSendMessage(String text) {
    if (!_userNameProvided) {
      _userNameProvided = true;

      _addUserMessage(text);
      _addAssistantMessage('É muito bom ter você aqui, $text!');
      _addAssistantMessage(
        'Infelizmente, o câncer é uma das doenças que mais mata no Brasil.',
      );
      _sendAudioMessage('audios/audio1.mp3');
    } else {
      _addUserMessage(text);
      _simulateAssistantReply(text);
    }
  }

  void _simulateAssistantReply(String userMessage) {
    // Simula a resposta do assistente virtual
    Future.delayed(Duration(seconds: 1), () {
      _addAssistantMessage('Desculpe, estou apenas simulando uma conversa.');
    });
  }

  void _sendAudioMessage(String audioSrc) {
    _messages.add(
        Message(isAudio: true, isMe: false, audioSrc: audioSrc, text: 'Áudio'));
  }

  void _addUserMessage(String text) {
    _messages.add(Message(text: text, isMe: true));
  }

  void _addAssistantMessage(String text) {
    _messages.add(Message(text: text, isMe: false));
  }
}