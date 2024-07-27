import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../services/employee_services.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Data"),
        actions: [
          IconButton(
              onPressed: () {
                print(EmployeeServices().getAllEmployeeData());
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
          future: EmployeeServices().getAllEmployeeData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error fetching employee Data"),
              );
            }

            if (snapshot.hasData) {
              var data = snapshot.data as List<Employee>;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data[index].avatar!),
                      ),
                      title: Text(
                          "${data[index].firstName} ${data[index].lastName}"),
                      subtitle: Text(data[index].email!),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
