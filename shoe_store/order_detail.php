<?php
// Kết nối đến cơ sở dữ liệu
require_once 'config.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}

// Thiết lập header cho JSON
header("Content-Type: application/json");

// Lấy tất cả các đơn hàng
if ($_SERVER["REQUEST_METHOD"] === "GET") {
    if (isset($_GET["id"])) {
        // Lấy thông tin của đơn hàng dựa trên ID
        $order_id = $_GET["id"];
        $sql = "SELECT * FROM order_items WHERE order_id = $order_id";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $order_items = [];
            while ($row = $result->fetch_assoc()) {
                $order_items[] = $row;
            }
            echo json_encode($order_items);
        } else {
            echo json_encode(["error" => "Order items not found"]);
        }
    } else {
        echo json_encode(["error" => "Missing ID parameter"]);
    }
}

// Tạo order item mới
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $order_id = $_POST["order_id"];
    $product_id = $_POST["product_id"];
    $color_id = $_POST["color_id"];
    $size_id = $_POST["size_id"];
    $quantity = $_POST["quantity"];

    $sql = "INSERT INTO order_items (order_id, product_id, color_id, size_id, quantity) VALUES ('$order_id', '$product_id', '$color_id', '$size_id', '$quantity')";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => "Order item created successfully"]);
    } else {
        echo json_encode(["error" => "Error creating order item"]);
    }
}

// Cập nhật order item
if ($_SERVER["REQUEST_METHOD"] === "PUT") {
    parse_str(file_get_contents("php://input"), $putData);
    $order_item_id = $putData["order_item_id"];
    $order_id = $putData["order_id"];
    $product_id = $putData["product_id"];
    $color_id = $putData["color_id"];
    $size_id = $putData["size_id"];
    $quantity = $putData["quantity"];

    $sql = "UPDATE order_items SET order_id='$order_id', product_id='$product_id', color_id='$color_id', size_id='$size_id', quantity='$quantity' WHERE order_item_id=$order_item_id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => "Order item updated successfully"]);
    } else {
        echo json_encode(["error" => "Error updating order item"]);
    }
}

// Xóa order_item
if ($_SERVER["REQUEST_METHOD"] === "DELETE") {
    parse_str(file_get_contents("php://input"), $deleteData);
    $order_item_id = $deleteData["order_item_id"];

    $sql = "DELETE FROM order_items WHERE order_item_id=$order_item_id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => "Order item deleted successfully"]);
    } else {
        echo json_encode(["error" => "Error deleting order item"]);
    }
}

// Đóng kết nối đến cơ sở dữ liệu
$conn->close();
?>