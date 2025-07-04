import 'package:flutter/material.dart';
import '../models/book.dart';

class BookStack extends StatelessWidget {
  final List<Book> books;
  final Function(Book) onTap;

  const BookStack({super.key, required this.books, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const double spacing = 6.0;

    // 페이지 수에 따라 높이 계산
    final List<double> blockHeights = books.map((book) {
      return (book.pages / 8).clamp(20.0, 120.0);
    }).toList();

    // bottom 기준 위치 계산
    final List<double> positions = [];
    double currentBottom = 0;
    for (final height in blockHeights) {
      positions.add(currentBottom);
      currentBottom += height + spacing;
    }

    final double totalHeight = currentBottom;

    return SingleChildScrollView(
      reverse: true, // 스크롤 아래로 기본 위치
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: totalHeight,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: books.asMap().entries.map((entry) {
              final index = entry.key;
              final book = entry.value;
              final height = blockHeights[index];
              final bottom = positions[index];

              // 원형 큐 구조
              final Color color = Color.lerp(
                const Color(0xFFFFF0B3),
                const Color(0xFFF5B849),
                (index % books.length) / books.length,  // 원형 큐를 반영한 비율 계산
              )!;

              return Positioned(
                bottom: bottom,
                child: GestureDetector(
                  onTap: () => onTap(book),
                  child: Container(
                    width: 200,
                    height: height,
                    margin: const EdgeInsets.symmetric(vertical: spacing / 2),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.brown.shade300, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.2),
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      book.title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
