import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import "user_ui.dart";
import "netwrk.dart";

late var screenSize;
late var screenWidth; 
late var screenHeight;
//bool active_form = true;
void main() async {
  dynamic json_data = await getData();
  int user_stat = json_data["status"];
  switch(user_stat)
  {
    case 201:
      runApp(const MainApp());
    break;

    case 200:
     runApp(const MainApp());
    break;

    default:
     runApp(const MainApp());
  }
  
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context)
  {
    screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    return MaterialApp(title: "Wevuuge", 
      home: Scaffold(appBar: AppBar(
    title: Text('WEVUGE'),backgroundColor: Color.fromARGB(249, 4, 48, 116)),
        body: Div_master(),
      ),
    );
  }
}

class Div_master extends StatelessWidget
{
  
  
  @override
  Widget build(BuildContext context)
  {
     
     

    return Container(
  width: (screenWidth),
  height: (screenHeight),
  color: Colors.black,
  child: ListView
        (
            children: [Head_div(),Login_master_div()],
        ),
);
  }
}

class Head_div extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return Container( width: (screenWidth),height: (50),color: Colors.black,
        child: Center(
          child: Text('WELCOME TO WEVUUGGE', style: TextStyle(color: Colors.white,fontSize:(screenHeight/screenWidth)*(15),fontWeight: FontWeight.bold)))
    );
  }
}

class Login_master_div extends StatefulWidget
{
  @override
  Login_master_state createState()
  {
    return Login_master_state();
  }
}

class Login_master_state extends State<Login_master_div>
{
  
   bool active_form = true;

   void changeState()
   {
      setState(()
                        {
                        active_form = !active_form;
                        });
   }

  @override
  Widget build(BuildContext context)
  {
    return Center
          (
            child: Container
                  (
                      margin: EdgeInsets.only(top: screenHeight*0.04),
                      width: (screenWidth*0.8),
                      height: (screenHeight*0.6),
                      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                      child: ListView(
                      children: [active_form==true? Login_Reg_form(screenWidth*0.8,screenHeight*0.5,onPressed:()=>changeState()): Reg_login_form(screenWidth*0.8,screenHeight*0.5,onPressed: ()=>changeState())]
                  ))
          );
  }
}

class Login_Reg_form extends StatefulWidget
{
  late var active_width;
  late var active_height;
  late var onPressed;
  Login_Reg_form(this.active_width,this.active_height,{required this.onPressed})
    {

    }
  
  @override
  Login_Reg_form_state createState()
  {
    return Login_Reg_form_state(active_width,active_height,onPressed:onPressed);
  }
}

class Login_Reg_form_state extends State<Login_Reg_form>//StatelessWidget
{
    late double active_width;
    late double active_height;
    final VoidCallback onPressed;

    TextEditingController telno_ctrl = TextEditingController();
    TextEditingController passcode_ctrl = TextEditingController();

    Login_Reg_form_state(var width,height,{required this.onPressed})
    {
        active_height = height;
        active_width  = width;
    }

    Future<void> getdata() async
    {
      var poste = 
                        {
                          "telephone":telno_ctrl.text,
                          "passcode":passcode_ctrl.text
                        };
       dynamic json_dta = await postData("login",poste);
                        
                        int json_dta_stat = json_dta["status"];
                        //String unames = json_dta["user_names"];
                        if(json_dta_stat==200)
                        {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>User("user",(telno_ctrl.text),"customer",screenWidth,screenHeight)));
                        }
                        else
                        {
                          print(json_dta["message"]);
                        }
    }

    @override
    Widget build(BuildContext context)
    {
        return Column
                (
                  children: 
                  [
                    Container
                    (
                      width : active_width*(0.5),
                      height: active_height*(0.1),
                      color: Colors.black,
                      child:  Center(child: Text('Please Fill the form below!', style: TextStyle(color: Colors.white,fontSize: (screenHeight/screenWidth)*(10))))

                    ),
                    Container
                    (
                        
                        width:  active_width*0.8,
                        height: active_height*0.2,
                        child: TextField
                        (
                          keyboardType: TextInputType.number,
                          controller: telno_ctrl,
                          decoration: InputDecoration
                                                    (
                                                      labelText: "Please Enter Phone Number: ",
                                                      hintText: "Phone Number",
                                                      //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                                      prefixIcon: Icon(Icons.text_fields),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                        )
                    ),
                    Container
                    (
                        margin: EdgeInsets.only(top: screenHeight*0.02),
                        width:  active_width*0.8,
                        height: active_height*0.2,
                        child: TextField
                        (
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: passcode_ctrl,
                          decoration: InputDecoration
                                                    (
                                                      labelText: "Please Enter Password: ",
                                                      hintText: "Password",
                                                      //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                                      prefixIcon: Icon(Icons.text_fields),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                        )
                    ),
                    ElevatedButton
                    (
                      
                      style: ElevatedButton.styleFrom(primary: Color.fromARGB(249, 4, 48, 116)),
                      onPressed: ()
                      {
                        /*
                        var poste = 
                        {
                          "telephone":telno_ctrl.text,
                          "passcode":passcode_ctrl.text
                        };
                        dynamic json_dta = await postData("login",poste);
                        
                        int json_dta_stat = json_dta["status"];

                        if(json_dta_stat==200)
                        {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>User("Aivan",(telno_ctrl.text),"customer",screenWidth,screenHeight)));
                        }
                        else
                        {
                          print(json_dta["message"]);
                        }
                        */
                        getdata();
                      },
                      child: Text('LOGIN')
                    ),
                    Container
                    (
                      child:Text("Don't Have Account???\n Click Below To Create An Account:", style: TextStyle(color: Colors.white,fontSize: (active_height/active_width)*18))
                    ),

                    ElevatedButton
                    (
                      
                      style: ElevatedButton.styleFrom(primary: Color.fromARGB(249, 4, 48, 116)),
                      onPressed: onPressed,
                      /*()
                      {

                      },
                      */
                      child: Text('CREATE ACCOUNT')
                    ),
                  ],
                );
    }
}

class Reg_login_form extends StatefulWidget
{
  late double active_width;
    late double active_height;
    final VoidCallback onPressed;
   // var selectedValue = "mice";
    Reg_login_form(this.active_width,this.active_height,{required this.onPressed})
    {
        //active_height = height;
        //active_width  = width;
    }
  @override
  Reg_login_form_vw createState()
  {
    return Reg_login_form_vw(active_width,active_height,onPressed: onPressed);
  }
}

class Reg_login_form_vw extends State<Reg_login_form>//lessWidget
{
    late double active_width;
    late double active_height;
    final VoidCallback onPressed;
    var selectedValue = "customer";
    TextEditingController names_ctrl = TextEditingController();
   
    TextEditingController telno_ctrl = TextEditingController();
    TextEditingController passcode_ctrl = TextEditingController();


    Reg_login_form_vw(var width,height,{required this.onPressed})
    {
        active_height = height;
        active_width  = width;
    }

    void toggleChange(value)
    {
      setState(() {
        selectedValue = value;
      });
    }



    Future<void> getdata() async
    {
      print("posting data");
      var poste = 
                        {
                          "name":names_ctrl.text,
                          "telephone":telno_ctrl.text,
                          "passcode":passcode_ctrl.text,
                          "user_type":selectedValue
                        };
       dynamic json_dta = await postData("register",poste);
                        
                        int json_dta_stat = json_dta["status"];
                        String user_names = names_ctrl.text;
                        String telephone = telno_ctrl.text;
                        if(json_dta_stat==200)
                        {
                           if(selectedValue=="customer")
                           {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>User(user_names,(telephone),"customer",screenWidth,screenHeight)));
                           }
                           else if(selectedValue=="rider")
                           {
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>User(user_names,(telephone),"rider",screenWidth,screenHeight)));
                           }
                            
                        }
                        else
                        {
                          print(json_dta["message"]);
                        }
    }

    @override
    Widget build(BuildContext context)
    {
        return Column
                (
                  children: 
                  [
                    Container
                    (
                      width : active_width*(0.9),
                      height: active_height*(0.1),
                      color: Colors.black,
                      child:  Center(child: Text('Please Fill Registration Form Below!', style: TextStyle(color: Colors.white,fontSize: (screenHeight/screenWidth)*(10))))

                    ),
                    Container
                    (
                        margin: EdgeInsets.only(top: screenHeight*0.02),
                        width:  active_width*0.8,
                        
                        child: TextField
                        (
                          controller: names_ctrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration
                                                    (
                                                      labelText: "Please Enter Your Names: ",
                                                      hintText: "Full Names",
                                                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                                      prefixIcon: Icon(Icons.text_fields),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                        )
                    ),
                    Container
                    (
                        margin: EdgeInsets.only(top: screenHeight*0.02),
                        width:  active_width*0.8,
                        child: TextField
                        (
                          keyboardType: TextInputType.number,
                          controller: telno_ctrl,
                          decoration: InputDecoration
                                                    (
                                                      labelText: "Please Enter Phone Number: ",
                                                      hintText: "Phone Number",
                                                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                                      prefixIcon: Icon(Icons.text_fields),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                        )
                    ),
                    Container
                    (
                    width: active_width,
                    height: active_height*0.05,
                    child: Center(
                    child:Text("please choose user type below",style: TextStyle(color: Colors.white))
                    )
                    ),
                    Container
                    (
                    width: active_width,
                    height: active_height*0.08,
                    //color: Colors.white,
                    child:
                    Row(
                    children:[
                    Container
                    (
                     margin: EdgeInsets.only(left: active_width*0.06),
                     width: active_width*0.4,
                     //height: active_height*0.1,
                    child: RadioListTile<String>
                    (
                      title: Text('Rider',style:TextStyle(color: Colors.white)),
                      value: 'rider',
                      groupValue: selectedValue,
                      //selected: false,
                      onChanged: (value)
                      {
                      //selectedValue = value!;
                      toggleChange(value);
                      //print("changed $selectedValue");
                      },
                      
                      activeColor: Colors.blue, // Set the color when active (selected)
                      tileColor: Colors.red,
                      fillColor: MaterialStateColor.resolveWith((states) => Colors.white)
                    )
                    ),
                    Container
                    (
                    width: active_width*0.5,
                    //height: active_height*0.1,
                    //color: Colors.white,
                    child:RadioListTile<String>
                    (
                      title: Text('Customer',style:TextStyle(color: Colors.white)),
                      value: 'customer',
                      groupValue: selectedValue,
                      //selected: false,
                      onChanged: (value) 
                      {
                      //selectedValue = value;
                      toggleChange(value);
                      //print("changed value $selectedValue");
                      },
                       activeColor: Colors.blue, // Set the color when active (selected)
                       tileColor: Colors.red,
                       fillColor: MaterialStateColor.resolveWith((states) => Colors.white)
                       
                    )
                    )
                    ]
                    )
                    ),
                    Container
                    (
                        margin: EdgeInsets.only(top: screenHeight*0.03),
                        width:  active_width*0.8,
                        child: TextField
                        (
                          controller: passcode_ctrl,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration
                                                    (
                                                      labelText: "Please Enter Password: ",
                                                      hintText: "Password",
                                                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                                      prefixIcon: Icon(Icons.text_fields),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                        )
                    )
                 ,
                    ElevatedButton
                    (
                      
                      style: ElevatedButton.styleFrom(primary: Color.fromARGB(249, 4, 48, 116)),
                      onPressed:()
                      {
                       getdata();
                      },
                      child: Text('REGISTER !')
                    ),
                    Container
                    (
                      child:Text("Have an account??? Click below to Login:", style: TextStyle(color: Colors.white,fontSize: (active_height/active_width)*18))
                    ),

                    ElevatedButton
                    (
                      
                      style: ElevatedButton.styleFrom(primary: Color.fromARGB(249, 4, 48, 116)),
                      onPressed: onPressed,
                      /*()
                      {
                          
                      },*/
                    
                      child: Text('LOGIN !')
                    ),
                  ],
                );
    }
}
