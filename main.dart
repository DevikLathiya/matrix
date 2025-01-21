import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hosting_power/core/utils/ext_on_wid.dart';
import 'package:hosting_power/view/loginFlow/screens/splashScreenUi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Viewmodels/notification_services.dart';
import 'core/constant/app_theme.dart';
import 'core/constant/root_binding.dart';



/// --------------------- Square Tap to Colored -----------------

class SquareColored extends StatefulWidget {
  const SquareColored({super.key});

  @override
  _SquareColoredState createState() => _SquareColoredState();
}

class _SquareColoredState extends State<SquareColored> {
  int matrixSize = 0;
  int? selectedRow;
  int? selectedColumn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dynamic Matrix")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Enter Matrix Size", border: OutlineInputBorder()),
              onSubmitted: (value) {
                setState(() {
                  matrixSize = int.tryParse(value) ?? 0;
                  selectedRow = null;
                  selectedColumn = null;
                });
              },
            ),
            const SizedBox(height: 20),
            if (matrixSize > 0)
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: matrixSize),
                  itemCount: matrixSize * matrixSize,
                  itemBuilder: (context, index) {
                    int row = index ~/ matrixSize;
                    int col = index % matrixSize;

                    bool isSelectedRow = row == selectedRow;
                    bool isSelectedColumn = col == selectedColumn;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRow = row;
                          selectedColumn = col;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isSelectedRow || isSelectedColumn ? Colors.blue.withOpacity(0.5) : Colors.grey[300],
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(child: Text("($row, $col)")),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// --------------------- single ----------------=== Circular

class CircularMatrixUI extends StatefulWidget {
  const CircularMatrixUI({super.key});

  @override
  _CircularMatrixUIState createState() => _CircularMatrixUIState();
}

class _CircularMatrixUIState extends State<CircularMatrixUI> {
  int size = 0;

  List<List<int>> generateCircularMatrix(int n) {
    List<List<int>> matrix = List.generate(n, (_) => List.filled(n, 0));

    int top = 0, bottom = n - 1, left = 0, right = n - 1;
    int value = 1;

    while (top <= bottom && left <= right) {
      for (int i = left; i <= right; i++) {
        matrix[top][i] = value++;
      }
      top++;

      for (int i = top; i <= bottom; i++) {
        matrix[i][right] = value++;
      }
      right--;

      if (top <= bottom) {
        for (int i = right; i >= left; i--) {
          matrix[bottom][i] = value++;
        }
        bottom--;
      }

      if (left <= right) {
        for (int i = bottom; i >= top; i--) {
          matrix[i][left] = value++;
        }
        left++;
      }
    }

    return matrix;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circular Matrix UI')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter Matrix Size', border: OutlineInputBorder()),
              onChanged: (value) {
                int? input = int.tryParse(value);
                size = input ?? 0;
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 20),
          Text('Matrix Size: $size', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          if (size > 1)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: generateCircularMatrix(size).map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((value) {
                      return Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
                        child: Text(value.toString(), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

/// --------------------- Row --------- Column ----------------=== Circular

class CircularRowColumnMatrixUI extends StatefulWidget {
  const CircularRowColumnMatrixUI({super.key});

  @override
  CircularRowColumnMatrixUIState createState() => CircularRowColumnMatrixUIState();
}

class CircularRowColumnMatrixUIState extends State<CircularRowColumnMatrixUI> {
  int rows = 0;
  int columns = 0;

  List<List<int>> generateCircularMatrix(int rows, int columns) {
    List<List<int>> matrix = List.generate(rows, (_) => List.filled(columns, 0));

    int top = 0, bottom = rows - 1, left = 0, right = columns - 1;
    int value = 1;

    while (top <= bottom && left <= right) {
      for (int i = left; i <= right; i++) {
        matrix[top][i] = value++;
      }
      top++;

      for (int i = top; i <= bottom; i++) {
        matrix[i][right] = value++;
      }
      right--;

      if (top <= bottom) {
        for (int i = right; i >= left; i--) {
          matrix[bottom][i] = value++;
        }
        bottom--;
      }

      if (left <= right) {
        for (int i = bottom; i >= top; i--) {
          matrix[i][left] = value++;
        }
        left++;
      }
    }

    return matrix;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circular Matrix UI')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Enter Number of Rows', border: OutlineInputBorder()),
                  onChanged: (value) {
                    int? input = int.tryParse(value);
                    if (input != null) {
                      setState(() {
                        rows = input.clamp(2, 10); // Clamp rows between 2 and 10
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Enter Number of Columns', border: OutlineInputBorder()),
                  onChanged: (value) {
                    int? input = int.tryParse(value);
                    if (input != null) {
                      setState(() {
                        columns = input.clamp(2, 10); // Clamp columns between 2 and 10
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text('Rows: $rows, Columns: $columns', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          if (rows > 1 && columns > 1)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: generateCircularMatrix(rows, columns).map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((value) {
                      return Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
                        child: Text(value.toString(), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CircularRowColumnMatrixUI(),
  ));
}
