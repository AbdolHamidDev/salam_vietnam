import '../models/cultural_article.dart';

abstract class MockChamArticlesRepository {
  static final List<CulturalArticle> articles = [
    CulturalArticle(
      id: 'art_1',
      title: 'Kiến trúc tháp Chăm: Nghệ thuật xây gạch không mạch hồ',
      summary: 'Khám phá bí ẩn kỹ thuật nung và gắn kết gạch của người Chăm cổ qua di tích Po Klong Garai.',
      bodyContent: '''
Tháp Chăm (hay còn gọi là Kalan) là những công trình kiến trúc đất nung độc đáo độc nhất vô nhị tại Việt Nam.

Kỹ thuật gắn kết gạch:
Điểm đặc biệt nhất của các tháp Chăm là các viên gạch được mài khít vào nhau mà không hề thấy vết mạch hồ thô ráp. Theo các nghiên cứu khảo cổ học, người Chăm đã sử dụng nhựa cây dầu rái kết hợp với bột gạch mịn để làm chất liên kết tự nhiên, giúp các ngôi tháp đứng vững qua hàng trăm năm phong sương.

Nghệ thuật điêu khắc trực tiếp:
Sau khi xây tháp xong, các nghệ nhân Chăm cổ mới bắt đầu chạm khắc các hoa văn thần thoại, vũ nữ Apsara hay hoa lá trực tiếp lên bề mặt tường gạch.
''',
      category: 'Kiến trúc & Di sản',
      imageUrl:
          'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=600',
      authorName: 'Ban Biên tập Văn hóa Salam Vietnam',
      sourceAttribution:
          'Trích nguồn từ Hồ sơ Di sản Quốc gia & Viện Nghiên cứu Văn hóa Chăm',
      publishedAt: DateTime(2026, 7, 15),
    ),
    CulturalArticle(
      id: 'art_2',
      title: 'Nghệ thuật gốm Bàu Trúc: Di sản văn hóa phi vật thể UNESCO',
      summary: 'Làng gốm cổ nhất Đông Nam Á với kỹ thuật làm gốm bằng tay và nung lộ thiên độc đáo.',
      bodyContent: '''
Gốm Bàu Trúc (thị trấn Phước Dân, Ninh Thuận) là một trong những làng gốm cổ xưa nhất còn tồn tại ở Đông Nam Á.

Đặc trưng kỹ thuật "tay quay, mông xoay":
Khác với hầu hết các làng gốm khác sử dụng bàn xoay, người phụ nữ Chăm Bàu Trúc làm gốm hoàn toàn bằng tay. Người thợ đi vòng quanh sản phẩm để tạo hình, thể hiện sự khéo léo và tài hoa xuất xúng.

Nung gốm ngoài trời:
Gốm sau khi tạo hình và phơi khô được nung lộ thiên bằng rơm, củi và trấu. Màu sắc gốm Bàu Trúc mang sắc đỏ vàng, nâu đen tự nhiên đặc trưng của đất mẹ.
''',
      category: 'Làng nghề Truyền thống',
      imageUrl:
          'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=600',
      authorName: 'Nghiên cứu viên Văn hóa Chăm',
      sourceAttribution: 'Trích tài liệu UNESCO & Sở VHTTDL Tỉnh Ninh Thuận',
      publishedAt: DateTime(2026, 8, 20),
    ),
  ];
}
