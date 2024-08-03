import 'package:flutter/material.dart';
import 'package:note_app/views/dummydb.dart';
import 'package:note_app/views/homeScreen/HomeScreen.dart';
import 'package:share_plus/share_plus.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({
    super.key,
    this.title = '',
    this.description = '',
    this.date = '',
    required this.onDelete,
    required this.onEdit,
    this.bcolor,
    this.onSwipe,
  });
  final void Function()? onDelete;
  final void Function(String, String, Color?)? onEdit;
  final String title;
  final String description;
  final String date;
  final Color? bcolor;
  final void Function()? onSwipe;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool _isExpanded = false;
  bool _isEditMode = false;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  Color? _newColor;

  @override
  void initState() {
    setState(() {});
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  _isEditMode ? _newColor : widget.bcolor ?? Colors.amber[100]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _isEditMode
                      ? SizedBox(
                          width: 250,
                          child: TextFormField(
                            maxLines: null,
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                          ),
                        )
                      : Text(
                          widget.title,
                          maxLines: _isExpanded ? null : 1,
                          overflow: _isExpanded ? null : TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_isEditMode) {
                            // Save the changes
                            widget.onEdit!(_titleController.text,
                                _descriptionController.text, _newColor);
                            setState(() {
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
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: _isEditMode
                    ? TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        maxLines: null,
                      )
                    : Text(
                        widget.description,
                        maxLines: _isExpanded ? null : 4,
                        overflow: _isExpanded ? null : TextOverflow.ellipsis,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          icon: const Icon(Icons.share)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
