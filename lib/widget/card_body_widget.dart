import 'package:flutter/material.dart';

class CardBody extends StatelessWidget {
  CardBody({
    super.key,
    required this.item,
    required this.handleDelete,
    required this.index,
    required this.handleEdit,
    required this.handleToggleCompleted,
  });

  var item;
  var index;

  final Function handleDelete;
  final Function(String id, String newName) handleEdit;
  final Function(String id, bool completed) handleToggleCompleted;

  void _showEditDialog(BuildContext context) {
    final controller = TextEditingController(text: item.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chỉnh sửa công việc'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nhập tên mới'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                handleEdit(item.id, controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ((index % 2 == 0)
            ? Color.fromARGB(255, 160, 231, 68)
            : Color.fromARGB(255, 13, 246, 238)),
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Checkbox để đánh dấu hoàn thành
            Checkbox(
              value: item.completed ?? false,
              onChanged: (bool? value) {
                if (value != null) {
                  handleToggleCompleted(item.id, value);
                }
              },
            ),
            SizedBox(width: 8),
            // Text chiếm tối đa chiều ngang, nhiều dòng
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: item.completed == true
                          ? Colors.grey
                          : Color(0xff484848),
                      fontWeight: FontWeight.bold,
                      decoration: item.completed == true
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            // Row chứa 2 nút sửa và xóa sát phải, trên cùng
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showEditDialog(context),
                  tooltip: 'Chỉnh sửa',
                ),
                InkWell(
                  onTap: () async {
                    bool? confirmed = await showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.orange,
                                size: 40,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Bạn có chắc muốn xóa?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text('Hủy'),
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Text('Xóa'),
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                    if (confirmed == true) {
                      handleDelete(item.id);
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Icon(
                    Icons.delete_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
