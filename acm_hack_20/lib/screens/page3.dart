import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<FirebaseUser> getUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          while (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          FirebaseUser user = snapshot.data;
          return SafeArea(
            child: Column(
              //  Main column
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(user.photoUrl),
                ),
                Text(
                  user.displayName,
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.green[900],
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.teal,
                  ),
                ),
                Text(
                  'Verified User'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.5,
                    color: Colors.green[900],
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.teal,
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.green[900],
                    ),
                    title: Text(
                      user.email,
                      style: TextStyle(
                          color: Colors.green[900],
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _auth.signOut();
                    Navigator.pop(context);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      title: Text(
                        'Logout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SourceSansPro',
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
