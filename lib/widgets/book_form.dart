import 'package:flutter/material.dart';
import '../models/book.dart';

class BookForm extends StatefulWidget {
  final Function(Book) onAddBook;
  final bool editMode;
  final Book? initialBook;
  final Function(Book)? onEdit;
  final VoidCallback? onDelete;

  const BookForm({
    super.key,
    required this.onAddBook,
    this.editMode = false,
    this.initialBook,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String author;
  late String memo;
  late int pages;

  @override
  void initState() {
    super.initState();
    final book = widget.initialBook;
    title = book?.title ?? '';
    author = book?.author ?? '';
    memo = book?.memo ?? '';
    pages = book?.pages ?? 0;
  }

  void _submit() {
    _formKey.currentState?.save();
    final newBook = Book(
      title: title,
      author: author,
      pages: pages,
      memo: memo,
    );
    if (widget.editMode && widget.onEdit != null) {
      widget.onEdit!(newBook);
    } else {
      // Stack 구조에 책을 추가하는 방식 (맨 앞에 추가)
      widget.onAddBook(newBook);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: title,
            decoration: _inputDecoration("제목"),
            onSaved: (val) => title = val ?? '',
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: author,
            decoration: _inputDecoration("작가"),
            onSaved: (val) => author = val ?? '',
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: pages == 0 ? '' : pages.toString(),
            decoration: _inputDecoration("페이지 수"),
            keyboardType: TextInputType.number,
            onSaved: (val) => pages = int.tryParse(val ?? '0') ?? 0,
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: memo,
            decoration: _inputDecoration("메모"),
            onSaved: (val) => memo = val ?? '',
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submit,
            child: Text(widget.editMode ? "수정 완료" : "책 등록"),
          ),
          if (widget.editMode && widget.onDelete != null)
            TextButton(
              onPressed: () {
                widget.onDelete!();
                Navigator.pop(context);
              },
              child: const Text("삭제하기", style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
