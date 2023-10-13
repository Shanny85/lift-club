import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final CollectionReference _offer =
      FirebaseFirestore.instance.collection('offer');

  /*
the following code can now be used,
await _offer.add({"name": name, "price": price});
await _offer.update({"name": name, "price":price});
await _offer.doc(offerId).delete();
*/
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _descriptionController.text = documentSnapshot['Description'];
      _priceController.text = documentSnapshot['Price'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String description = _descriptionController.text;
                      final String price = _priceController.text;
                      await _offer.doc(documentSnapshot!.id).update({
                        "Description": description,
                        "Price": price,
                      });
                      _descriptionController.text = '';
                      _priceController.text = '';
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('You have successfully updated the offer')));
                    },
                  )
                ],
              ));
        });
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _descriptionController.text = documentSnapshot['Description'];
      _priceController.text = documentSnapshot['Price'];
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Post'),
                onPressed: () async {
                  final String description = _descriptionController.text;
                  final String price = _priceController.text;
                  await _offer.add({
                    "Description": description,
                    "Price": price,
                  });
                  _descriptionController.text = '';
                  _priceController.text = '';
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('You have successfully created the offer')));
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _delete(String offerId) async {
    await _offer.doc(offerId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted the offer')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Post Page')),
      backgroundColor: Colors.blueGrey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white70,
        foregroundColor: Colors.blueGrey,
        onPressed: () => _create(),
        child: const Icon(Icons.post_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                              icon: const Icon(Icons.edit),
                              onPressed: () => _update(documentSnapshot),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _delete(documentSnapshot.id),
                              color: Colors.red,
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
