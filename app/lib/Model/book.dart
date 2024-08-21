class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String authorImg;
  final String publisher;
  final String publishedDate;
  final String description;
  final List<String> categories;
  final String thumbnail;
  final String language;
  final int pageCount;
  final bool isEbook;
  final double price;
  final String summary;
  final double ratings;
  final List<Review> reviews;
  final bool bestseller;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.authorImg,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.categories,
    required this.thumbnail,
    required this.language,
    required this.pageCount,
    required this.isEbook,
    required this.price,
    required this.summary,
    required this.ratings,
    required this.reviews,
    required this.bestseller,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      authors: List<String>.from(json['author'] ?? []),
      authorImg: json['authors_img'] ?? '',
      publisher: json['publisher'] ?? '',
      publishedDate: json['publishedDate'] ?? '',
      description: json['description'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      thumbnail: json['thumbnail'] ?? '',
      language: json['language'] ?? '',
      pageCount: json['pageCount'] ?? 0,
      isEbook: json['isEbook'] ?? false,
      price: json['price']?.toDouble() ?? 0.00,
      summary: json['summary'] ?? 'not available',
      ratings: json['ratings']?.toDouble() ?? 0.0,
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((review) => Review.fromJson(review))
              .toList() ??
          [],
      bestseller: json['bestseller'] ?? false,
    );
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String,
      title: map['title'] as String,
      authors: List<String>.from(map['author'] ?? []),
      authorImg: map['authors_img'] ?? '',
      publisher: map['publisher'] as String? ?? '',
      publishedDate: map['publishedDate'] as String? ?? '',
      description: map['description'] as String? ?? '',
      categories: List<String>.from(map['categories'] ?? []),
      thumbnail: map['thumbnail'] as String? ?? '',
      language: map['language'] as String? ?? '',
      pageCount: map['pageCount'] as int? ?? 0,
      isEbook: map['isEbook'] as bool? ?? false,
      price: map['price'] as double? ?? 0.00,
      summary: map['summary'] as String? ?? 'not available',
      ratings: map['ratings'] as double? ?? 0.0,
      reviews: (map['reviews'] as List<dynamic>?)
              ?.map((review) => Review.fromMap(review))
              .toList() ??
          [],
      bestseller: map['bestseller'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'authors_img': authorImg,
      'publisher': publisher,
      'publishedDate': publishedDate,
      'description': description,
      'categories': categories,
      'thumbnail': thumbnail,
      'language': language,
      'pageCount': pageCount,
      'isEbook': isEbook,
      'price': price,
      'summary': summary,
      'ratings': ratings,
      'reviews': reviews.map((review) => review.toMap()).toList(),
      'bestseller': bestseller,
    };
  }
}

class Review {
  final String image;
  final String name;
  final String review;

  Review({
    required this.image,
    required this.name,
    required this.review,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      review: json['review'] ?? '',
    );
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      review: map['review'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'review': review,
    };
  }
}
