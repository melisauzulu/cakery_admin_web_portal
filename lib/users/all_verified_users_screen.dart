import 'package:cakery_admin_web_portal/widgets/simple_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllVerifiedUsersScreen extends StatefulWidget {
  const AllVerifiedUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllVerifiedUsersScreen> createState() => _AllVerifiedUsersScreenState();
}



class _AllVerifiedUsersScreenState extends State<AllVerifiedUsersScreen> {

  QuerySnapshot? allUsers;

  @override
  void initState() {
    super.initState();
    
    FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "approved" )
        .get()
        .then((allVerifiedUsers){

          setState(() {
            allUsers= allVerifiedUsers;
          });
    });

  }

  @override
  Widget build(BuildContext context) {

    Widget displayVerifiedUsersDesign(){
      if(allUsers != null){
        return ListView.builder(
          // bu paddingi kaldırabiliriz ama şu anlık sorun olmadığı için kalsın
          padding: const EdgeInsets.all(10.0),
          itemCount: allUsers!.docs.length,
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
                            image: NetworkImage(allUsers!.docs[i].get("photoUrl")),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(
                        allUsers!.docs[i].get("name"),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.email, color: Colors.black,),
                          const SizedBox(width: 20,),
                          Text(
                            allUsers!.docs[i].get("email"),
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
      appBar: SimpleAppBar(title: "All Verified Users Accounts",),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .5,
          child: displayVerifiedUsersDesign(),
        ),
      ),
    );
  }
}
