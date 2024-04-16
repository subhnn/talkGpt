
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkgpt/homepage.dart';
import 'package:talkgpt/services.dart';
import 'package:talkgpt/signup.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController email1=new TextEditingController();
  TextEditingController pass1=new TextEditingController();

  void SendValuesToApi() async {
    final response = await SecurityApiService().SecurityloginData(email1.text, pass1.text);
    if(response["status"]=="success")
    {
      String securityId=response["userdata"]["_id"].toString();
      SharedPreferences.setMockInitialValues({});
      SharedPreferences preferences=await SharedPreferences.getInstance();
      preferences.setString("securityId", securityId);
      print("successfully login");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>homepage()));
    }
    else if(response["status"]=="invalid email")
    {
      print("Invalid email id");
    }
    else if(response["status"]=="invalid password")
    {
      print("Invalid password");
    }
    else
    {
      print("Error");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white.withOpacity(0.3),Colors.white
                  ]
              )
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              // Text("Sign In here !",style: TextStyle(color: Colors.white,fontSize: 22),),
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
                controller: email1,
                style: TextStyle(color: Colors.black, fontFamily: 'Cera Pro',),
                decoration: InputDecoration(
                    labelText: "Email ID",
                    hintText: "Enter email id",
                    prefixIcon:   Icon(Icons.email_outlined,color: Color(0xFF009999),size: 27,),
                    labelStyle: TextStyle(color: Colors.black, fontFamily: 'Cera Pro',),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF009999))
                    )
                ),
              ),
              SizedBox(height: 35,),
              SizedBox(width: 10,),
              TextField(
                controller: pass1,
                obscureText: true,
                style: TextStyle(color: Colors.black, fontFamily: 'Cera Pro',),

                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter valid password",
                    prefixIcon:  Icon(Icons.lock_outline,color: Color(0xFF009999),size: 27,),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF009999))
                    )
                ),
              ),
              SizedBox(height: 55,),
              SizedBox(
                height: 45,
                width: 200,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF009999)),
                        foregroundColor: Color(0xFF009999),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    onPressed: SendValuesToApi,
                    child: Text("SIGN IN",style: TextStyle(fontWeight: FontWeight.bold),)),
              ),
              SizedBox(height: 25,),
              SizedBox(
                height: 45,
                width: 200,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF009999)),
                        foregroundColor: Color(0xFF009999),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                    },
                    child: Text("SIGN UP",style: TextStyle(fontWeight: FontWeight.bold),)),
              ),
              SizedBox(height: 105,),

            ],
          ),
        ),


      )

    );

  }
}
