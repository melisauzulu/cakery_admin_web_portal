import 'package:cakery_admin_web_portal/main_screens/home_screen.dart';
import 'package:cakery_admin_web_portal/widgets/simple_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllVerifiedSellersScreen extends StatefulWidget {
  const AllVerifiedSellersScreen({Key? key}) : super(key: key);

  @override
  State<AllVerifiedSellersScreen> createState() => _AllVerifiedSellersScreenState();
}



class _AllVerifiedSellersScreenState extends State<AllVerifiedSellersScreen> {

  QuerySnapshot? allSellers;

  displayDialogBoxForBlockingAccount(userDocumentID){

    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text(
              "Block Account",
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,

              ),
            ),
            content: const Text(
              "Do you want to block this account ?",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2,

              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);

                },

                child: const Text("No"),

              ),

              ElevatedButton(
                onPressed: (){
                  Map<String, dynamic> userDataMap = {
                    // so start us for the blocked user will be changed to not approved
                    // not approved means that is blocked
                    "status": "not approved",
                  };
                  FirebaseFirestore.instance
                      .collection("sellers")
                      .doc(userDocumentID)
                      .update(userDataMap)
                      .then((value){

                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));

                    SnackBar snackBar = const SnackBar(
                      content: Text(
                        "Blocked Successfully ! " ,
                        style: TextStyle (
                          fontSize: 36,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.pinkAccent,
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);


                  });
                },
                child: const Text("Yes"),
              ),
            ],

          );
        }

    );
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "approved" )
        .get()
        .then((allVerifiedUsers){

      setState(() {
        allSellers= allVerifiedUsers;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    Widget displayVerifiedUsersDesign(){
      if(allSellers != null){
        return ListView.builder(
          // bu paddingi kaldırabiliriz ama şu anlık sorun olmadığı için kalsın
          padding: const EdgeInsets.all(10.0),
          itemCount: allSellers!.docs.length,
          itemBuilder: (context, i){
            return Card(
              // kartlar arasındaki boşluk için
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(allSellers!.docs[i].get("sellerAvatarUrl")),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(
                        allSellers!.docs[i].get("sellerName"),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.email, color: Colors.black,),
                          const SizedBox(width: 20,),
                          Text(
                            allSellers!.docs[i].get("sellerEmail"),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      icon: const Icon(
                        Icons.person_pin_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                        " ",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      ),
                      onPressed: ()
                      {

                        SnackBar snackBar = SnackBar(
                          content: Text(
                            " ",
                            style: const TextStyle (
                              fontSize: 36,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.pink,
                          duration: const Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);



                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      icon: const Icon(
                        Icons.person_pin_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Block this Account".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      ),
                      onPressed: ()
                      {

                        displayDialogBoxForBlockingAccount(allSellers!.docs[i].id);

                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
      else {

        return const Center(
          child: Text(
            "No Record Found.",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        );
      }
    }
    return Scaffold(
      appBar: SimpleAppBar(title: "All Verified Sellers Accounts",),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .5,
          child: displayVerifiedUsersDesign(),
        ),
      ),
    );
  }
}
