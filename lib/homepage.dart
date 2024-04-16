import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:talkgpt/feature_box.dart';
import 'package:talkgpt/history.dart';
import 'package:talkgpt/openaiservices.dart';
import 'package:talkgpt/pallete.dart';
import 'package:talkgpt/services.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  final flutterTts= FlutterTts();
  final speechToText=SpeechToText();
  final OpenAiService openAiService= OpenAiService();
  //bool speechEnabled = false;
  String lastWords= '';
  String? generatedContent;
  String? generatedImageUrl;
  int start=200;
  int delay=200;
  // final TextEditingController _speechTextController = TextEditingController();


  @override

  // void handleMenuClick(String value) {
  //   switch (value) {
  //     case 'History':
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => HistoryScreen()),
  //       );
  //       break;
  //   }
  // }

  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }
  Future <void> initTextToSpeech() async{

  await flutterTts.setSharedInstance(true);
  setState(() {});

  }
  Future <void> initSpeechToText() async {
    speechToText.initialize();
    setState(() {});
  }

  Future <void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      print(lastWords);
    });
  }

  void addspeech() async{
    SharedPreferences prefer=await SharedPreferences.getInstance();
    String userId=prefer.getString("securityId")?? "";


    final response= SecurityApiService().addSpeechApi(userId, lastWords);
  }

  Future<void>systemSpeak(String content) async{
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TalkGpt"),
          centerTitle: true,
          leading: const Icon(Icons.menu),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                // Here you can define what happens when the button is tapped.
                // For example, navigate to a history screen.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewVisitor()),
                );
              },
            ),
          ],
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/images/customer-service.png',
                    )
                    ),
        
                  ),
        
                )
              ],
            ),
            //chat bubble
            Visibility( visible: generatedImageUrl==null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,

                ),
                margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.borderColor
                  ),

                  borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero)
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child:  Text( generatedContent==null ?" Hi There what can do for you today!!!"
                    : generatedContent!,
                  style:  TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: generatedContent==null ? 25:18,
                      color: Pallete.mainFontColor,

                  ),
                  ),
                ),

              ),
            ),
            // suggestions
             //dall-e

            if(generatedImageUrl!=null)
              Padding(padding: EdgeInsets.all(10.0), child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(generatedImageUrl!))),

            Visibility(visible: generatedContent==null && generatedImageUrl==null,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                margin:const EdgeInsets.only(top: 10,left: 22),
                child: const Text("Here are some Features",
                  style:  TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: 20,
                      color: Pallete.mainFontColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            //feature list

                 Visibility( visible: generatedContent==null && generatedImageUrl==null,
                   child: Column(
                     children: [

                          SlideInLeft(delay: Duration(milliseconds: start),
                            child: const FeatureBox
                             (color: Pallete.firstSuggestionBoxColor, headerText: 'ChatGpt',descriptionText: "A smarter way to stay organized and informed with ChatGPT", ),
                          ),


                    
                    SlideInLeft(delay: Duration(milliseconds: start + delay),
                      child: const FeatureBox(
                        color: Pallete.secondSuggestionBoxColor, headerText: 'Dall-E',descriptionText: "Get inspired and stay creative with your personal assistant powered by Dall-E",),
                    ),
                    SlideInLeft(delay: Duration(milliseconds: start + 2*delay),
                      child: const FeatureBox(
                        color: Pallete.thirdSuggestionBoxColor, headerText: 'Smart Voice Assistance',descriptionText: "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT",),
                    ),


                                   ],
                                 ),
                 ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: TextField(
            //     controller: _speechTextController,
            //     decoration: InputDecoration(
            //       labelText: 'Speech to Text',
            //       border: OutlineInputBorder(),
            //     ),
            //     readOnly: true, // Make the text field read-only
            //     maxLines: null, // Allow unlimited lines for the text field
            //   ),
            // ),

          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ZoomIn(
            child: FloatingActionButton(
              onPressed: () async {
                if (await speechToText.hasPermission && speechToText.isNotListening) {
                  await startListening();
                } else if (speechToText.isListening) {
                  final speech = await openAiService.isArtPromptApi(lastWords);
                  if (speech.contains('https')) {

                    generatedImageUrl = speech;
                    generatedContent = null;

                    //setState(() {});

                  } else {
                    generatedImageUrl = null;
                    generatedContent = speech;
                    print(speech);
                    setState(() {});

                    // if (generatedImageUrl == null) {
                    await systemSpeak(speech);
                    // }
                  }
                  setState(() {});
                }
                addspeech();
              },
              child: Icon(speechToText.isNotListening ? Icons.mic_off : Icons.mic),
            ),
          ),
          SizedBox(width: 10),
          ZoomIn(
            child: FloatingActionButton(
              onPressed: () async {
                speechToText.stop();
                flutterTts.stop();

                },
            
              //backgroundColor: Pallete.firstSuggestionBoxColor, // Change color to indicate stopping
              child: Icon(Icons.stop),
            ),
          ),
        ],
      ),

    );
  }
}
