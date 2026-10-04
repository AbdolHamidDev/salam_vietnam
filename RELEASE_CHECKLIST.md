# Checklist Chuẩn bị Khởi chạy & Phát hành Salam Vietnam

Tài liệu này cung cấp danh mục kiểm tra toàn diện trước khi phát hành ứng dụng **Salam Vietnam**.

---

## 1. Kiểm tra An toàn & Môi trường

- [x] **Không lộ Secret Key**: Đã xác nhận không nhúng Supabase `service_role` key hay thông tin bảo mật vào mã nguồn.
- [x] **Cấu hình Động**: `SUPABASE_URL` và `SUPABASE_ANON_KEY` được truyền qua `--dart-define` khi build.
- [x] **Chế độ Offline/Pilot**: Khi không có URL/Anon Key, ứng dụng tự động chạy mượt mà ở chế độ pilot sample dataset.

---

## 2. Kiểm tra Chất lượng Mã nguồn (Quality Assurance)

- [x] **Định dạng code**: `dart format .` không có lỗi.
- [x] **Phân tích tĩnh**: `flutter analyze` đạt **`No issues found!`** (0 Error, 0 Warning).
- [x] **Kiểm thử tự động**: `flutter test` pass 100% các bài test (`6/6 passed`).

---

## 3. Lệnh Khởi chạy & Build ứng dụng

### Khởi chạy Môi trường Phát triển (Development/Pilot):
```bash
flutter run
```

### Khởi chạy với Backend Supabase Thật:
```bash
flutter run \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key-here
```

### Build APK Android Release:
```bash
flutter build apk --release \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key-here
```

### Build AppBundle Android (đăng tải Google Play Store):
```bash
flutter build appbundle --release \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key-here
```
