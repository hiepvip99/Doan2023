<?php
// Kết nối đến cơ sở dữ liệu
require_once 'config.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}

// Xử lý khi người dùng gửi biểu mẫu đăng nhập
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $password = $_POST["password"];

    // Kiểm tra xem tên người dùng và mật khẩu có khớp trong cơ sở dữ liệu hay không
    $check_query = "SELECT * FROM accounts WHERE username='$username' AND password='$password'";
    $result = $conn->query($check_query);

    if ($result->num_rows > 0) {
        // Lấy thông tin tài khoản và trả về kết quả đăng nhập thành công
        $row = $result->fetch_assoc();
        $response = array(
            "status" => "success",
            "message" => "Đăng nhập thành công!",
            "account_id" => $row["account_id"],
            "username" => $row["username"],
            "role" => $row["role"]
        );
    } else {
        // Trả về thông báo tài khoản không hợp lệ
        $response = array("status" => "error", "message" => "Tên người dùng hoặc mật khẩu không chính xác.");
    }

    // Trả về kết quả dưới dạng JSON
    header('Content-Type: application/json');
    echo json_encode($response);
}

$conn->close();
?>