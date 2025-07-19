import 'package:flutter/material.dart';

class _QuoteWidget extends StatelessWidget {
  final int index;
  final VoidCallback onAddPressed;
  const _QuoteWidget({
    required Key key,
    required this.index,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Widget $index',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Field 1',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Field 2',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: onAddPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
