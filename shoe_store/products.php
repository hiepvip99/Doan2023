<?php
require_once 'config.php';

// Kết nối đến cơ sở dữ liệu
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}

// Kiểm tra nếu có truyền ID sản phẩm
if (isset($_GET["id"])) {
    $id = $_GET["id"];

    // Lấy thông tin của sản phẩm có ID tương ứng
    $product = getProductById($conn, $id);

    // Kiểm tra xem sản phẩm có tồn tại hay không
    if ($product) {
        // Trả về thông tin sản phẩm dưới dạng JSON
        header('Content-Type: application/json');
        echo json_encode($product);
    } else {
        echo "Không tìm thấy sản phẩm với ID $id";
    }
} else {
    // Lấy thông tin của tất cả sản phẩm
    $products = getAllProducts($conn);

    // Trả về thông tin của tất cả sản phẩm dưới dạng JSON
    header('Content-Type: application/json');
    echo json_encode($products);
}

// Hàm lấy thông tin của sản phẩm theo ID
function getProductById($conn, $id) {
    // Chuẩn bị truy vấn SQL
    $sql = "SELECT p.product_id, p.product_name, p.manufacturer_id, p.gender, pc.product_color_id, pc.color_id, pc.price, ps.product_size_id, ps.size_id, ps.quantity
            FROM products p
            LEFT JOIN product_colors pc ON p.product_id = pc.product_id
            LEFT JOIN product_sizes ps ON p.product_id = ps.product_id
            WHERE p.product_id = ?";

    // Chuẩn bị câu lệnh mysqli
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('i', $id);
    
    // Thực thi truy vấn
    $stmt->execute();
    
    // Lấy kết quả truy vấn
    $result = $stmt->get_result();
    // cập nhận sửa lỗi chat gpt
    $product = array();
while ($row = $result->fetch_assoc()) {
    $product['product_id'] = $row['product_id'];
    $product['product_name'] = $row['product_name'];
    $product['manufacturer_id'] = $row['manufacturer_id'];
    $product['gender'] = $row['gender'];

    // Thêm thông tin về màu sắc
    $color = array(
        'product_color_id' => $row['product_color_id'],
        'color_id' => $row['color_id'],
        'price' => $row['price']
    );
    if (!isset($product['product_colors'])) {
        $product['product_colors'] = array();
    }
    if (!in_array($color, $product['product_colors'])) {
        $product['product_colors'][] = $color;
    }

    // Thêm thông tin về kích thước
    $size = array(
        'product_size_id' => $row['product_size_id'],
        'size_id' => $row['size_id'],
        'quantity' => $row['quantity']
    );
    if (!isset($product['product_sizes'])) {
        $product['product_sizes'] = array();
    }
    if (!in_array($size, $product['product_sizes'])) {
        $product['product_sizes'][] = $size;
    }
}
    
    // Xử lý kết quả để tạo mảng thông tin sản phẩm
    // $product = array();
    // while ($row = $result->fetch_assoc()) {
    //     $product['product_id'] = $row['product_id'];
    //     $product['product_name'] = $row['product_name'];
    //     $product['manufacturer_id'] = $row['manufacturer_id'];
    //     $product['gender'] = $row['gender'];
        
    //     // Thêm thông tin về màu sắc
    //     if (!isset($product['product_colors'])) {
    //         $product['product_colors'] = array();
    //     }
    //     $color = array(
    //         'product_color_id' => $row['product_color_id'],
    //         'color_id' => $row['color_id'],
    //         'price' => $row['price']
    //     );
    //     $product['product_colors'][] = $color;
        
    //     // Thêm thông tin về kích thước
    //     if (!isset($product['product_sizes'])) {
    //         $product['product_sizes'] = array();
    //     }
    //     $size = array(
    //         'product_size_id' => $row['product_size_id'],
    //         'size_id' => $row['size_id'],
    //         'quantity' => $row['quantity']
    //     );
    //     $product['product_sizes'][] = $size;
    // }
    
    // Trả về thông tin sản phẩm
    return $product;
}

// // Hàm lấy thông tin của sản phẩm theo ID
// function getProductById($conn, $id) {
//     // Chuẩn bị truy vấn SQL
//     $sql = "SELECT p.product_id, p.product_name, p.manufacturer_id, p.gender, pc.product_color_id, pc.color_id, pc.price, ps.product_size_id, ps.size_id, ps.quantity
//             FROM products p
//             LEFT JOIN product_colors pc ON p.product_id = pc.product_id
//             LEFT JOIN product_sizes ps ON p.product_id = ps.product_id
//             WHERE p.product_id = :id";

//     // Chuẩn bị câu lệnh PDO
//     $stmt = $conn->prepare($sql);
//     $stmt->bindParam(':id', $id);
    
//     // Thực thi truy vấn
//     $stmt->execute();
    
//     // Lấy kết quả truy vấn
//     $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
//     // Xử lý kết quả để tạo mảng thông tin sản phẩm
//     $product = array();
//     foreach ($result as $row) {
//         $product['product_id'] = $row['product_id'];
//         $product['product_name'] = $row['product_name'];
//         $product['manufacturer_id'] = $row['manufacturer_id'];
//         $product['gender'] = $row['gender'];
        
//         // Thêm thông tin về màu sắc
//         if (!isset($product['product_colors'])) {
//             $product['product_colors'] = array();
//         }
//         $color = array(
//             'product_color_id' => $row['product_color_id'],
//             'color_id' => $row['color_id'],
//             'price' => $row['price']
//         );
//         $product['product_colors'][] = $color;
        
//         // Thêm thông tin về kích thước
//         if (!isset($product['product_sizes'])) {
//             $product['product_sizes'] = array();
//         }
//         $size = array(
//             'product_size_id' => $row['product_size_id'],
//             'size_id' => $row['size_id'],
//             'quantity' => $row['quantity']
//         );
//         $product['product_sizes'][] = $size;
//     }
    
//     // Trả về thông tin sản phẩm
//     return $product;
// }

// Hàm lấy thông tin của tất cả sản phẩm
function getAllProducts($conn) {
    // Chuẩn bị truy vấn SQL
    $sql = "SELECT p.product_id, p.product_name, p.manufacturer_id, p.gender, pc.product_color_id, pc.color_id, pc.price, ps.product_size_id, ps.size_id, ps.quantity
            FROM products p
            LEFT JOIN product_colors pc ON p.product_id = pc.product_id
            LEFT JOIN product_sizes ps ON p.product_id = ps.product_id";
    
    // Chuẩn bị câu lệnh PDO
    $stmt = $conn->prepare($sql);
    
    // Thực thi truy vấn
    $stmt->execute();
    
    // Lấy kết quả truy vấn
    $result = $stmt->get_result();
    
    // Xử lý kết quả để tạo mảng danh sách sản phẩm
    // $products = array();
    // foreach ($result as $row) {
    //     $productId = $row['product_id'];
    //     if (!isset($products[$productId])) {
    //         $products[$productId] = array(
    //             'product_id' => $row['product_id'],
    //             'product_name' => $row['product_name'],
    //             'manufacturer_id' => $row['manufacturer_id'],
    //             'gender' => $row['gender'],
    //             'product_colors' => array(),
    //             'product_sizes' => array()
    //         );
    //     }
        
    //     // Thêm thông tin về màu sắc
    //     $color = array(
    //         'product_color_id' => $row['product_color_id'],
    //         'color_id' => $row['color_id'],
    //         'price' => $row['price']
    //     );
    //     $products[$productId]['product_colors'][] = $color;
        
    //     // Thêm thông tin về kích thước
    //     $size = array(
    //         'product_size_id' => $row['product_size_id'],
    //         'size_id' => $row['size_id'],
    //         'quantity' => $row['quantity']
    //     );
    //     $products[$productId]['product_sizes'][] = $size;
    // }
    
    // // Trả về danh sách sản phẩm
    // return $products;

    /// Sửa lỗi
//     $products = array();
// foreach ($result as $row) {
//     $productId = $row['product_id'];
//     if (!isset($products[$productId])) {
//         $products[$productId] = array(
//             'product_id' => $row['product_id'],
//             'product_name' => $row['product_name'],
//             'manufacturer_id' => $row['manufacturer_id'],
//             'gender' => $row['gender'],
//             'product_colors' => array(),
//             'product_sizes' => array()
//         );
//     }

//     // Thêm thông tin về màu sắc
//     $color = array(
//         'product_color_id' => $row['product_color_id'],
//         'color_id' => $row['color_id'],
//         'price' => $row['price']
//     );
//     if (!in_array($color, $products[$productId]['product_colors'])) {
//         $products[$productId]['product_colors'][] = $color;
//     }

//     // Thêm thông tin về kích thước
//     $size = array(
//         'product_size_id' => $row['product_size_id'],
//         'size_id' => $row['size_id'],
//         'quantity' => $row['quantity']
//     );
//     if (!in_array($size, $products[$productId]['product_sizes'])) {
//         $products[$productId]['product_sizes'][] = $size;
//     }
// }

// // Trả về danh sách sản phẩm
// return $products;
$products = array();
foreach ($result as $row) {
    $productId = $row['product_id'];
    if (!isset($products[$productId])) {
        $products[$productId] = array(
            'product_id' => $row['product_id'],
            'product_name' => $row['product_name'],
            'manufacturer_id' => $row['manufacturer_id'],
            'gender' => $row['gender'],
            'product_colors' => array(),
            'product_sizes' => array()
        );
    }

    // Thêm thông tin về màu sắc
    $color = array(
        'product_color_id' => $row['product_color_id'],
        'color_id' => $row['color_id'],
        'price' => $row['price']
    );
    if (!in_array($color, $products[$productId]['product_colors'])) {
        $products[$productId]['product_colors'][] = $color;
    }

    // Thêm thông tin về kích thước
    $size = array(
        'product_size_id' => $row['product_size_id'],
        'size_id' => $row['size_id'],
        'quantity' => $row['quantity']
    );
    if (!in_array($size, $products[$productId]['product_sizes'])) {
        $products[$productId]['product_sizes'][] = $size;
    }
}

// Trả về danh sách sản phẩm
return array_values($products);
}

// if ($_SERVER["REQUEST_METHOD"] == "GET") {
//     if (isset($_GET["id"])) {
//         // Trả về thông tin của sản phẩm có id tương ứng
//         $id = $_GET["id"];
//         $sql = "SELECT p.*, pc.*, ps.*
//                 FROM products p
//                 JOIN product_colors pc ON p.product_id = pc.product_id
//                 JOIN product_sizes ps ON p.product_id = ps.product_id
//                 WHERE p.product_id = $id";
//         $result = $conn->query($sql);

//         if ($result->num_rows > 0) {
//             $rows = array();
//             while ($row = $result->fetch_assoc()) {
//                 $rows[] = $row;
//             }
//             echo json_encode($rows); // Chuyển đổi sang JSON
//         } else {
//             echo json_encode(["error" => "Không tìm thấy sản phẩm có id là $id"]); // Chuyển đổi sang JSON
//         }
//     } else {
//         // Trả về thông tin của tất cả các sản phẩm
//         $sql = "SELECT p.*, pc.*, ps.*
//                 FROM products p
//                 JOIN product_colors pc ON p.product_id = pc.product_id
//                 JOIN product_sizes ps ON p.product_id = ps.product_id";
//         $result = $conn->query($sql);

//         if ($result->num_rows > 0) {
//             $rows = array();
//             while ($row = $result->fetch_assoc()) {
//                 $rows[] = $row;
//             }
//             echo json_encode($rows); // Chuyển đổi sang JSON
//         } else {
//             echo json_encode(["error" => "Không tìm thấy bản ghi nào"]); // Chuyển đổi sang JSON
//         }
//     }
// }

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $data = json_decode(file_get_contents("php://input"), true);
    $action = $data["action"];
    if ($action == "add") {
        // Thêm mới thông tin sản phẩm
        $product_name = $data["product_name"];
        $manufacturer_id = $data["manufacturer_id"];
        $gender = $data["gender"];
        $color_id = $data["color_id"];
        $price = $data["price"];
        $size_id = $data["size_id"];
        $quantity = $data["quantity"];

        // Thực hiện câu truy vấn INSERT vào bảng products
        $sql = "INSERT INTO products (product_name, manufacturer_id, gender)
                VALUES ('$product_name', $manufacturer_id, '$gender')";
        $conn->query($sql);
        $product_id = $conn->insert_id;

        // Thực hiện câu truy vấn INSERT vào bảng product_colors
        $sql = "INSERT INTO product_colors (product_id, color_id, price)
                VALUES ($product_id, $color_id, $price)";
        $conn->query($sql);

        // Thực hiện câu truy vấn INSERT vào bảng product_sizes
        $sql = "INSERT INTO product_sizes (product_id, size_id, quantity)
                VALUES ($product_id, $size_id, $quantity)";
        $conn->query($sql);

        echo json_encode(["success" => "Thêm mới thành công"]);
    } elseif ($action == "update") {
        // Cập nhật thông tin sản phẩm
        $product_id = $data["product_id"];
        $product_name = $data["product_name"];
        $manufacturer_id = $data["manufacturer_id"];
        $gender = $data["gender"];
        $color_id = $data["color_id"];
        $price = $data["price"];
        $size_id = $data["size_id"];
        $quantity = $data["quantity"];

        // Thực hiện câu truy vấn UPDATE vào bảng products
        $sql = "UPDATE products SET
                product_name = '$product_name',
                manufacturer_id = $manufacturer_id,
                gender = '$gender'
                WHERE product_id = $product_id";
        $conn->query($sql);

        // Thực hiện câu truy vấn UPDATE vào bảng product_colors
        $sql = "UPDATE product_colors SET
                color_id = $color_id,
                price = $price
                WHERE product_id = $product_id";
        $conn->query($sql);

        // Thực hi
// Thực hiện câu truy vấn UPDATE vào bảng product_sizes
        $sql = "UPDATE product_sizes SET
                size_id = $size_id,
                quantity = $quantity
                WHERE product_id = $product_id";
        $conn->query($sql);

        echo json_encode(["success" => "Cập nhật thành công"]);
    } elseif ($action == "delete") {
        // Xóa thông tin sản phẩm
        $product_id = $data["product_id"];

        // Thực hiện câu truy vấn DELETE trên các bảng tương ứng
        $sql = "DELETE FROM products WHERE product_id = $product_id";
        $conn->query($sql);

        $sql = "DELETE FROM product_colors WHERE product_id = $product_id";
        $conn->query($sql);

        $sql = "DELETE FROM product_sizes WHERE product_id = $product_id";
        $conn->query($sql);

        echo json_encode(["success" => "Xóa thành công"]);
    }
}

$conn->close();
?>