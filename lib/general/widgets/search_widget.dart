import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/data/functions/todo_state.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController controller;

  SearchInput({required this.controller});

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  bool _showCancle = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Container(
              width: 60,
              child: Icon(
                Icons.search,
                size: 28,
                color: Color(0xFFBB9B9B9),
              )),
          Expanded(
            child: TextField(
              onChanged: (String query) {
                if (widget.controller.text != "") {
                  setState(() {
                    _showCancle = true;
                  });
                } else {
                  setState(() {
                    _showCancle = false;
                  });
                }
                EasyDebounce.debounce('search', Duration(milliseconds: 500),
                    () {
                  Provider.of<TodoState>(context, listen: false).query =
                      widget.controller.text;
                });
              },
              controller: widget.controller,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                border: InputBorder.none,
                hintText: "Search for tasks",
                hintStyle: TextStyle(
                  fontSize: 18,
                  letterSpacing: 0.5,
                  wordSpacing: .5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          _showCancle
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      Provider.of<TodoState>(context, listen: false).query = "";
                      widget.controller.clear();
                      _showCancle = false;
                    });
                  },
                  child: Container(
                      width: 60,
                      child: Icon(
                        Icons.cancel,
                        size: 20,
                        color: Color(0xFFBB9B9B9),
                      )),
                )
              : Container()
        ],
      ),
    );
  }
}
