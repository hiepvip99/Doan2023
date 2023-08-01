<?php
// Kết nối đến cơ sở dữ liệu
$servername = "localhost";
$username = "your_username";
$password = "your_password";
$dbname = "your_database";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}

// Xử lý khi người dùng gửi biểu mẫu đăng ký
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $password = $_POST["password"];

    // Kiểm tra xem tên người dùng đã tồn tại chưa
    $check_query = "SELECT * FROM users WHERE username='$username'";
    $result = $conn->query($check_query);
    if ($result->num_rows > 0) {
        echo "Tên người dùng đã tồn tại. Vui lòng chọn tên khác.";
    } else {
        // Thêm người dùng mới vào cơ sở dữ liệu
        $insert_query = "INSERT INTO users (username, password) VALUES ('$username', '$password')";
        if ($conn->query($insert_query) === TRUE) {
            echo "Đăng ký thành công!";
        } else {
            echo "Lỗi: " . $conn->error;
        }
    }
}

$conn->close();
?>
