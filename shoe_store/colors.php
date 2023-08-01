<?php
// Kết nối đến cơ sở dữ liệu
require_once 'config.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "GET") {
  if (isset($_GET["id"])) {
    // Lấy thông tin của màu sắc theo ID
    $id = $_GET["id"];
    $sql = "SELECT * FROM colors WHERE color_id = $id";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
      $row = $result->fetch_assoc();
      echo json_encode($row);
    } else {
      echo json_encode(["error" => "Không tìm thấy màu sắc có ID là $id"]);
    }
  } else {
    // Lấy danh sách tất cả các màu sắc
    $sql = "SELECT * FROM colors";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
      $rows = array();
      while ($row = $result->fetch_assoc()) {
        $rows[] = $row;
      }
      echo json_encode($rows);
    } else {
      echo json_encode(["error" => "Không tìm thấy bản ghi nào"]);
    }
  }
}

// Thêm một màu mới vào bảng `colors`
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $action = $_POST["action"];

  if ($action == "add") {
    $color_name = $_POST["color_name"];

    if (!empty($color_name)) {
      $sql = "INSERT INTO colors (color_name) VALUES ('$color_name')";

      if ($conn->query($sql) === TRUE) {
        echo "Thêm một màu mới thành công";
      } else {
        echo "Lỗi: " . $sql . "<br>" . $conn->error;
      }
    } else {
      echo "Thiếu thông tin tên màu";
    }
  }

  if ($action == "update") {
    $color_id = $_POST["color_id"];
    $color_name = $_POST["color_name"];

    if (!empty($color_id) && !empty($color_name)) {
      $sql = "UPDATE colors SET color_name = '$color_name' WHERE color_id = $color_id";

      if ($conn->query($sql) === TRUE) {
        echo "Cập nhật màu sắc thành công";
      } else {
        echo "Lỗi: " . $sql . "<br>" . $conn->error;
      }
    } else {
      echo "Thiếu thông tin tên màu hoặc ID màu";
    }
  }

  if ($action == "delete") {
    $color_id = $_POST["color_id"];

    if (!empty($color_id)) {
      $sql = "DELETE FROM colors WHERE color_id = $color_id";

      if ($conn->query($sql) === TRUE) {
        echo "Xóa màu sắc thành công";
      } else {
        echo "Lỗi: " . $sql . "<br>" . $conn->error;
      }
    } else {
      echo "Thiếu thông tin ID màu";
    }
  }
}

$conn->close();
?>