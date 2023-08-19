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
        $sql = "SELECT * FROM orders WHERE order_id = $order_id";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $order = $result->fetch_assoc();
            echo json_encode($order);
        } else {
            echo json_encode(["error" => "Order not found"]);
        }
    } else {
        // Lấy tất cả các đơn hàng
        $sql = "SELECT * FROM orders";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $orders = [];
            while ($row = $result->fetch_assoc()) {
                $orders[] = $row;
            }
            echo json_encode($orders);
        } else {
            echo json_encode(["error" => "No orders found"]);
        }
    }
}

// Tạo đơn hàng mới
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $account_id = $_POST["account_id"];
    $order_date = $_POST["order_date"];
    $total_price = $_POST["total_price"];
    $status = $_POST["status"];

    $sql = "INSERT INTO orders (account_id, order_date, total_price, status) VALUES ('$account_id', '$order_date', '$total_price', '$status')";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => "Order created successfully"]);
    } else {
        echo json_encode(["error" => "Error creating order"]);
    }
}

// Cập nhật đơn hàng
if ($_SERVER["REQUEST_METHOD"] === "PUT") {
    parse_str(file_get_contents("php://input"), $putData);
    $order_id = $putData["order_id"];
    $account_id = $putData["account_id"];
    $order_date = $putData["order_date"];
    $total_price = $putData["total_price"];
    $status = $putData["status"];

    $sql = "UPDATE orders SET account_id='$account_id', order_date='$order_date', total_price='$total_price', status='$status' WHERE order_id=$order_id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => "Order updated successfully"]);
    } else {
        echo json_encode(["error" => "Error updating order"]);
    }
}

// Xóa đơn hàng
if ($_SERVER["REQUEST_METHOD"] === "DELETE") {
    parse_str(file_get_contents("php://input"), $deleteData);
    $order_id = $deleteData["order_id"];

    $sql = "DELETE FROM orders WHERE order_id=$order_id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["success" => "Order deleted successfully"]);
    } else {
        echo json_encode(["error" => "Error deleting order"]);
    }
}
?>