import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/student_bloc.dart';
import '../models/student.dart';
import '../enums/gender_enum.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(LoadStudents());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is StudentLoading) {
          return const Center(child: FCircularProgress());
        } else if (state is StudentsLoaded) {
          final filteredStudents = state.students.where((student) {
            return student.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
          }).toList();

          return FScaffold(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with search and add button
                  Row(
                    children: [
                      Expanded(
                        child: Material(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search students...',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      FButton(
                        onPress: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => _buildStudentForm(),
                          );
                        },
                        suffix: const Icon(Icons.add),
                        child: const Text('Add Student'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Students list
                  Expanded(child: _buildStudentsList(filteredStudents)),
                ],
              ),
            ),
          );
        } else {
          return const FScaffold(
            child: Center(child: Text('Failed to load students')),
          );
        }
      },
    );
  }

  Widget _buildStudentsList(List<Student> students) {
    if (students.isEmpty) {
      return const Center(child: Text('No students found'));
    }

    return FItemGroup.builder(
      itemBuilder: (context, index) {
        final student = students[index];
        return FItem(
          prefix: FAvatar.raw(child: Text(student.name[0].toUpperCase())),
          title: Text(student.name),
          subtitle: Text(
            '${student.gender.displayName} • ${student.isActive ? 'Active' : 'Inactive'}',
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FButton(
                child: Icon(Icons.edit),
                onPress: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => _buildStudentForm(student),
                  );
                },
              ),
              FButton(
                child: Icon(Icons.delete),
                onPress: () => _deleteStudent(student),
              ),
            ],
          ),
          onPress: () => _showStudentDetails(student),
        );
      },
      count: students.length,
    );
  }

  Widget _buildStudentForm([Student? student]) {
    final isEditing = student != null;
    String name = isEditing ? student!.name : '';
    GenderEnum gender = isEditing ? student!.gender : GenderEnum.male;
    bool isActive = isEditing ? student!.isActive : true;

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEditing ? 'Edit Student' : 'Add New Student',
              style: context.theme.typography.xl,
            ),
            const SizedBox(height: 16),
            Material(
              child: TextFormField(
                initialValue: name,
                onChanged: (value) => name = value,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Material(
              child: DropdownButtonFormField<GenderEnum>(
                value: gender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: GenderEnum.values.map((g) {
                  return DropdownMenuItem(value: g, child: Text(g.displayName));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Material(
              child: DropdownButtonFormField<bool>(
                value: isActive,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: true, child: Text('Active')),
                  DropdownMenuItem(value: false, child: Text('Inactive')),
                ],
                onChanged: (value) {
                  setState(() {
                    isActive = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: FButton(
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                    variant: .outline,
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FButton(
                    onPress: () {
                      final updatedStudent = isEditing
                          ? student!.copyWith(
                              name: name.trim(),
                              gender: gender,
                              isActive: isActive,
                            )
                          : Student(
                              id: '',
                              name: name.trim(),
                              gender: gender,
                              isActive: isActive,
                            );

                      if (isEditing) {
                        context.read<StudentBloc>().add(
                          UpdateStudent(updatedStudent.id, updatedStudent),
                        );
                      } else {
                        context.read<StudentBloc>().add(
                          CreateStudent(updatedStudent),
                        );
                      }

                      Navigator.of(context).pop();
                    },
                    child: Text(isEditing ? 'Update' : 'Add'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteStudent(Student student) {
    showDialog(
      context: context,
      builder: (context) => FDialog(
        title: const Text('Delete Student'),
        body: Text('Are you sure you want to delete "${student.name}"?'),
        actions: [
          FButton(
            onPress: () => Navigator.of(context).pop(),
            variant: .outline,
            child: const Text('Cancel'),
          ),
          FButton(
            onPress: () {
              context.read<StudentBloc>().add(DeleteStudent(student.id));
              Navigator.of(context).pop();
            },
            variant: .destructive,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showStudentDetails(Student student) {
    showDialog(
      context: context,
      builder: (context) => FDialog(
        title: Text(student.name),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gender: ${student.gender.displayName}'),
            Text('Status: ${student.isActive ? 'Active' : 'Inactive'}'),
          ],
        ),
        actions: [
          FButton(
            onPress: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
