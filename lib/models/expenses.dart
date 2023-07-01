import 'package:expenses_tracker/widgets/chart/chart.dart';
import 'package:expenses_tracker/widgets/expenses_list/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _regExpenses = [
    Expense(
      title: 'Example',
      amount: 10.99,
      date: DateTime.now(),
      categoryy: Categoryy.food,
    ),
    Expense(
      title: 'Example2',
      amount: 0.99,
      date: DateTime.now(),
      categoryy: Categoryy.misc,
    ),
    Expense(
        title: "example 3",
        amount: 100,
        date: DateTime.now(),
        categoryy: Categoryy.travel)
  ];

  void _adOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _regExpenses.add(expense);
    });
  }

  void _remExpense(Expense expense) {
    var expInd = _regExpenses.indexOf(expense);
    setState(() {
      _regExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted."),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _regExpenses.insert(expInd, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainCont = const Center(
      child: Text("No expenses found, start addidng some!"),
    );
    if (_regExpenses.isNotEmpty) {
      mainCont = ExpensesList(
        expenses: _regExpenses,
        delExpense: _remExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses Tracker App"),
      ),
      body: Column(
        children: [
          Chart(expenses: _regExpenses),
          Expanded(
            child: mainCont,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: false,
        elevation: 10,
        onPressed: _adOverlay,
        child: const Icon(Icons.add),
      ),
    );
  }
}
