// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:audioplayers/audioplayers.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   stt.SpeechToText? _speech;
//   TextEditingController? _controller;
//   AudioPlayer _audioPlayer = AudioPlayer();
//   String userName = '';
//   bool askedForName = false;
//   bool isPlaying = false;

//   List<String> messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _controller = TextEditingController();

//     // Iniciar a conversa com a saudação
//     _addMessage('Bot', 'Bom dia! Qual é o seu nome?');
//   }

//   void _startListening() async {
//     if (!_speech!.isListening) {
//       bool available = await _speech!.initialize(
//         onStatus: (status) {
//           print('Status: $status');
//         },
//         onError: (error) {
//           print('Erro: $error');
//         },
//       );

//       if (available) {
//         _speech!.listen(
//           onResult: (result) {
//             _controller!.text = result.recognizedWords;
//           },
//         );
//       }
//     } else {
//       _speech!.stop();
//     }
//   }

//   Future<void> _playAudioFromNetwork(String audioUrl) async {
//     await _audioPlayer.play(
//       audioUrl,
//       isLocal: false,
//       volume: 1.0,
//       stayAwake: true,
//     );
//     _audioPlayer.onPlayerCompletion.listen((event) {
//       setState(() {
//         isPlaying = false;
//       });
//     });
//     setState(() {
//       isPlaying = true;
//     });
//   }

//   Future<void> _pauseAudio() async {
//     await _audioPlayer.pause();
//     setState(() {
//       isPlaying = false;
//     });
//   }

//   Future<void> _resumeAudio() async {
//     await _audioPlayer.resume();
//     setState(() {
//       isPlaying = true;
//     });
//   }

//   Future<void> _stopAudio() async {
//     await _audioPlayer.stop();
//     setState(() {
//       isPlaying = false;
//     });
//   }

//   void _addMessage(String sender, String text) {
//     setState(() {
//       messages.add('$sender: $text');
//     });

//     // Se a última mensagem foi uma saudação e o nome foi informado,
//     // reproduza a mensagem de áudio inicial
//     if (sender == 'Bot' && text.contains('Seja bem-vindo')) {
//       _playAudioFromNetwork('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
//     }
//   }

//   String generateResponse(String userInput) {
//     if (userInput.toLowerCase().contains('sim') &&
//         userInput.toLowerCase().contains('câncer')) {
//       return 'É triste, mas sim, o câncer é uma doença grave. Como você está se sentindo em relação a isso? Além disso, tenho um recado para você. Escute este áudio:';
//     } else if (userInput.toLowerCase().contains('não') &&
//         userInput.toLowerCase().contains('câncer')) {
//       return 'Fico feliz em ouvir isso! Se precisar de informações sobre saúde, estou aqui para ajudar. Além disso, tenho um recado para você. Escute este áudio:';
//     } else {
//       return 'Desculpe, não entendi. Pode repetir ou fazer outra pergunta relacionada? Além disso, tenho um recado para você. Escute este áudio:';
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat App'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(messages[index]),
//                 );
//               },
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _controller,
//                   decoration: InputDecoration(hintText: 'Digite aqui...'),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(_speech!.isListening ? Icons.mic : Icons.mic_none),
//                 onPressed: _startListening,
//               ),
//               IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: () {
//                   String userInput = _controller?.text ?? '';

//                   // Se ainda não foi perguntado pelo nome
//                   if (!askedForName) {
//                     askedForName = true;

//                     // Salvar o nome do usuário e continuar a conversa
//                     userName = userInput;
//                     _addMessage('Usuário', userInput);
//                     _addMessage('Bot', 'Seja bem-vindo, $userName! Você sabia que no Brasil morre muita gente de câncer? Além disso, tenho um recado para você. Escute este áudio:');
//                   } else {
//                     // Continuar a conversa
//                     String response = generateResponse(userInput);

//                     if (response.isNotEmpty) {
//                       _addMessage('Usuário', userInput);
//                       _addMessage('Bot', response);

//                       // Após a resposta, reproduzir o áudio
//                       _playAudioFromNetwork('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
//                     }
//                   }

//                   // Limpar o campo de texto
//                   _controller!.clear();
//                 },
//               ),
//               if (isPlaying)
//                 IconButton(
//                   icon: Icon(Icons.pause),
//                   onPressed: () {
//                     _pauseAudio();
//                   },
//                 )
//               else
//                 IconButton(
//                   icon: Icon(Icons.play_arrow),
//                   onPressed: () {
//                     _resumeAudio();
//                   },
//                 ),
//               IconButton(
//                 icon: Icon(Icons.stop),
//                 onPressed: () {
//                   _stopAudio();
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
