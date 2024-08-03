import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/views/dummydb.dart';
import 'package:note_app/views/homeScreen/HomeScreen.dart';
import 'package:share_plus/share_plus.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({
    super.key,
    this.title = '',
    this.description = '',
    this.date = '',
    required this.onDelete,
    required this.onEdit,
    this.bcolor,
  });
  final void Function()? onDelete;
  final void Function(String, String, Color?)? onEdit;
  late String title;
  late String description;
  final String date;
  late Color? bcolor;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool _isEditMode = false;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  Color? _newColor;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    _newColor = widget.bcolor;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 35, left: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
                _isEditMode ? _newColor : widget.bcolor ?? Colors.amber[100]),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(118, 158, 158, 158),
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: 40,
                          ),
                        )),
                    Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_isEditMode) {
                              // Save the changes
                              widget.onEdit!(_titleController.text,
                                  _descriptionController.text, _newColor);
                              setState(() {
                                widget.title = _titleController.text;
                                widget.description =
                                    _descriptionController.text;
                                widget.bcolor = _newColor;
                                _isEditMode = false;
                              });
                            } else {
                              // Enter edit mode
                              setState(() {
                                _isEditMode = true;
                              });
                            }
                          },
                          icon: Icon(_isEditMode ? Icons.save : Icons.edit),
                        ),
                        IconButton(
                          onPressed: widget.onDelete,
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _isEditMode
                    ? SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          maxLines: null,
                          controller: _titleController,
                          decoration: InputDecoration(border: InputBorder.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                      )
                    : Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: _isEditMode
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: TextFormField(
                                    controller: _descriptionController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Description',
                                    ),
                                    maxLines: null,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a description';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              : Text(
                                  widget.description,
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Container(
                  height: 55,
                  width: 380,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blueGrey[300]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          _isEditMode
                              ? Colourbox(
                                  onColourSelected: (index) {
                                    setState(() {
                                      _newColor = DummyDB.noteColors[index];
                                    });
                                  },
                                  height: 20.0,
                                  width: 20.0,
                                )
                              : const SizedBox(),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.date,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                              onPressed: () {
                                Share.share(
                                    "${widget.title} \n${widget.description} \n${widget.date}");
                              },
                              icon: Container(child: Icon(Icons.share))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUI() {
    setState(() {});
  }
}
