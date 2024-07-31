import 'package:flutter/material.dart';

import 'package:note_app/utils/constants/animations.dart';
import 'package:note_app/views/dummydb.dart';
import 'package:note_app/views/homeScreen/widgets/noteCard.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dateController.clear();
          _titleController.clear();
          _descriptionController.clear();

          showModalBottomSheet(
              backgroundColor: Colors.grey[800],
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a title';
                                }
                                return null;
                              },
                              controller: _titleController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2)),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: Colors.black)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Title',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 18),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 50),
                              child: TextFormField(
                                maxLines: null,
                                controller: _descriptionController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a title';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2)),
                                    // contentPadding: EdgeInsets.symmetric(
                                    //     vertical: 30, horizontal: 10),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Description',
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 18),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a title';
                                }
                                return null;
                              },
                              controller: _dateController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Date',
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 18),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            const smalltextfields(),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: List.generate(
                            //     4,
                            //     (index) {
                            //       return Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: SizedBox(
                            //            width: 50,
                            //           child: TextFormField(
                            //             onChanged: (value) {
                            //               if (value.length == 1 && index < 2) {
                            //                 FocusScope.of(context).nextFocus();
                            //               }
                            //             },
                            //             decoration: InputDecoration(
                            //                 filled: true,
                            //                 fillColor: Colors.grey[300],

                            //                 border: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(5))),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),

                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(child: Text('Cancel')),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      final title = _titleController.text;
                                      final description =
                                          _descriptionController.text;
                                      final date = _dateController.text;
                                      DummyDB.saveTitle(
                                          title, description, date);
                                      setState(() {});
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(child: Text('Save')),
                                  ),
                                ),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     if (_formKey.currentState!.validate()) {
                                //       final title = _titleController.text;
                                //       final description = _descriptionController.text;
                                //       final date = _dateController.text;
                                //       DummyDB.saveTitle(title, description, date);
                                //       Navigator.pop(context);
                                //     }
                                //   },
                                //   child: Text('Save'),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            height: 40,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
              AnimationConstants.title,
            ))),
          )),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 0,
        ),
        itemCount: DummyDB.getTitles().length,
        itemBuilder: (context, index) {
          return NoteCard(
            onEdit: (newTitle, newDescription) {
              // Update the note in the database or list
              DummyDB.getTitles()[index] = newTitle;
              DummyDB.getDescriptions()[index] = newDescription;

              setState(() {}); // Update the UI
            },
            onDelete: () {
              // Delete the note from the database or list
              DummyDB.getTitles().removeAt(index);
              DummyDB.getDescriptions().removeAt(index);
              DummyDB.getDates().removeAt(index);

              setState(() {}); // Update the UI
            },
            title: DummyDB.getTitles()[index],
            description: DummyDB.getDescriptions()[index],
            date: DummyDB.getDates()[index],
          );
        },
      ),
    );
  }
}

class smalltextfields extends StatefulWidget {
  const smalltextfields({super.key});

  @override
  State<smalltextfields> createState() => _smalltextfieldsState();
}

class _smalltextfieldsState extends State<smalltextfields> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
    _focusNode4.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) {
          FocusNode focusNode;
          switch (index) {
            case 0:
              focusNode = _focusNode1;
              break;
            case 1:
              focusNode = _focusNode2;
              break;
            case 2:
              focusNode = _focusNode3;
              break;
            case 3:
              focusNode = _focusNode4;
              break;
            default:
              focusNode = _focusNode1;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: focusNode.hasFocus ? 70 : 60, // Change width when focused
              child: TextFormField(
                focusNode: focusNode,
                onChanged: (value) {
                  if (value.length == 1 && index < 2) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  contentPadding: focusNode.hasFocus
                      ? const EdgeInsets.symmetric(vertical: 15)
                      : const EdgeInsets.symmetric(
                          vertical:
                              10), // Change content padding vertical height when focused
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 2), // border when focused
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
