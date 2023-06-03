//Here we will describe which data structure an expense in this app should have.
//so which kind of structure an expense should have.
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); //utility object

final uuid = Uuid(); //here we create uuid object.

enum Category { food, travel, leisure, work } //enum syntax

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.travel_explore,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); //here using that object we call v4 method on it which will generate unique string id.

  final String id;
  final String title;
  final double amount;
  final DateTime date; //allows us to store date information in a single value
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

//Data model
//one bucket per category
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

//own alternative named constructor functions
//utility constructor function that takes care of filtering out the expenses that belong to a specific category.
  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)
      : expenses = allExpense
            .where((expense) => expense.category == category)
            .toList(); //additional constructor functions to your class.

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
