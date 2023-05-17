import 'package:flutter/material.dart';
import 'package:task2/value/userValue.dart';
import 'package:task2/services/services.dart';

// ignore_for_file: file_names
// ignore_for_file: use_build_context_synchronously
// ignore_for_file: avoid_print

class ListMapValues extends StatefulWidget {
  const ListMapValues({super.key});

  @override
  State<ListMapValues> createState() => _ListMapValuesState();
}

class _ListMapValuesState extends State<ListMapValues> {
  List<UserInput> _userList = [];

  final _userServicesList = UserService();
  // Getting value form table
  readValueTable() async {
    var value = await _userServicesList.readAllUsers();
    print('Read value for database');
    print(value);
    _userList = <UserInput>[];
    value.forEach((userValue) {
      print('Convert value');
      // print(userValue['id']);
      setState(() {
        var userValuelist = UserInput();
        userValuelist.id = userValue['id'];
        userValuelist.fullName = userValue['fullName'];
        userValuelist.emailid = userValue['emailid'];
        userValuelist.mobileNumber = userValue['mobileNumber'];
        userValuelist.password = userValue['password'];
        _userList.add(userValuelist);
      });
    });
    print('List convertion in input List');
    print(_userList.toList());
    _searchList = _userList;
  }

  List<UserInput> _searchList = [];
  @override
  void initState() {
    readValueTable();
    super.initState();
  }

  _deleteValue(userId) async {
    // await _userServicesList.deleteUser(userId);
    // await readValueTable();
    // if (_searchList.isEmpty) {}
  }

  _filter(String valueFind) {
    List<UserInput> searchDynamic = [];
    if (valueFind.isEmpty) {
      print('if condition called');
      searchDynamic = _userList;
    } else {
      searchDynamic = _userList
          .where((element) =>
              element.fullName!.toLowerCase().contains(valueFind.toLowerCase()))
          .toList();
    }
    setState(() {
      _searchList = searchDynamic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 196, 196, 196),
      appBar: AppBar(
        title: const Text('List Data'),
        centerTitle: true,
      ),
      body: Center(
        child: _searchList.isNotEmpty
            ? Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _searchList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 20,
                          margin: const EdgeInsets.only(
                              top: 15, left: 15, right: 15),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'First Name : ${_searchList[index].fullName ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Emailid : ${_searchList[index].emailid ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Mobile Number : ${_searchList[index].mobileNumber ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Percentage : ${_searchList[index].password ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    // String refresh = await Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //         builder: (BuildContext context) {
                                    //   return UpdateValue(
                                    //     user: _searchList[index],
                                    //   );
                                    // }));
                                    // if (refresh == 'closed') {
                                    //   readValueTable();
                                    // }
                                  },
                                  icon: const Icon(Icons.edit_document,
                                      color: Color.fromRGBO(95, 94, 94, 0.988)),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deletePopUp(
                                        context,
                                        _searchList
                                            .indexOf(_searchList[index]));
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Container(
                color: Colors.redAccent,
                margin: const EdgeInsets.only(
                    top: 300, bottom: 300, left: 20, right: 20),
                child: const Center(
                  child: Text('There is no value in list',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                ),
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: const Color.fromARGB(255, 236, 65, 65),
      //     onPressed: () {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (BuildContext context) {
      //             return const ViewTable();
      //           },
      //         ),
      //       );
      //     },
      //     child: const Icon(Icons.grid_view_outlined)),
    );
  }

  Widget searchBox() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 45, right: 45),
      child: Card(
        elevation: 25,
        // child: Container(
        //   margin: const EdgeInsets.only(top: 20, left: 45, right: 45),
        child: TextField(
          onChanged: (value) => _filter(value),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            hintText: 'Search list using firstName',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
      // ),
    );
  }

  deletePopUp(BuildContext context, index) {
    Widget okButton = ElevatedButton(
      onPressed: () {
        _deleteValue(_searchList[index].id);
        Navigator.pop(context);
      },
      child: const Text('Ok'),
    );
    Widget cancelButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Cancel'),
    );

    AlertDialog alter = AlertDialog(
      title: const Text('Are you want to delete the list'),
      actions: [okButton, cancelButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alter;
      },
    );
  }
}
