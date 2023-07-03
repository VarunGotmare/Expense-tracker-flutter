import 'package:flutter/material.dart';
import 'package:expenses_tracker/widgets/expenses_list/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  NewExpenseState createState() => NewExpenseState();
}

class NewExpenseState extends State<NewExpense> {
  void _subData() {
    final entamt = double.tryParse(_amtCont.text);
    final amtIsInValid = entamt == null || entamt <= 0;
    if (_titleCont.text.trim().isEmpty || amtIsInValid || _selDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure to put valid input title, date and amount."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleCont.text,
          amount: entamt,
          date: _selDate!,
          categoryy: _selCat),
    );
    Navigator.pop(context);
  }

  final _titleCont = TextEditingController();
  final _amtCont = TextEditingController();
  Categoryy _selCat = Categoryy.leisure;
  DateTime? _selDate;
  void _datePick() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);
    setState(() {
      _selDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _amtCont.dispose();
    _titleCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keySize = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keySize + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleCont,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amtCont,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '₹',
                            label: Text("Amount"),
                          ),
                        ),
                      )
                    ],
                  )
                else
                  TextField(
                    controller: _titleCont,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selCat,
                        items: Categoryy.values
                            .map(
                              (categoryy) => DropdownMenuItem(
                                value: categoryy,
                                child: Text(
                                  categoryy.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selCat = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selDate == null
                                ? "No selected Date"
                                : formatter.format(_selDate!)),
                            IconButton(
                                onPressed: _datePick,
                                icon: const Icon(Icons.date_range))
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amtCont,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '₹',
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selDate == null
                                ? "No selected Date"
                                : formatter.format(_selDate!)),
                            IconButton(
                                onPressed: _datePick,
                                icon: const Icon(Icons.date_range))
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _subData,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: const Text("Save Expense"),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selCat,
                        items: Categoryy.values
                            .map(
                              (categoryy) => DropdownMenuItem(
                                value: categoryy,
                                child: Text(
                                  categoryy.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selCat = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _subData,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: const Text("Save Expense"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
