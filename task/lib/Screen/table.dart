import 'package:task/map_value.dart';
import 'package:flutter/material.dart';
import 'package:task/services/inputpass.dart';

class ViewTable extends StatefulWidget {
  const ViewTable({super.key});

  @override
  State<ViewTable> createState() => _ViewTableState();
}

class _ViewTableState extends State<ViewTable> {
  List<UserInput> _userList = [];
  final _userServicesList = UserService();

  readValueTable() async {
    var value = await _userServicesList.readAllUsers();
    _userList = <UserInput>[];
    value.forEach((userValue) {
      setState(() {
        var userValuelist = UserInput();
        userValuelist.id = userValue['id'];
        userValuelist.firstName = userValue['firstName'];
        userValuelist.lastName = userValue['lastName'];
        userValuelist.emailid = userValue['emailid'];
        userValuelist.mobileNumber = userValue['mobileNumber'];
        userValuelist.percentage = userValue['percentage'];
        _userList.add(userValuelist);
      });
    });
  }

  @override
  void initState() {
    readValueTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('DataView in Table'),
      ),
      body: _userList.isNotEmpty
          ? ListView(
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.only(
                  top: 30,
                )),
                SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: DataTable(
                      border: TableBorder.all(),
                      columns: const [
                        DataColumn(label: Text('FirstName')),
                        DataColumn(label: Text('LastName')),
                        DataColumn(label: Text('Emailid')),
                        DataColumn(label: Text('MobileNumber')),
                        DataColumn(label: Text('Percentage')),
                      ],
                      rows: _userList
                          .map(
                            (data) => DataRow(
                              cells: [
                                DataCell(Text(data.firstName!)),
                                DataCell(Text(data.lastName!)),
                                DataCell(Text(data.emailid!)),
                                DataCell(Text(data.mobileNumber!)),
                                DataCell(Text(data.percentage.toString())),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
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
    );
  }
}
