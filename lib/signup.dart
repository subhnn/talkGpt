import 'package:flutter/material.dart';
import 'package:talkgpt/services.dart';
class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  void SendVluesToApi() async{
    final response=await SecurityApiService().addSecurityApi(name1.text, phone1.text, email1.text, pass1.text);

    if(response["status"]=="success")
    {
      print("successfully added");
    }

  }
  @override
  TextEditingController name1= new TextEditingController();

  TextEditingController phone1= new TextEditingController();
  TextEditingController email1= new TextEditingController();
  TextEditingController pass1= new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
        title: Text("Register Here",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF027A7A),
      ),
      body:
      SingleChildScrollView(


        child: Container(

          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 40,),
              Container(
                height: 123,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/images/images.png',
                  )
                  ),

                ),

              ),
              SizedBox(height: 40,),
              TextField(
                controller: name1,
                decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Enter name",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: phone1,
                decoration: InputDecoration(
                    labelText: "Phone No",
                    hintText: "Enter contact number",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: email1,
                decoration: InputDecoration(
                    labelText: "Email Id",
                    hintText: "Enter email id",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: pass1,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter password",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 35,),
              SizedBox(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF027A7A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      onPressed: SendVluesToApi, child: Text("REGISTER"))),
            ],
          ),
        ),
      ),


    );
  }
}
