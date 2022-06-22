import 'package:flutter/material.dart';

class AppSearch extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const AppSearch({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,    
  }) : super(key: key);

  @override
  _AppSearchState createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {    
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        onChanged: widget.onChanged,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: widget.hintText, 
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(Icons.search,color: Colors.grey.shade400, size: 20,),
          suffixIcon: widget.text.isNotEmpty
            ? GestureDetector(
                child: const Icon(Icons.close),
                onTap: () {
                  controller.clear();
                  widget.onChanged('');
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              )
            : null, 
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(top: 6),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: Colors.grey.shade100
              )
          ),
        ),
      ),
    );
  }
}
