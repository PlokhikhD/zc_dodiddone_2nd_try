import 'package:flutter/material.dart';
import '../widgets/task_item.dart';
import 'package:intl/intl.dart'; // Импортируем пакет intl

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final List<String> _tasks = [
    'Купить продукты',
    'Записаться на прием к врачу',
    'Позвонить маме',
    'Сделать уборку',
    'Прочитать книгу',
  ];

  // Контроллеры для текстовых полей в диалоговом окне
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now(); // Добавляем переменную для даты и времени

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Используем Dialog вместо AlertDialog для настройки ширины
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 400, // Устанавливаем ширину диалога
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Название'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Описание'),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16), // Отступ для кнопки
                  child: ElevatedButton(
                    onPressed: () {
                      // Открываем диалог выбора даты и времени
                      showDatePicker(
                        context: context,
                        initialDate: _selectedDateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ).then((pickedDate) {
                        if (pickedDate == null) return;
                        // Открываем диалог выбора времени
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
                        ).then((pickedTime) {
                          if (pickedTime == null) return;
                          // Обновляем _selectedDateTime с выбранной датой и временем
                          setState(() {
                            _selectedDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        });
                      });
                    },
                    child: const Text('Выбрать дедлайн'),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Выбранный дедлайн: ${DateFormat('dd.MM.yy HH:mm').format(_selectedDateTime)}',
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Добавляем новую задачу в список
                        setState(() {
                          _tasks.add(_titleController.text);
                        });
                        // Очищаем контроллеры
                        _titleController.clear();
                        _descriptionController.clear();
                        // Закрываем диалоговое окно
                        Navigator.of(context).pop();
                      },
                      child: const Text('Добавить'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задачи'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return TaskItem(
            title: _tasks[index],
            description: 'Описание задачи',
            deadline: _selectedDateTime, // Передаем выбранную дату и время
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
  




// import 'package:flutter/material.dart';
// import '../widgets/task_item.dart';
// import 'package:intl/intl.dart'; // Импортируем пакет intl

// class TasksPage extends StatefulWidget {
//   const TasksPage({Key? key}) : super(key: key);

//   @override
//   State<TasksPage> createState() => _TasksPageState();
// }

// class _TasksPageState extends State<TasksPage> {
//   final List<String> _tasks = [
//     'Купить продукты',
//     'Записаться на прием к врачу',
//     'Позвонить маме',
//     'Сделать уборку',
//     'Прочитать книгу',
//   ];

//   // Контроллеры для текстовых полей в диалоговом окне
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   DateTime _selectedDateTime = DateTime.now(); // Добавляем переменную для даты и времени

//   void _addTask() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Добавить задачу'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(labelText: 'Название'),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(labelText: 'Описание'),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   // Открываем диалог выбора даты и времени
//                   showDatePicker(
//                     context: context,
//                     initialDate: _selectedDateTime,
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime.now().add(const Duration(days: 365)),
//                   ).then((pickedDate) {
//                     if (pickedDate == null) return;
//                     // Открываем диалог выбора времени
//                     showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//                     ).then((pickedTime) {
//                       if (pickedTime == null) return;
//                       // Обновляем _selectedDateTime с выбранной датой и временем
//                       setState(() {
//                         _selectedDateTime = DateTime(
//                           pickedDate.year,
//                           pickedDate.month,
//                           pickedDate.day,
//                           pickedTime.hour,
//                           pickedTime.minute,
//                         );
//                       });
//                     });
//                   });
//                 },
//                 child: const Text('Выбрать дедлайн'),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Выбранный дедлайн: ${DateFormat('dd.MM.yy HH:mm').format(_selectedDateTime)}',
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Отмена'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Добавляем новую задачу в список
//                 setState(() {
//                   _tasks.add(_titleController.text);
//                 });
//                 // Очищаем контроллеры
//                 _titleController.clear();
//                 _descriptionController.clear();
//                 // Закрываем диалоговое окно
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Добавить'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Задачи'),
//       ),
//       body: ListView.builder(
//         itemCount: _tasks.length,
//         itemBuilder: (context, index) {
//           return TaskItem(
//             title: _tasks[index],
//             description: 'Описание задачи',
//             deadline: _selectedDateTime, // Передаем выбранную дату и время
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addTask,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import '../widgets/task_item.dart';

// class TasksPage extends StatefulWidget {
//   const TasksPage({Key? key}) : super(key: key);

//   @override
//   State<TasksPage> createState() => _TasksPageState();
// }

// class _TasksPageState extends State<TasksPage> {
//   final List<String> _tasks = [
//     'Купить продукты',
//     'Записаться на прием к врачу',
//     'Позвонить маме',
//     'Сделать уборку',
//     'Прочитать книгу',
//   ];

//   // Контроллеры для текстовых полей в диалоговом окне
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   void _addTask() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Добавить задачу'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(labelText: 'Название'),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(labelText: 'Описание'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Отмена'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Добавляем новую задачу в список
//                 setState(() {
//                   _tasks.add(_titleController.text);
//                 });
//                 // Очищаем контроллеры
//                 _titleController.clear();
//                 _descriptionController.clear();
//                 // Закрываем диалоговое окно
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Добавить'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Задачи'),
//       ),
//       body: ListView.builder(
//         itemCount: _tasks.length,
//         itemBuilder: (context, index) {
//           return TaskItem(
//             title: _tasks[index],
//             description: 'Описание задачи',
//             deadline: DateTime.now(),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addTask,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';

// import '../screens/all_tasks.dart';
// import '../theme/theme.dart';
// import '../screens/profile.dart'; // Import the profile_page

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override 
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = <Widget>[
//     TasksPage(),
//     Text('Сегодня'),
//     Text('Выполнено'),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight, 
//             colors: [
//               DoDidDoneTheme.lightTheme.colorScheme.secondary,
//               DoDidDoneTheme.lightTheme.colorScheme.primary,
//             ],
//           ),
//         ),
//         child: _selectedIndex == 2 // Check if Profile is selected
//             ? const ProfilePage() // Show ProfilePage if selected
//             : Center(
//                 child: _widgetOptions.elementAt(_selectedIndex),
//               ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.task_alt),
//             label: 'Задачи',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Сегодня',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Профиль',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.check_circle),
//             label: 'Выполнено',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
