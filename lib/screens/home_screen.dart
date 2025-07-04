import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_stack.dart';
import '../widgets/book_form.dart';
import '../widgets/quote_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Book> bookList = [];
  List<Book> bookStack = [];

  final List<int> goalStages = [5, 10, 20, 50, 100, 200, 500];
  int goalIndex = 0;
  int get goalCount => goalStages[goalIndex];

  List<String> goalHistory = [];
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _updateProgress() {
    final newProgress = (bookList.length / goalCount).clamp(0.0, 1.0);
    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: newProgress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward(from: 0.0);
  }

  void _addBook(Book book) {
    setState(() {
      bookList.add(book);
      bookStack.add(book);
      _updateProgress();
    });

    if (bookList.length == goalCount) {
      final now = DateTime.now();
      final formatted =
          "${now.year}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}";
      goalHistory.add("✅ $goalCount권 달성: $formatted");

      Future.delayed(const Duration(milliseconds: 600), () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('🎉 목표 달성!'),
            content: Text('축하합니다! $goalCount권을 읽으셨습니다!\n📅 $formatted'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('닫기'),
              ),
            ],
          ),
        );
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          if (goalIndex < goalStages.length - 1) {
            goalIndex++;
          }
          _updateProgress();
        });
      });
    }
  }

  void _editBook(int index, Book updated) {
    setState(() {
      bookList[index] = updated;
      bookStack[index] = updated;
    });
  }

  void _deleteBook(int index) {
    setState(() {
      bookList.removeAt(index);
      bookStack.removeAt(index);
      _updateProgress();
    });
  }

  void _showBookMenu(Book book, int index) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("정보 보기"),
            onTap: () {
              Navigator.pop(context);
              _showBookInfo(book);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("수정 / 삭제"),
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 16,
                    right: 16,
                    top: 24,
                  ),
                  child: BookForm(
                    onAddBook: _addBook,
                    editMode: true,
                    initialBook: book,
                    onEdit: (editedBook) => _editBook(index, editedBook),
                    onDelete: () => _deleteBook(index),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showBookInfo(Book book) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(book.title),
        content: Text(
          "저자: ${book.author}\n페이지 수: ${book.pages}\n메모: ${book.memo}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showGoalHistory() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('📜 목표 달성 기록'),
        content: goalHistory.isEmpty
            ? const Text('아직 달성한 목표가 없습니다.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: goalHistory
                    .map((e) => ListTile(title: Text(e)))
                    .toList(),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text("📚 나만의 책탑"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFD95A),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: '목표 달성 기록',
            onPressed: _showGoalHistory,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: '책 등록',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 16,
                    right: 16,
                    top: 24,
                  ),
                  child: BookForm(onAddBook: _addBook),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          QuoteHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("📘 목표: $goalCount권 중 ${bookList.length}권"),
                const SizedBox(height: 8),
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) => LinearProgressIndicator(
                    value: _progressAnimation.value,
                    minHeight: 14,
                    backgroundColor: Colors.brown.shade100,
                    color: Colors.brown.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: BookStack(
              books: bookStack,
              onTap: (book) {
                final index = bookStack.indexOf(book);
                _showBookMenu(book, index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 스플래쉬 화면
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFAF4E0),
      body: Center(child: Text('Book Tracker', style: TextStyle(fontSize: 28))),
    );
  }
}