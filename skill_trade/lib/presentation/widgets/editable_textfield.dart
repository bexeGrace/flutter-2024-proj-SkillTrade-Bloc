import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/application/blocs/review_bloc.dart';
import 'package:skill_trade/presentation/events/review_event.dart';

class EditableField extends StatefulWidget {
  final String label;
  final String data;
  final TextEditingController? controller;

  EditableField({Key? key, required this.label, required this.data, required this.controller});

  @override
  State<EditableField> createState() => _EditableFieldState();
}

class _EditableFieldState extends State<EditableField> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label.split(",")[0] != "review") Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 210,
                child: TextField(
                  controller: widget.controller,
                  enabled: isEditing, 
                  decoration: InputDecoration(
                    hintText: 'Editable TextField',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.edit),
                onPressed: () {
                  if (widget.label.split(",")[0] == "review" && isEditing) {
                    BlocProvider.of<ReviewsBloc>(context).add(UpdateReview(reviewId: int.parse(widget.label.split(",")[1]), updates: {"review": widget.controller!.text}, technicianId: int.parse(widget.label.split(",")[2],)));
                  } 
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
