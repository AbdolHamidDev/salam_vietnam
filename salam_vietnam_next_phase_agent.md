# Salam Vietnam — Kế hoạch tiếp tục sau MVP

## 1. Mục đích

Tài liệu này hướng dẫn AI coding agent tiếp tục dự án Salam Vietnam sau khi MVP được báo cáo là hoàn thành.

**Không mặc định MVP đã hoàn thiện chỉ dựa trên bản tổng kết.** Hãy kiểm tra mã nguồn, cấu hình, migration và kết quả chạy thực tế để xác nhận từng chức năng. Mục tiêu tiếp theo là đưa ứng dụng sang trạng thái đã được kiểm thử, có thể cấu hình backend an toàn và sẵn sàng cho thử nghiệm pilot.

## 2. Quy tắc bắt buộc

- Đọc `salam_vietnam_prd_for_ai_agent.md` và tài liệu này trước khi thực hiện.
- Chỉ làm việc trong dự án Salam Vietnam. Không sửa, di chuyển hoặc sao chép mã từ MuslimVN.
- Không xóa/ghi đè file, chạy lệnh phá hủy dữ liệu hoặc thay đổi kiến trúc lớn khi chưa giải thích và xin xác nhận.
- Không giả định đã có URL/khóa Supabase. Không yêu cầu người dùng gửi `service_role` key.
- Không đưa secret vào mã nguồn, Git, log hoặc file được commit.
- Không bịa địa điểm, chứng nhận Halal, trích dẫn, giờ mở cửa, số điện thoại hoặc dữ liệu du lịch.
- Phân biệt rõ dữ liệu mẫu, dữ liệu do cơ sở tự khai báo và dữ liệu đã xác minh.
- Không tuyên bố kiểm thử thành công nếu chưa chạy lệnh và xem kết quả.
- Giữ thay đổi nhỏ, theo từng giai đoạn. Báo cáo file thay đổi và kết quả sau mỗi giai đoạn.
- Nếu quyết định ảnh hưởng lớn đến kiến trúc, dữ liệu hoặc chi phí, hãy dừng lại và hỏi người dùng.

## 3. Bối cảnh sản phẩm

Salam Vietnam là ứng dụng khám phá du lịch Halal và di sản, văn hóa Chăm tại Việt Nam.

Các yêu cầu cần giữ:
- Ba ngôn ngữ: tiếng Việt, tiếng Anh và tiếng Mã Lai.
- Design System riêng, hiện đại, lấy cảm hứng từ sự rõ ràng của iOS nhưng không sao chép hoàn toàn iOS.
- Bốn tab chính: Khám phá, Bản đồ, Đã lưu, Cài đặt.
- Khám phá địa điểm, tìm kiếm/lọc, trang chi tiết, yêu thích, gửi đề xuất/báo cáo, nội dung di sản và văn hóa Chăm.
- Trạng thái xác minh địa điểm phải tách biệt với trạng thái Halal. Các trạng thái Halal được báo cáo gồm Verified, Self-declared, Unverified, Expired và Disputed.
- Dữ liệu mẫu phải được gắn nhãn rõ, không được trình bày như dữ liệu thật đã xác minh.
- Backend dự kiến dùng Supabase. Khi chưa có cấu hình, ứng dụng nên có thể chạy ở chế độ dữ liệu pilot nếu hành vi này thực sự đã được triển khai và kiểm thử.

Báo cáo trước đề cập các migration `001_initial_schema.sql`, `002_security_rls.sql`, `003_seed_data.sql`. Hãy xác minh các file này tồn tại và đọc nội dung trước khi dựa vào thông tin trên.

## 4. Giai đoạn 0 — Kiểm toán thực tế (chỉ đọc)

Trước tiên, kiểm tra dự án mà không chỉnh sửa file.

### 4.1 Kiểm tra cấu trúc
- Cấu trúc `lib/`, `test/`, `assets/`, thư mục migration và cấu hình nền tảng.
- `pubspec.yaml`, phiên bản Flutter/Dart và các package.
- Cấu hình localization, file bản dịch, routing, state management và theme/design tokens.
- Cách ứng dụng chọn Supabase hay dữ liệu pilot.
- README hoặc hướng dẫn chạy hiện có.

### 4.2 Kiểm tra chức năng
Lập bảng trạng thái cho từng chức năng: **đã tìm thấy trong code**, **đã kiểm thử xác nhận**, **đã triển khai nhưng chưa kiểm chứng**, hoặc **chưa triển khai/đang lỗi**.

Rà soát:
1. Khởi chạy và điều hướng bốn tab.
2. Chọn Việt/Anh/Mã Lai và cập nhật giao diện.
3. Khám phá, tìm kiếm, lọc theo tỉnh/thành và trạng thái Halal.
4. Trang chi tiết địa điểm, nguồn và bằng chứng xác minh.
5. Lưu/bỏ lưu địa điểm.
6. Gửi địa điểm hoặc báo cáo thông tin, trạng thái chờ kiểm duyệt.
7. Nội dung di sản/văn hóa Chăm và nguồn trích dẫn.
8. Bản đồ, quyền vị trí và tình huống không có mạng.
9. Chế độ pilot khi thiếu cấu hình Supabase.
10. Kết nối Supabase khi cấu hình hợp lệ.
11. Trạng thái tải, danh sách rỗng, lỗi mạng và thử lại.
12. Khả năng tiếp cận cơ bản: tương phản, cỡ chữ, vùng chạm và nhãn tương tác.

### 4.3 Kiểm tra chất lượng
Chạy các lệnh không phá hủy phù hợp, tối thiểu:
- `flutter pub get`
- `dart format --output=none --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`

Nếu lệnh không chạy được, ghi rõ nguyên nhân. Không sửa hàng loạt chỉ để làm kết quả trông như thành công.

### 4.4 Báo cáo và dừng
Báo cáo:
1. Tình trạng thực tế.
2. Bảng chức năng kèm bằng chứng kiểm chứng.
3. Lỗi/rủi ro theo mức nghiêm trọng, cao, trung bình, thấp.
4. Các lệnh đã chạy và kết quả.
5. Thứ tự xử lý đề xuất.

**Dừng tại đây và chờ người dùng đồng ý trước khi chỉnh sửa mã nguồn.**

## 5. Giai đoạn 1 — Sửa lỗi nền tảng

Chỉ thực hiện sau khi người dùng duyệt kết quả kiểm toán.

Ưu tiên:
1. Sửa lỗi khiến ứng dụng không chạy hoặc chức năng chính không hoạt động.
2. Sửa lỗi phân tích tĩnh và test thất bại.
3. Bảo đảm chuyển đổi ngôn ngữ không gây lỗi giao diện hoặc mất trạng thái không mong muốn.
4. Bổ sung trạng thái tải, rỗng, lỗi và thử lại phù hợp.
5. Bảo đảm dữ liệu pilot luôn có nhãn rõ.
6. Kiểm tra điều hướng, yêu thích và biểu mẫu đóng góp.
7. Giảm trùng lặp code khi an toàn và nằm trong phạm vi nhỏ.

Không thêm tính năng mới trước khi xử lý các lỗi nền tảng. Sau đó chạy lại các kiểm tra liên quan và báo cáo.

## 6. Giai đoạn 2 — Supabase và bảo mật

Không cần thông tin đăng nhập thật để rà soát mã nguồn và SQL. Chỉ kết nối project Supabase thật khi người dùng đã cung cấp cấu hình public cần thiết và xác nhận muốn kết nối.

### 6.1 Schema và migration
- Kiểm tra khóa chính/ngoại, kiểu dữ liệu, ràng buộc, chỉ mục và trường thời gian.
- Kiểm tra tính nhất quán giữa SQL schema và model/repository Flutter.
- Kiểm tra các bảng địa điểm, bản dịch, danh mục, trạng thái Halal, nguồn, ảnh, bài viết, đóng góp và yêu thích theo PRD.
- Kiểm tra thứ tự chạy migration và hướng dẫn áp dụng.
- Kiểm tra seed data có được đánh dấu là mẫu, không ám chỉ đã xác minh thực tế.

Không chạy migration trên backend đang chứa dữ liệu thật nếu chưa được người dùng xác nhận và chưa nêu rõ tác động.

### 6.2 Row Level Security (RLS)
Kiểm tra nguyên tắc quyền tối thiểu:
- Người chưa đăng nhập chỉ đọc được dữ liệu công khai cần thiết.
- Người dùng chỉ đọc/sửa dữ liệu cá nhân của mình, ví dụ danh sách yêu thích.
- Người dùng không thể tự phê duyệt đóng góp hoặc tự cấp trạng thái Verified.
- Quyền kiểm duyệt chỉ dành cho vai trò được phép; không thể giả mạo từ client.
- Không bật quyền ghi rộng chỉ để tránh lỗi giao diện.
- Không dùng `service_role` key trong Flutter.
- Kiểm tra chính sách insert/update/delete, không chỉ quyền đọc.

Nếu phát hiện lỗ hổng, mô tả rủi ro và đề xuất cách sửa trước khi áp dụng.

### 6.3 Cấu hình môi trường
- Xác minh cách truyền `SUPABASE_URL` và `SUPABASE_ANON_KEY`.
- Chỉ dùng khóa public/anon dành cho client; RLS vẫn phải được cấu hình đúng.
- Không commit file chứa thông tin nhạy cảm.
- Nếu chưa có cấu hình, giữ chế độ pilot và cung cấp hướng dẫn an toàn.
- Xử lý URL/anon key thiếu, sai định dạng hoặc lỗi kết nối mà không làm ứng dụng treo hay mất toàn bộ khả năng sử dụng.

Không tự tạo project Supabase, triển khai cloud hoặc phát sinh chi phí.

## 7. Giai đoạn 3 — Sẵn sàng cho dữ liệu pilot

Mục tiêu là xây dựng quy trình quản lý dữ liệu có nguồn gốc, không tự điền dữ liệu chưa xác minh.

- Mỗi địa điểm cần có nguồn, ngày kiểm tra/cập nhật và trạng thái xác minh.
- Phân biệt nguồn chính thức, nguồn cộng đồng và thông tin do cơ sở tự khai báo.
- Với Halal Verified, lưu bằng chứng, đơn vị xác minh nếu có, ngày xác minh và ngày hết hạn nếu áp dụng.
- Nếu bằng chứng hết hiệu lực hoặc có tranh chấp, không tiếp tục hiển thị như đã xác minh hiện hành.
- Hỗ trợ báo cáo thông tin sai hoặc hết hạn.
- Không công khai thông tin nhạy cảm của người gửi đóng góp.
- Bài viết văn hóa cần nguồn trích dẫn kiểm tra được; không bịa nguồn.
- Không thu thập vị trí khi không cần thiết; giải thích mục đích và xử lý trường hợp người dùng từ chối quyền.

Trước khi nhập dữ liệu thật trên diện rộng, đề xuất quy trình biên tập và kiểm duyệt có người chịu trách nhiệm.

## 8. Giai đoạn 4 — Hoàn thiện trải nghiệm và chuẩn bị pilot

Sau khi nền tảng, kiểm thử và bảo mật đạt yêu cầu, kiểm tra:
- Kích thước màn hình phổ biến và vùng an toàn.
- Bàn phím, cuộn, bottom sheet, dialog và biểu mẫu.
- Offline/mạng yếu.
- Hiệu năng danh sách và ảnh.
- Quyền vị trí và trường hợp người dùng từ chối.
- Bản dịch không bị cắt/tràn.
- Icon, tên ứng dụng, màn hình khởi động và metadata nền tảng.
- Chính sách quyền riêng tư và giải thích việc thu thập dữ liệu trước pilot.

Không tự phát hành lên cửa hàng ứng dụng. Chỉ chuẩn bị checklist/lệnh build; hỏi người dùng trước thao tác phát hành hoặc ký ứng dụng.

## 9. Báo cáo sau mỗi giai đoạn

### Đã làm
- Thay đổi chính và lý do.

### File thay đổi
- Đường dẫn file — mục đích.

### Kiểm tra
- Lệnh đã chạy và kết quả thực tế.
- Test chưa chạy và lý do.

### Vấn đề còn lại
- Lỗi/rủi ro chưa giải quyết.
- Cấu hình hoặc quyết định cần người dùng cung cấp.

### Bước tiếp theo
- Chỉ đề xuất một giai đoạn tiếp theo phù hợp.
- Không tự động chuyển giai đoạn khi chưa được người dùng đồng ý.

## 10. Bắt đầu ngay

Bắt đầu với **Giai đoạn 0 — Kiểm toán trạng thái thực tế**.

Chỉ đọc file và kiểm tra dự án. Chạy các lệnh kiểm tra không phá hủy nếu môi trường cho phép. Không chỉnh sửa mã nguồn, không cài package ngoài nhu cầu kiểm tra, không kết nối hoặc thay đổi backend thật.

Kết thúc bằng báo cáo ngắn gọn có bằng chứng cụ thể từ file, lệnh và kết quả. Sau đó chờ tôi xác nhận trước khi triển khai bước tiếp theo.
