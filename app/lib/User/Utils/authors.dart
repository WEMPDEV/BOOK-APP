import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authors extends StatelessWidget {
  final int limit;

  const Authors({super.key, this.limit = 10});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('books')
          .limit(limit)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load authors'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No authors found'));
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final author = data['authors']?.first ?? 'Unknown Author';
              final authorImg = data['author_img'] ?? '';

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0),
                child: InkWell(
                  onTap: () {
                    // Define onTap action if needed
                  },
                  child: Container(
                    width: 100,
                    height: 85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipOval(
                          child: authorImg.isNotEmpty
                              ? Image.network(
                                  authorImg,
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 65,
                                  height: 65,
                                  color: Colors.grey,
                                  child: Center(child: Text('No Image')),
                                ),
                        ),
                        Text(
                          author,
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
