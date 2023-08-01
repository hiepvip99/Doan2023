<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "shoe_store";

// Tạo kết nối
$conn = new mysqli($servername, $username, $password, $dbname);

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}

// Truy vấn thông tin từ bảng "Manufacturers"
$sql = "SELECT * FROM Manufacturers";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "Thông tin nhà sản xuất:<br>";
    while ($row = $result->fetch_assoc()) {
        echo "ID: " . $row["manufacturer_id"] . ", Tên: " . $row["manufacturer_name"] . "<br>";
    }
} else {
    echo "Không có nhà sản xuất.";
}

echo "<br>";

// Truy vấn thông tin từ bảng "Products"
$sql = "SELECT * FROM Products";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "Thông tin sản phẩm:<br>";
    while ($row = $result->fetch_assoc()) {
        echo "ID: " . $row["product_id"] . ", Tên: " . $row["product_name"] . ", Nhà sản xuất ID: " . $row["manufacturer_id"] . ", Giới tính: " . $row["gender"] . "<br>";
    }
} else {
    echo "Không có sản phẩm.";
}

echo "<br>";

// Truy vấn thông tin từ bảng "Colors"
$sql = "SELECT * FROM Colors";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "Thông tin màu sắc:<br>";
    while ($row = $result->fetch_assoc()) {
        echo "ID: " . $row["color_id"] . ", Tên: " . $row["color_name"] . "<br>";
    }
} else {
    echo "Không có màu sắc.";
}

echo "<br>";

// Truy vấn thông tin từ bảng "Sizes"
$sql = "SELECT * FROM Sizes";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "Thông tin kích cỡ:<br>";
    while ($row = $result->fetch_assoc()) {
        echo "ID: " . $row["size_id"] . ", Tên: " . $row["size_name"] . "<br>";
    }
} else {
    echo "Không có kích cỡ.";
}

echo "<br>";

// Truy vấn thông tin từ bảng "Product_Colors"
$sql = "SELECT * FROM Product_Colors";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "Thông tin sản phẩm - màu sắc:<br>";
    while ($row = $result->fetch_assoc()) {
        echo "ID: " . $row["product_color_id"] . ", Sản phẩm ID: " . $row["product_id"] . ", Màu sắc ID: " . $row["color_id"] . ", Giá: " . $row["price"] . "<br>";
    }
} else {
    echo "Không có thông tin sản phẩm - màu sắc.";
}

echo "<br>";

// Truy vấn thông tin từ bảng "Product_Sizes"
$sql = "SELECT * FROM Product_Sizes";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "Thông tin sản phẩm - kích cỡ:<br>";
    while ($row = $result->fetch_assoc()) {
        echo "ID: " . $row["product_size_id"] . ", Sản phẩm ID: " . $row["product_id"] . ", Kích cỡ ID: " . $row["size_id"] . ", Số lượng: " . $row["quantity"] . "<br>";
    }
} else {
    echo "Không có thông tin sản phẩm - kích cỡ.";
}

// Đóng kết nối
$conn->close();
?>
