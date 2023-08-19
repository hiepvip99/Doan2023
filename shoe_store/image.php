<?php
// Kết nối đến cơ sở dữ liệu MySQL
$servername = "localhost";
$username = "your_username";
$password = "your_password";
$dbname = "your_database";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối đến cơ sở dữ liệu thất bại: " . $conn->connect_error);
}

// Hàm thêm đường dẫn ảnh vào cơ sở dữ liệu
function addImageToDatabase($conn, $imageUrl) {
    $sql = "INSERT INTO images (image_url) VALUES ('$imageUrl')";

    if ($conn->query($sql) === TRUE) {
        echo "Thêm đường dẫn ảnh vào cơ sở dữ liệu thành công.";
    } else {
        echo "Lỗi: " . $sql . "<br>" . $conn->error;
    }
}

// Hàm cập nhật đường dẫn ảnh trong cơ sở dữ liệu
function updateImageInDatabase($conn, $imageId, $imageUrl) {
    $sql = "UPDATE images SET image_url = '$imageUrl' WHERE image_id = $imageId";

    if ($conn->query($sql) === TRUE) {
        echo "Cập nhật đường dẫn ảnh thành công.";
    } else {
        echo "Lỗi: " . $sql . "<br>" . $conn->error;
    }
}

// Hàm xóa ảnh và đường dẫn ảnh trong cơ sở dữ liệu
function deleteImage($conn, $imageId, $imagePath) {
    $sql = "DELETE FROM images WHERE image_id = $imageId";

    if ($conn->query($sql) === TRUE) {
        if (unlink($imagePath)) {
            echo "Xóa ảnh và đường dẫn ảnh thành công.";
        } else {
            echo "Lỗi: Xóa ảnh thành công, nhưng không xóa được tệp tin ảnh.";
        }
    } else {
        echo "Lỗi: " . $sql . "<br>" . $conn->error;
    }
}

// Hàm lấy danh sách ảnh từ cơ sở dữ liệu
function getImagesFromDatabase($conn) {
    $sql = "SELECT * FROM images";
    $result = $conn->query($sql);
    $imageList = [];

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $imageList[] = $row["image_url"];
        }
    }

    return $imageList;
}

// Thực hiện chức năng thêm ảnh và lưu đường dẫn vào cơ sở dữ liệu
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    if (isset($_FILES["image"])) {
        $targetDir = "image/";
        $file = $_FILES["image"];
        $imageName = basename($file["name"]);

        // Di chuyển tệp tin ảnh đến thư mục đích
        $targetFile = $targetDir . $imageName;
        if (move_uploaded_file($file["tmp_name"], $targetFile)) {
            // Tạo đường dẫn ảnh tương ứng
            $imageUrl = generateImagePath($imageName);

            // Lưu đường dẫn ảnh vào cơ sở dữ liệu
            addImageToDatabase($conn, $imageUrl);
        } else {
            echo "Thêm ảnh thất bại.";
        }
    } else {
        echo "Không tìm thấy tệp tin ảnh được tải lên.";
    }
}

// Thực hiện chức năng cập nhật ảnh và đường dẫn ảnh trong cơ sở dữ liệu
if ($_SERVER["REQUEST_METHOD"] === "PUT") {
    parse_str(file_get_contents("php://input"), $putData);
    if (isset($_FILES["image"])) {
        $targetDir = "image/";
        $file = $_FILES["image"];
        $imageId = $putData["image_id"];
        $existingImagePath = $putData["existing_image_path"];
        $imageNameLần này, tôi sẽ chỉ cung cấp mã PHP để thực hiện chức năng thêm, sửa, xóa và lấy ảnh từ cơ sở dữ liệu MySQL. Bạn có thể kết hợp mã này với API của mình để thực hiện các hoạt động tương ứng.

```php
<?php
// Kết nối đến cơ sở dữ liệu MySQL
$servername = "localhost";
$username = "your_username";
$password = "your_password";
$dbname = "your_database";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối đến cơ sở dữ liệu thất bại: " . $conn->connect_error);
}

// Hàm thêm đường dẫn ảnh vào cơ sở dữ liệu
function addImageToDatabase($conn, $imageUrl) {
    $sql = "INSERT INTO images (image_url) VALUES ('$imageUrl')";

    if ($conn->query($sql) === TRUE) {
        echo "Thêm đường dẫn ảnh vào cơ sở dữ liệu thành công.";
    } else {
        echo "Lỗi: " . $sql . "<br>" . $conn->error;
    }
}

// Hàm cập nhật đường dẫn ảnh trong cơ sở dữ liệu
function updateImageInDatabase($conn, $imageId, $imageUrl) {
    $sql = "UPDATE images SET image_url = '$imageUrl' WHERE image_id = $imageId";

    if ($conn->query($sql) === TRUE) {
        echo "Cập nhật đường dẫn ảnh thành công.";
    } else {
        echo "Lỗi: " . $sql . "<br>" . $conn->error;
    }
}

// Hàm xóa ảnh và đường dẫn ảnh trong cơ sở dữ liệu
function deleteImageFromDatabase($conn, $imageId) {
    $sql = "DELETE FROM images WHERE image_id = $imageId";

    if ($conn->query($sql) === TRUE) {
        echo "Xóa ảnh và đường dẫn ảnh thành công.";
    } else {
        echo "Lỗi: " . $sql . "<br>" . $conn->error;
    }
}

// Hàm lấy đường dẫn ảnh từ cơ sở dữ liệu
function getImageFromDatabase($conn, $imageId) {
    $sql = "SELECT image_url FROM images WHERE image_id = $imageId";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row["image_url"];
    } else {
        return null;
    }
}

// Thực hiện chức năng thêm ảnh và lưu đường dẫn vào cơ sở dữ liệu
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    if (isset($_FILES["image"])) {
        $targetDir = "image/";
        $file = $_FILES["image"];
        $imageName = basename($file["name"]);

        // Di chuyển tệp tin ảnh đến thư mục đích
        $targetFile = $targetDir . $imageName;
        if (move_uploaded_file($file["tmp_name"], $targetFile)) {
            // Tạo đường dẫn ảnh tương ứng
            $imagePath = generateImagePath($imageName);

            // Lưu đường dẫn ảnh vào cơ sở dữ liệu
            addImageToDatabase($conn, $imagePath);
        } else {
            echo "Thêm ảnh thất bại.";
        }
    } else {
        echo "Không tìm thấy tệp tin ảnh được tải lên.";
    }
}

// Thực hiện chức năng cập nhật ảnh và đường dẫn ảnh trong cơ sở dữ liệu
if ($_SERVER["REQUEST_METHOD"] === "PUT") {
    parse_str(file_get_contents("php://input"), $putData);
    if (isset($_FILES["image"])) {
        $targetDir = "image/";
        $file = $_FILES["image"];
        $imageId = $putData["image_id"];
        $existingImagePath = $putData["existing_image_path"];
        $imageName = basename($file["name"]);

        //````