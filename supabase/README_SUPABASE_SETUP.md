# Hướng dẫn Thiết lập Backend Supabase cho Salam Vietnam

Tài liệu này hướng dẫn cách áp dụng các file migration SQL vào Supabase và cấu hình ứng dụng Flutter **Salam Vietnam** kết nối an toàn với backend.

---

## 1. Cấu trúc SQL Migrations

Các file migration nằm trong thư mục `supabase/migrations/`:

1. **`001_initial_schema.sql`**: Khai báo toàn bộ cấu trúc bảng PostgreSQL chuẩn mực (UUID primary keys, PostGIS coordinates, `places`, `place_translations`, `categories`, `halal_verifications`, `place_submissions`, `cultural_articles`, `article_translations`).
2. **`002_security_rls.sql`**: Bật Row Level Security (RLS) cho tất cả các bảng. Công khai quyền READ cho dữ liệu đã xuất bản (`published`) và công khai quyền INSERT đóng góp mới ở trạng thái mặc định `pending`.
3. **`003_seed_data.sql`**: Dữ liệu khởi tạo pilot ban đầu.

---

## 2. Các bước áp dụng Migration trên Supabase Dashboard

1. Đăng nhập vào [Supabase Dashboard](https://supabase.com/dashboard) và chọn Project của bạn.
2. Vào mục **SQL Editor** từ menu bên trái.
3. Lần lượt chạy các script theo đúng thứ tự:
   - Copy nội dung `001_initial_schema.sql` -> dán vào SQL Editor -> nhấn **Run**.
   - Copy nội dung `002_security_rls.sql` -> dán vào SQL Editor -> nhấn **Run**.
   - Copy nội dung `003_seed_data.sql` -> dán vào SQL Editor -> nhấn **Run**.

---

## 3. Khởi chạy Ứng dụng Flutter với Cấu hình Supabase

Ứng dụng đọc URL và Anon Key công khai thông qua tham số `--dart-define` an toàn:

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key-here
```

### Lưu ý Bảo mật Quan trọng:
- **Tuyệt đối KHÔNG** sử dụng `service_role` key trên ứng dụng Flutter.
- Mọi thao tác ghi/sửa dữ liệu từ người dùng công khai bắt buộc phải tuân theo chính sách RLS trong `002_security_rls.sql`.
