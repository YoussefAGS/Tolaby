
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolaby/screens/login/bloc_login/login_bloc.dart';

import '../../utiles/constant.dart';
import '../home/home_categories/home_categories_view.dart';
import '../home/teacher_home_view/teacher_home_view.dart';

class Login extends StatelessWidget {
  static const String routName='login';

  Login({Key? key}) : super(key: key);

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool visable = false;
  var  email =TextEditingController();
  var  password =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
  listener: (context, state) {
    if(state is StateLoginSuccess){
      Navigator.pushReplacementNamed(context, TeacherHomeWidget.routeName);
    }
  },
  builder: (context, state) {
      if(state is StateLoginLoading ){
        return Center(
          child: Scaffold(
            backgroundColor: primaryColorDark,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator(color: Colors.blue,),),
                SizedBox(height: 4,),
                Center(child: Text('Loading...',style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                ),)),
              ],
            ),
          )
        );
      }
      else if(state is StateLoginSuccess ){
        return TeacherHomeWidget();
      }
      else {
        return  Scaffold(
          backgroundColor: primaryColorDark,
        appBar: AppBar(
          backgroundColor: primaryColorDark,
          title: const Text('Login',style: TextStyle(
            color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold,
          ),),
          centerTitle: true,
          elevation: 0.0,

        ),
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Container(

              color: primaryColorDark,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/raedgo.jpg',),
                    radius: 70,
                  ),
                  TextFormField(
                    validator: (text){
                      if(text!.trim() == ''){
                        return "Please Enter Email";
                      }
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if(!emailValid){
                        return "Please Enter Correct Email";
                      }
                      return null;
                    },
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Please enter e-mail',
                      hintStyle: TextStyle(color:Colors.white,
                          fontSize: 16,fontWeight: FontWeight.normal),
                      suffixIcon: ImageIcon(AssetImage('assets/Iconfettle.png',),color: Colors.white,size: 26, ),
                      focusColor: Colors.cyan,
                      border: UnderlineInputBorder(borderSide: BorderSide(
                        color: Colors.cyan,
                      )),
                      labelText: 'Email',
                      labelStyle:  TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: password,
                    validator: (text){
                      if(text!.trim() == ''){
                        return "Please Enter Password";
                      }
                      bool passwordValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: visable == true? false:true,
                    style: const TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Please enter password',
                      hintStyle: const TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.normal),
                      suffixIcon: InkWell(
                        onTap: () {
                            visable = !visable;
                        },
                        child: Icon(
                          visable
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                      focusColor: Colors.cyan,
                      border: const UnderlineInputBorder(borderSide: BorderSide(
                        color: Colors.cyan,
                      )),
                      labelText: 'Password',
                      labelStyle:  const TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 32,),

                  const Text('Forget Email Or Password ?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),),
                  const SizedBox(height: 32,),
                  ElevatedButton(onPressed: (){
                    if(ValidatForm()){
                      BlocProvider.of<LoginBloc>(context).add(SuccessLoginEvent(email.text, password.text));
                    }
                  },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Row(
                        children: [
                          Text('Login',textAlign: TextAlign.start,
                            style: TextStyle(
                              color: primaryColorDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),),
                          Spacer(),
                          Icon(Icons.arrow_forward,size: 21,color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32,),
                ],
              ),
            ),
          ),
        ),
      );
      }
  },
);
  }
   bool ValidatForm() {
     if (formkey.currentState!.validate()) {
       return true;
     }
     return false;
   }
}
