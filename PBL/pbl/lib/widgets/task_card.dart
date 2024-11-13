import 'package:flutter/material.dart';
import 'package:pbl/Task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  TaskCard({required this.task, required this.onTap});

  Color _getTypeColor() {
    if (task.title.contains('Penelitian')) {
      return Colors.blue.shade100;
    } else if (task.title.contains('Teknis')) {
      return Colors.green.shade100;
    } else if (task.title.contains('Pengabdian')) {
      return Colors.orange.shade100;
    }
    return Colors.grey.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.white, _getTypeColor()],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert, color: Colors.black54),
                          onPressed: onTap,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        task.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today_rounded,
                                size: 16, color: Colors.black54),
                            SizedBox(width: 4),
                            Text(
                              '${task.firstDeadline} - ${task.lastDeadline}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.person_rounded,
                                  size: 16, color: Colors.black87),
                              SizedBox(width: 4),
                              Text(
                                task.progress,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Status indicator
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: task.isOpen ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task.isOpen ? 'Terbuka' : 'Ditutup',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}