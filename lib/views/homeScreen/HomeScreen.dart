import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/utils/appSessions.dart';
import 'package:intl/intl.dart';
import 'package:note_app/utils/constants/animations.dart';
import 'package:note_app/views/dummydb.dart';
import 'package:note_app/views/homeScreen/widgets/noteCard.dart';
import 'package:note_app/views/noteScreen/noteScreen.dart';

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
  var noteBox = Hive.box(AppSessions.NOTEBOX);
  List noteKeys = [];
  int? _selectedIndex;

  @override
  void initState() {
    noteKeys = noteBox.keys.toList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _dateController.clear();
            _titleController.clear();
            _descriptionController.clear();
            _selectedIndex = 0;

            showModalBottomSheet(
              backgroundColor: Colors.grey[800],
              isScrollControlled: true,
              context: context,
              builder: (context) => StatefulBuilder(
                  builder: (context, setState) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minHeight: 50),
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
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a title';
                                    }
                                    return null;
                                  },
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () async {
                                            var selectedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    firstDate: DateTime(2024),
                                                    lastDate: DateTime.now());
                                            if (selectedDate != null) {
                                              _dateController.text = DateFormat(
                                                      'EEE, MMM dd, yyyy')
                                                  .format(selectedDate);
                                            }
                                          },
                                          icon: Icon(
                                              Icons.calendar_month_outlined)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Colourbox(
                                  onColourSelected: (index) {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                  },
                                  height: 35.0,
                                  width: 45.0,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child:
                                            const Center(child: Text('Cancel')),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          final title = _titleController.text;
                                          final description =
                                              _descriptionController.text;
                                          final date = _dateController.text;
                                          noteBox.add({
                                            "title": title,
                                            "description": description,
                                            "date": date,
                                            "colorIndex": _selectedIndex ?? 0,
                                          });

                                          noteKeys = noteBox.keys.toList();

                                          Navigator.pop(context);
                                          _updateUI();
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child:
                                            const Center(child: Text('Save')),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 30, bottom: 30),
                child: Text(
                  "My Notes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                  ),
                ),
              ),
              Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 0),
                itemCount: noteKeys.length,
                itemBuilder: (context, index) {
                  final note = noteBox.get(noteKeys[index]);
                  return Dismissible(
                    key: Key(noteKeys[index].toString()),
                    direction: DismissDirection.startToEnd,
                    onUpdate: (details) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  NoteScreen(
                            onEdit: (newTitle, newDescription, newColor) {
                              // Update the note in the database or list
                              note['title'] = newTitle;
                              note['description'] = newDescription;
                              note['colorIndex'] =
                                  DummyDB.noteColors.indexOf(newColor!);
                              noteKeys = noteBox.keys.toList();
                              setState(() {}); // Update the UI
                              noteBox.put(noteKeys[index], note);
                            },
                            onDelete: () {
                              // Delete the note from the database or list
                              noteBox.delete(noteKeys[index]);
                              noteKeys = noteBox.keys.toList();
                              setState(() {}); // Update the UI
                            },
                            title: note['title'],
                            description: note['description'],
                            date: note['date'],
                            bcolor: DummyDB.noteColors[note["colorIndex"] ?? 0],
                          ),
                          transitionDuration: Duration(milliseconds: 500),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(-1, 0),
                                end: Offset(0, 0),
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: NoteCard(
                      onEdit: (newTitle, newDescription, newColor) {
                        // Update the note in the database or list
                        note['title'] = newTitle;
                        note['description'] = newDescription;
                        note['colorIndex'] =
                            DummyDB.noteColors.indexOf(newColor!);
                        noteBox.put(noteKeys[index], note);
                        setState(() {}); // Update the UI
                      },
                      onDelete: () {
                        // Delete the note from the database or list
                        noteBox.delete(noteKeys[index]);
                        noteKeys = noteBox.keys.toList();
                        setState(() {}); // Update the UI
                      },
                      title: note['title'],
                      description: note['description'],
                      date: note['date'],
                      bcolor: DummyDB.noteColors[note["colorIndex"] ?? 0],
                    ),
                  );
                },
              )),
            ],
          ),
        ));
  }

  void _updateUI() {
    setState(() {});
  }
}

class Colourbox extends StatefulWidget {
  const Colourbox({
    super.key,
    required this.onColourSelected,
    required this.height,
    required this.width,
  });
  final Function(int) onColourSelected;
  final dynamic height;
  final dynamic width;

  @override
  State<Colourbox> createState() => _ColourboxState();
}

class _ColourboxState extends State<Colourbox> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  widget.onColourSelected(index);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: DummyDB.noteColors[index],
                  border: Border.all(
                    color:
                        _selectedIndex == index ? Colors.black : Colors.black,
                    width: _selectedIndex == index ? 3 : 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
