import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/helpers/firestore_helpers.dart';

import '../../helpers/firebase_auth_helper.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  GlobalKey<FormState> editPageKey = GlobalKey<FormState>();
  Map<Object, Object> newData = {};

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot data =
        ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://img.freepik.com/free-vector/white-blurred-background_1034-249.jpg'),
              fit: BoxFit.cover),
        ),
        child: Form(
          key: editPageKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: data['title'],
                  onChanged: (val) {
                    newData['title'] = val;
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    labelText: "Title",
                    labelStyle: TextStyle(color: Colors.brown, fontSize: 22),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: data['description'],
                  onChanged: (val) {
                    newData['description'] = val;
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    labelText: "Note",
                    labelStyle: TextStyle(color: Colors.brown, fontSize: 22),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  maxLines: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: const Alignment(0.9,0),
                  child: Text(
                    'Date :- ${Global.date}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 5,),
                Align(
                  alignment: const Alignment(0.9,0),
                  child: Text(
                    'Time :- ${Global.time}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    editPageKey.currentState!.save();
                    await FireStoreHelper.fireStoreHelper
                        .editNotes(id: data['id'].toString(), data: newData);

                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.done,
                    color: Colors.brown,
                  ),
                  label: const Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
