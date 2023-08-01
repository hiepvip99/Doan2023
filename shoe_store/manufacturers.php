<?php
// Kết nối đến cơ sở dữ liệu
require_once 'config.php';
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    if (isset($_GET["id"])) {
        // Trả về thông tin của nhà sản xuất có id tương ứng
        $id = $_GET["id"];
        $sql = "SELECT * FROM manufacturers WHERE manufacturer_id = $id";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            echo json_encode($row); // Chuyển đổi sang JSON
        } else {
            echo json_encode(["error" => "Không tìm thấy nhà sản xuất có id là $id"]); // Chuyển đổi sang JSON
        }
    } else {
        // Trả về thông tin của tất cả các nhà sản xuất
        $sql = "SELECT * FROM manufacturers";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $rows = array();
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
            echo json_encode($rows); // Chuyển đổi sang JSON
        } else {
            echo json_encode(["error" => "Không tìm thấy bản ghi nào"]); // Chuyển đổi sang JSON
        }
    }
}
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $action = $_POST["action"];
    if ($action == "add") {
        // Thêm mới thông tin của một nhà sản xuất
        if (isset($_POST["name"])) {
            $name = $_POST["name"];
            $sql = "INSERT INTO manufacturers (manufacturer_name) VALUES ('$name')";
            if ($conn->query($sql) === TRUE) {
                echo json_encode(["success" => "Thêm mới thành công"]);
            } else {
                echo json_encode(["error" => "Lỗi: " . $conn->error]);
            }
        } else {
            echo json_encode(["error" => "Thiếu thông tin tên nhà sản xuất"]);
        }
    } else if ($action == "update") {
        // Cập nhật thông tin của một nhà sản xuất
        if (isset($_POST["id"]) && isset($_POST["name"])) {
            $id = $_POST["id"];
            $name = $_POST["name"];
            $sql = "UPDATE manufacturers SET manufacturer_name = '$name' WHERE manufacturer_id = $id";
            if ($conn->query($sql) === TRUE) {
                echo json_encode(["success" => "Cập nhật thành công"]);
            } else {
                echo json_encode(["error" => "Lỗi: " . $conn->error]);
            }
        } else {
            echo json_encode(["error" => "Thiếu thông tin id hoặc tên nhà sản xuất"]);
        }
    }
}
if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
    // Xóa thông tin của một nhà sản xuất
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data["id"];
    $sql = "DELETE FROM manufacturers WHERE manufacturer_id = $id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => "Xóa thành công"]); // Chuyển đổi sang JSON
    } else {
        echo json_encode(["error" => "Lỗi: " . $conn->error]); // Chuyển đổi sang JSON
    }
}
$conn->close();
?>