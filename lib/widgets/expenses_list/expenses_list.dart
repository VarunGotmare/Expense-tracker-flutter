import 'package:expenses_tracker/widgets/expenses_list/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expense_items.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.delExpense,
  });
  final List<Expense> expenses;
  final void Function(Expense expense) delExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error,
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              onDismissed: (direction) {
                delExpense(expenses[index]);
              },
              key: ValueKey(expenses[index]),
              child: ExpenseItems(expenses[index]),
            ));
  }
}
