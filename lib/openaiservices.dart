import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:talkgpt/secretapi.dart';

class OpenAiService {
  final List<Map<String,String>> messages=[];
  Future<String> isArtPromptApi(String prompt) async
  {
    try{
      //print(prompt);
      final res= await  http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openApiKey'
      },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": "Does this message want to generate an AI picture,image,art or anything? $prompt.simply answer with a Yes or NO",

            }
          ],
        })

      );
      print(res.body);
      if (res.statusCode==200){
        String content=jsonDecode(res.body)['choices'][0]['message']['content'];
        content=content.trim().toLowerCase();

        if(content =='yes')
          {
            return await dallEApi(prompt);
          }
        else
          {
            return await chatGptApi(prompt);
          }

        // switch(content){
        //   case 'Yes':
        //   case 'yes':
        //   case 'Yes.':
        //   case 'yes.':
        //     final res= await dallEApi(prompt);
        //     return res;
        //
        //   default :
        //     final res=await chatGptApi(prompt);
        //     return res;
        // }
      }
      return 'internal error occured';
    }
    catch(e)
    {
      return e.toString();
    }

  }
  Future<String> chatGptApi(String prompt) async{
    messages.clear();
    messages.add({
      'role':'user',
      'content': prompt,
    });

    try{
      final res= await  http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openApiKey'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": messages,
          })

      );

      if (res.statusCode==200){
        String content=jsonDecode(res.body)['choices'][0]['message']['content'];
        content=content.trim();
         messages.add({
           'role':'assistant',
           'content': content,
         });
         return content;
      }
      return 'internal error occured';
    }
    catch(e)
    {
      return e.toString();
    }


  }
  Future<String> dallEApi(String prompt) async{
    messages.add({
      'role':'user',
      'content': prompt,
    });

    try{
      final res= await  http.post(Uri.parse('https://api.openai.com/v1/images/generations'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openApiKey'
          },
          body: jsonEncode({
           'prompt':prompt,
            'n':1,

          }),

      );

      if (res.statusCode==200){
        String imageUrl=jsonDecode(res.body)['data'][0]['url'];
        imageUrl=imageUrl.trim();

        messages.add({
          'role':'assistant',
          'content': imageUrl,
        });
        return imageUrl;
      }
      return 'internal error occured';
    }
    catch(e)
    {
      return e.toString();
    }

  }


}