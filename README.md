# I. Giới thiệu hệ thống
## 1. Bối cảnh
Trong mỗi dịp tết nguyên đán, ngày Quốc tế Phụ nữ 08/03, ngày Phụ nữ Việt Nam 20/10 là thời điểm thích hợp để chúng ta gửi đến người thân yêu thương những lời chúc tốt đẹp nhất. Viết những lời chúc ấy qua tin nhắn ta có thể gửi ngay lập tức. Nhưng mọi điều có thể trở lên tuyệt vời bằng các viết những lời chúc ấy nên một tấm thiệp online, gửi tặng người thân. Tấm thiệp ấy sẽ cho lời chúc thêm phần đẹp đẽ và ý nghĩa biết bao.

Khi đưa lời chúc vào tấm thiệp, thì vừa giúp tăng tính thẩm mỹ, vừa tăng giá trị tinh thần của lời chúc. Lời chúc càng ý nghĩa hơn khi nhận được thấy rằng bạn đã dành công sức để tạo ra tấm thiệp đẹp đẽ ấy.  

## 2. Nhu cầu của người dùng
- Tạo thiệp đẹp từ lời chúc
- Thao tác thiết kế thiệp nhanh chóng, tiện lợi
- Tạo ra thiệp tương tự từ thiệp cũ

## 3. Mục tiêu của hệ thống
Từ bối cảnh và nhu cầu người dùng, ta có mục tiêu của hệ thống để thỏa mãn như cầu người dùng như sau:
- Hệ thống với thao tác thiết kế đơn giản
- Hệ thống tự gợi ý được bố cục của background và lời chúc 
- Hệ thống có tính năng lưu trữ và xuất thiệp
- Hệ thống có tính năng tạo thiệp tương tự thiệp cũ

# II. Mô tả hệ thống
## 1. Công nghệ sử dụng
Frontend: HTML, CSS, JS
Backend: Ruby on Rails
Database: PostgreSQL

## 2. Các luồng chính của hệ thống:
**Luồng 1**: Người dùng xem danh sách lời chúc => Chọn lời chúc ưng ý rồi ấn tạo thiệp => Chuyển sang màn hình thiết kế thiệp => Lưu thiệp(thiệp có thể chia sẻ cho người khác)
Luồng này dành cho người dùng đang đi tìm kiếm những lời chúc tốt đẹp dành cho người thân có thể từ google, hoặc các trang tìm kiếm khác. Khi hiển thị danh sách lời chúc người dùng có thể chọn thêm việc tạo thiệp để giúp lời chúc của người ấy trở thành một tấm thiệp ngay lập tức, nhanh chóng thuận tiện.

**Luồng 2**: (Với người dùng có tài khoản) Vào danh sách thiệp đã tạo => Chọn tạo bản sao thiệp => Chuyển sang màn hình thiết kế thiệp => Lưu thiệp(thiệp có thể chia sẻ cho người khác)
Luồng này dành cho người dùng đã dùng hệ thống nhiều lần, đã có những thiệp được tạo. Người dùng muốn chỉnh sửa lại thiệp từ trước chỉ cần tạo bản sao và chỉnh sửa là có thể gửi cho người khác nhanh chóng, thuận tiện.

**Luồng 3**: Người dùng vào màn hình thiết kế thiệp => Lưu thiệp(thiệp có thể chia sẻ cho người khác)
Luồng này dành cho người dùng vào trực tiếp trang thiết kế để tiến hành thiết kế thiệp và gửi đến cho người thân, bạn bè.

**Luồng 4**: (Dành cho quản trị viên)Quản lý lời chúc, quản lý sự kiện, quản lý user
Lường này danh cho người quản trị viên, người quản trị viên có thể quản lý lời chúc, quản lý sự kiện, quản lý user một cách dễ dàng nhanh chóng.  

# III. Cấu trúc cơ sở dữ liệu 
## 1. Mô tả các bảng 
| STT |Tên bảng|Cột|Ý nghĩa của bảng|
|:---:|:--------------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------:|
|  1  | users| id, username, password, role, status, create_at, updated_at| Lưu thông tin người dùng đăng nhập vào hệ thống hoặc các người dùng admin|
|  2  | cards| id, is_public, status, user_id(khóa ngoại của users), order, created_at, updated_at| Lưu thông tin thiệp |
|  3  | layers_on_card | id, name, card_id(khóa ngoại của bản cards), order, layer_id(khóa ngoại của bảng images, texts,...), layer_type(giúp nhận diện lại layer là images hoặc texts hoặc…), order, status, user_id(khóa ngoại của users), created_at, updated_at | Lưu thông tin chung của layer của một thiệp(cards). 1 thiệp có thể có nhiều layer. |
|  4  | images         | id, name, url, order| Lưu thông tin của layer ảnh, là một loại layer |
|  5  | texts          | id, content, order, is_long, font, color, size, text_align, vertical, type_type| Lưu thông tin của layer text, là một loại layer                                    |
|  6  | events         | id, content, status, user_id(khóa ngoại của users), order, created_at, updated_at| Lưu thông tin các dịp lễ. Ví dụ: Ngày phụ nữ Việt Nam 20/10                        |
|  7  | categories     | id, event_id(khóa ngoại của events), content, order, status, user_id(khóa ngoại của users), created_at, updated_at | Lưu thông tin nhóm lời chúc trong sự kiện. Ví dụ: Nhóm lời chúc người yêu          |
|  8  | wishes         | id, category_id(khóa ngoại của categories), order, content, status, user_id(khóa ngoại của users), created_at, updated_at| Lưu thông tin lời chúc. Nhiều lời chúc cùng một nhóm(category)                     |
## 2. Ảnh các bảng và quan hệ trong database
![image database](./db/design/Made%20Card.png)
Link: https://dbdiagram.io/d/Made-Card-65fa9a35ae072629ce7b70e3
Database code: [Code database](./db/design/database.md)