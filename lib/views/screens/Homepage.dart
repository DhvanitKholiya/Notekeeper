import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/helpers/firestore_helpers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> noteKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String? title;
  String? note;
  Key? key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://img.freepik.com/free-vector/white-blurred-background_1034-249.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            const Align(
                alignment: Alignment(-0.8, -0.9),
                child: Text(
                  "Notes :-",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )),
            StreamBuilder(
              stream: FireStoreHelper.fireStoreHelper.getNotes(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapShots) {
                if (snapShots.hasError) {
                  return Center(
                    child: Text("${snapShots.error}"),
                  );
                } else if (snapShots.hasData) {
                  List data = snapShots.data!.docs;

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 100),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        key: key,
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (val) {
                                Navigator.of(context).pushNamed('editPage',
                                    arguments: data[index]);
                              },
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.black,
                              icon: Icons.edit,
                              padding: const EdgeInsets.all(10),
                              autoClose: true,
                              label: 'Edit',
                            ),
                            SlidableAction(
                              onPressed: (val) {
                                FireStoreHelper.fireStoreHelper
                                    .deleteNotes(id: data[index]['id'].toString());
                              },
                              backgroundColor: const Color(0xffFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              padding: const EdgeInsets.all(10),
                              autoClose: true,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('editPage', arguments: data[index]);
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(data[index]['title']),
                              subtitle: Text(data[index]['description']),
                              // tileColor: Colors.purple,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade50,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Create Note"),
                  content: Form(
                    key: noteKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          onSaved: (val) {
                            title = val!;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Title",
                            labelText: "title",
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onSaved: (val) {
                            note = val!;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Write Your Note",
                            labelText: "Note",
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Clear",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        noteKey.currentState!.save();

                        await FireStoreHelper.fireStoreHelper
                            .addNotes(title: title!, note: note!);

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.save_alt_sharp,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Save",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

// https://png.pngtree.com/background/20210709/original/pngtree-color-creative-border-background-picture-image_921203.jpg
