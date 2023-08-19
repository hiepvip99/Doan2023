<?php

// Kết nối đến cơ sở dữ liệu
require_once '../config.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Lấy dữ liệu từ body của yêu cầu POST
    $data = json_decode(file_get_contents('php://input'), true);

    // Kiểm tra xem dữ liệu có đầy đủ không
    if (isset($data["account_id"])) {
        $account_id = $data["account_id"];

        // Kiểm tra xem $account_id có hợp lệ không
        if (!empty($account_id)) {

            // Chuẩn bị câu truy vấn SQL để xóa tài khoản
            $sql = "DELETE FROM accounts WHERE account_id = ?";

            // Sử dụng câu truy vấn chuẩn bị để tránh tấn công SQL injection
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("i", $account_id);

            // Thực hiện câu truy vấn
            if ($stmt->execute()) {
                $response = array("message" => "Xóa thành công");
            } else {
                $response = array("error" => "Lỗi khi xóa: " . $stmt->error);
            }

            // Đóng kết nối và giải phóng tài nguyên
            $stmt->close();

            // Trả về kết quả dưới dạng JSON
            header('Content-Type: application/json');
            echo json_encode($response);
        } else {
            $response = array("error" => "Thiếu thông tin ID tài khoản");
            header('Content-Type: application/json');
            echo json_encode($response);
        }
    } else {
        $response = array("error" => "Thiếu thông tin ID tài khoản");
        header('Content-Type: application/json');
        echo json_encode($response);
    }
}

$conn->close();

?>