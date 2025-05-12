import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui_managnment/login_page.dart';

class AddItemToList extends StatefulWidget {
  const AddItemToList({super.key});

  @override
  State<AddItemToList> createState() => _AddItemToListState();
}

class _AddItemToListState extends State<AddItemToList> {
  TextEditingController newItem = TextEditingController();
  List<String> _items = ['Item 1', 'Item 2', 'Item 3'];
  List<Map<String, dynamic>> _apiItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getDataFromApi();
  }

  void _addItem(String newItemText) {
    if (newItemText.trim().isEmpty) return;
    setState(() {
      _items.add(newItemText);
      newItem.clear();
    });
  }

  Future<void> _getDataFromApi() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> fetchedItems = jsonResponse
          .map((item) => {
        'title': item['title'].toString(),
        'body': item['body'].toString(),
      })
          .toList();

      setState(() {
        _apiItems = fetchedItems.take(10).toList(); // limit to 10 items
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load API data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Local + API List"),
      leading: IconButton(onPressed: ()async{
        await FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
        );
      }, icon: Icon(Icons.logout),)),
      body: Column(
        children: [
          // Input Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: newItem,
                      decoration: const InputDecoration(hintText: "Enter new item"),
                    )),
              ],
            ),
          ),
          // Add Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          _addItem(newItem.text);
                        },
                        child: const Text('Add Item'))),
              ],
            ),
          ),

          // List Section
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _items.length + _apiItems.length,
              itemBuilder: (context, index) {
                if (index < _items.length) {
                  return ListTile(
                    title: Text(_items[index]),
                    subtitle: const Text('Local Item'),
                  );
                } else {
                  int apiIndex = index - _items.length;
                  return ListTile(
                    title: Text("Title : ${_apiItems[apiIndex]['title'] ?? ''}"),
                    subtitle: Text("Body : ${_apiItems[apiIndex]['body'] ?? ''}"),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
