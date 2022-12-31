
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:mini_project_hive/user_info_model.dart';

class HomeView extends StatefulWidget {
   HomeView({super.key});
  
  

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String USER_INFO_HIVE_BOX = 'userInfo';
   final TextEditingController _fulnameController = TextEditingController();
    final TextEditingController _ageController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();

    List<UserInfo> _users=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [
        Padding(
          padding: EdgeInsets.only(right: 150,top: 17),
          child: Text("Hive Mini Project"),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
             Column(
               crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  TextField(
              controller: _fulnameController,
              keyboardType: TextInputType.name,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                hintText: 'FullName',
                hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),
              ),
            ),

                  TextField(
              controller: _ageController,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Age',
            
              hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),
              
              ),
            ),
            
             TextField(
              controller: _cityController ,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'City',
              hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32,),
             TextButton(onPressed: () {
               _saveData();
             }, child: Text("Save Data")),
             TextButton(onPressed: () {
               _loadData();
             }, child: Text("loadFromCach")),
                TextButton(onPressed: () {
               _clearData();
             }, child: Text("Clear Cach")),
              ],
             ),
             Expanded(child: ListView(
              children: [
                for(var item in _users)
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  child: 
                Text("${item.fullname} (${item.age}) from ${item.city}"),
                )
              ],
             ))
          ],
        ),
      ),
    );
  }
   _saveData() async {
    print('Save data');
      String fullName = _fulnameController.text;
      int age = int.parse( _ageController.text);
      String city = _cityController.text;

       //حالا اینجا مقداردهی میکنیم
       var user = UserInfo(fullname: fullName, age: age, city: city);
      var box =await Hive.openBox(USER_INFO_HIVE_BOX);
      //دیتارا ذخیره کردیم 
      //این userکه ساختیم هست
     // box.put('user', user);


     //حالا اینجا میخواییم لیستی از این نام هارا داشته باشیم ذخیره بشه
     box.add(user);
    await  box.close();
    _loadData();
     
      

   }
    void _loadData()async{
      print('Load data');
      _users=[];
       var box = await Hive.openBox<UserInfo>(USER_INFO_HIVE_BOX);
       //UserInfo user = box.get('user');
        for(var user in box.values){
          _users.add(user);
        }

          

       //حالا برای گرفتن addکه لیست
         // UserInfo user = box.getAt(0);
       //ذخیره هم میکنیم 
      // _fulnameController.text= user.fullname;
      // _ageController.text= user.age.toString();
      // _cityController.text= user.city;
    await   box.close();
       setState(() {
         
       });
   }
   //از catchپاک میشود
   void _clearData()async{
     var box = await Hive.openBox(USER_INFO_HIVE_BOX);
      box.clear();
    
   }
}