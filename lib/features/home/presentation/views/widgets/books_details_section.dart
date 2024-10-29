import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custime_error_widget.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/Custome_Book_item.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/books_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .23),
          child: CustomeBookImage(
            // imageUrl: book.volumeInfo.imageLinks?.thumbnail ?? '',
            imageUrl: book.volumeInfo.imageLinks?.thumbnail ??
                'Assets/images/book.jpg',
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Align(
          alignment: Alignment.center,
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              book.volumeInfo.title!,
              style: Styles.textStyle30.copyWith(
                  fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          book.volumeInfo.authors![0],
          style: Styles.textStyle18.copyWith(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 12,
        ),
        BookRating(
          rating: book.volumeInfo.pageCount ?? 0,
          count: book.volumeInfo.pageCount ?? 0,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        const SizedBox(
          height: 32,
        ),
        BooksAction(
          bookModel: book,
        ),
      ],
    );
  }
}
