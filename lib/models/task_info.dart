class TaskInfo {
  final int id;
  final String title;
  final String? description;
  final DateTime taskExecutionDate;
  final int priorty;
  final bool isDone;

  TaskInfo(
      {required this.id,
      required this.title,
      this.description = '',
      required this.taskExecutionDate,
      required this.priorty,
      this.isDone = false});
}
