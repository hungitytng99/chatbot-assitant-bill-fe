# ihz_bql

## Run & Build
### Env:
 ```
 Flutter: >2.5.0
 ```
### Run app
Chạy script trước
 ```
 ./build_get_start.sh
 ```
Sửa trong ```Configrations``` để chạy app:
```
Dart entrypoint: => .../mains_stg.dart hoặc .../main_th.dart
```
### Build app
Xem các script:
- ./build_staging.sh
- ./build_th.sh

## Các common component

### lib/commons
- app_configs.dart => đưa hết những config cần thiếu cho app vào đây: url, ...
- app_color.dart => lấy màu cho app từ đây, cố gắng dùng màu theo tên và không tạo thêm các màu mới để dễ maintain sau này
- app_diment.dart => lấy kích thước padding từ đây
- app_text_styles.dart => dùng AppTextStyles.blackS14 thay vì phải khởi tạo TextStyle()
- app_images.dart và app_vector.dart => để lưu thông tin tên ảnh trong asset - đưa hết ảnh vào đây dễ maintain sau này

### lib/ui/commons
- app_dialog.dart: chứa toàn bộ dialog dùng trong app
- app_bottom_sheet.dart: show bottom sheet
- app_snackbar.dart: dùng chung để show thông báo hoặc lỗi (lỗi api, ...)

### other
- AppStatusDialog => dùng để hiển thị dialog cho app, có 3 loại: info, success, error

### Behaviour màn hình khi call API:
Có 5
- initial => trạng thái đầu tiên khi vào màn hình
- loading => trạng thái đang call api. Dùng code dưới để hiển thị:
```
//List
Center(  
  child: LoadingIndicatorWidget(),  
)
//Button
AppButton(
  ...
  isLoading: isLoading,  
)
```
- error => show AppSnackBar.error()
- success => show data
- loadingMore => xử lý trong trường hợp load list phân trang (ko cần update UI)

### Common UI
- app_cache_image.dart => dùng chung khi muốn show ảnh - dễ dàng maintain sau này
- app_circle_avatar.dart => dùng để show phần user avatar
- ...

