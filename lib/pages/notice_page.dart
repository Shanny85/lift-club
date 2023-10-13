import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/pages/post_page.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final CollectionReference _offer =
      FirebaseFirestore.instance.collection('offer');
  bool alreadySaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Notice Page')),
      backgroundColor: Colors.blueGrey,
      body: StreamBuilder(
          stream: _offer.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length, //number of rows
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                          "${"\nLIFT: \n\n" + documentSnapshot['Description']}\n"),
                      subtitle: Text(
                          "R " + documentSnapshot['Price'].toString() + '\n'),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(!alreadySaved
                                  ? Icons.favorite_border
                                  : Icons.favorite),
                              onPressed: () {
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'You have successfully selected the offer')));
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      tileColor: Colors.white70,
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
