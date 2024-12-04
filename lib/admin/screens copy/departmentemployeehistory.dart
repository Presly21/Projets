import 'package:flutter/material.dart';
import 'package:nexmax_hrms/admin/screens%20copy/adddepartment.dart';

class Employee {
  final String name;
  final String avatar;
  final DateTime startDate;
  final DateTime endDate;
  final double salary;

  Employee({
    required this.name,
    required this.avatar,
    required this.startDate,
    required this.endDate,
    required this.salary,
  });
}

class Department {
  final String name;
  final int numberOfEmployees;
  final List<String> employeeAvatars;
  final List<Employee> employees;

  Department({
    required this.name,
    required this.numberOfEmployees,
    required this.employeeAvatars,
    required this.employees,
  });
}

// ignore: use_key_in_widget_constructors
class DepartmentListPage extends StatelessWidget {
  final List<Department> departments = [
    Department(
      name: 'IT Department',
      numberOfEmployees: 12,
      employeeAvatars: [
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
      ],
      employees: [
        Employee(
          name: 'John Doe',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2020, 1, 1),
          endDate: DateTime(2023, 1, 1),
          salary: 50000,
        ),
        Employee(
          name: 'Jane Smith',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2021, 2, 1),
          endDate: DateTime(2024, 2, 1),
          salary: 55000,
        ),
      ],
    ),
    Department(
      name: 'Human Resources',
      numberOfEmployees: 8,
      employeeAvatars: [
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
      ],
      employees: [
        Employee(
          name: 'Alice Brown',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2019, 3, 1),
          endDate: DateTime(2022, 3, 1),
          salary: 45000,
        ),
        Employee(
          name: 'Bob Johnson',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2020, 4, 1),
          endDate: DateTime(2023, 4, 1),
          salary: 47000,
        ),
      ],
    ),
    Department(
      name: 'Marketing Department',
      numberOfEmployees: 10,
      employeeAvatars: [
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
      ],
      employees: [
        Employee(
          name: 'Charlie Green',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2018, 5, 1),
          endDate: DateTime(2021, 5, 1),
          salary: 48000,
        ),
        Employee(
          name: 'Diana White',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2019, 6, 1),
          endDate: DateTime(2022, 6, 1),
          salary: 49000,
        ),
      ],
    ),
    Department(
      name: 'Finance Department',
      numberOfEmployees: 6,
      employeeAvatars: [
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
      ],
      employees: [
        Employee(
          name: 'Edward Black',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2021, 7, 1),
          endDate: DateTime(2024, 7, 1),
          salary: 52000,
        ),
        Employee(
          name: 'Fiona Yellow',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2022, 8, 1),
          endDate: DateTime(2025, 8, 1),
          salary: 53000,
        ),
      ],
    ),
    Department(
      name: 'Operations',
      numberOfEmployees: 15,
      employeeAvatars: [
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
      ],
      employees: [
        Employee(
          name: 'George Blue',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2020, 9, 1),
          endDate: DateTime(2023, 9, 1),
          salary: 54000,
        ),
        Employee(
          name: 'Hannah Purple',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2021, 10, 1),
          endDate: DateTime(2024, 10, 1),
          salary: 56000,
        ),
      ],
    ),
    Department(
      name: 'Sales Department',
      numberOfEmployees: 9,
      employeeAvatars: [
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
        'assets/images/mypicture.jpg',
      ],
      employees: [
        Employee(
          name: 'Ivan Red',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2019, 11, 1),
          endDate: DateTime(2022, 11, 1),
          salary: 57000,
        ),
        Employee(
          name: 'Judy Pink',
          avatar: 'assets/images/mypicture.jpg',
          startDate: DateTime(2020, 12, 1),
          endDate: DateTime(2023, 12, 1),
          salary: 58000,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: departments
              .map((department) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepartmentDetailPage(department: department),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                department.name,
                                style: const TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              Text('Number of : ${department.numberOfEmployees}'),
                              const SizedBox(height: 8.0),
                              SizedBox(
                                height: 50.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: department.employeeAvatars.length,
                                  itemBuilder: (context, avatarIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 6.0),
                                      child: CircleAvatar(
                                        radius: 20.0,
                                        backgroundImage: AssetImage(department
                                            .employeeAvatars[avatarIndex]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: department.employees
                                    .map((employee) => Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20.0,
                                                backgroundImage: AssetImage(employee.avatar),
                                              ),
                                              const SizedBox(width: 10.0),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    employee.name,
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Start Date: ${employee.startDate.toLocal()}'.split(' ')[0],
                                                  ),
                                                  Text(
                                                    'End Date: ${employee.endDate.toLocal()}'.split(' ')[0],
                                                  ),
                                                  Text(
                                                    'Salary: \$${employee.salary}',
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DepartmentFormPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class DepartmentDetailPage extends StatelessWidget {
  final Department department;

  // ignore: use_key_in_widget_constructors
  const DepartmentDetailPage({required this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(department.name),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                department.name,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Number of Employees: ${department.numberOfEmployees}',
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: department.employees.map((employee) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage(employee.avatar),
                        ),
                        const SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              employee.name,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Start Date: ${employee.startDate.toLocal()}'.split(' ')[0]),
                            Text('End Date: ${employee.endDate.toLocal()}'.split(' ')[0]),
                            Text('Salary: \$${employee.salary}'),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DepartmentListPage(),
  ));
}
