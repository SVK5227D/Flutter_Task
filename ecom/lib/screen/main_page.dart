import 'package:ecom/model/state.dart';
import 'package:ecom/screen/data.dart';
import 'package:flutter/material.dart';
import 'package:ecom/screen/filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    // _fecthData();
    ref.read(userCart.notifier).addList();

    super.initState();
  }

  List category = [];
  List filter = [];

  _categoryList() {
    final data = ref.watch(userCart);
    for (var dumy in data) {
      if (category.contains(dumy.category['name'])) {
      } else {
        category.add(dumy.category['name']);
      }
    }
  }

  _filterValue(categoryValue) {
    final data = ref.watch(userCart);
    for (var dumy in data) {
      if (categoryValue == dumy.category['name']) {
        filter.add(dumy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userCart);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () async {
              await _categoryList();
              filterList();
            },
            icon: const Icon(Icons.filter_list),
          )
        ],
      ),
      body: const DataValue(),
    );
  }

  Future filterList() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Filter using UserId'),
          content: SizedBox(
            width: 100,
            height: 250,
            child: ListView.builder(
              itemCount: category.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () async {
                    // if (category[index] == data[index].category['name']) {
                    //   print('true');
                    //   filter.add(data);
                    // }
                    await _filterValue(category[index]);
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                          builder: (context) => FilterScreen(
                            value: filter,
                          ),
                        ))
                        .then((value) => Navigator.of(context).pop());
                  },
                  child: Text(category[index]),
                );
              },
            ),
          ),
        ),
      );
}
