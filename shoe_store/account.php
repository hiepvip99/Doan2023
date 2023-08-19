<?php
// Kết nối đến cơ sở dữ liệu
require_once 'config.php';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}

// if ($_SERVER["REQUEST_METHOD"] == "GET") {
//     if (isset($_GET["id"])) {
//         // Lấy thông tin của tài khoản theo ID
//         $id = $_GET["id"];
//         $sql = "SELECT * FROM accounts WHERE account_id = $id";
//         $result = $conn->query($sql);

//         if ($result && $result->num_rows > 0) {
//             $row = $result->fetch_assoc();
//             echo json_encode($row);
//         } else {
//             echo json_encode(["error" => "Không tìm thấy tài khoản có ID là $id"]);
//         }
//     } else {
//         // Lấy danh sách tất cả các tài khoản
//         $sql = "SELECT * FROM accounts";
//         $result = $conn->query($sql);

//         if ($result && $result->num_rows > 0) {
//             $rows = array();
//             while ($row = $result->fetch_assoc()) {
//                 $rows[] = $row;
//             }
//             echo json_encode($rows);
//         } else {
//             echo json_encode(["error" => "Không tìm thấy bản ghi nào"]);
//         }
//     }
// }

if ($_SERVER["REQUEST_METHOD"] == "GET") {
    if (isset($_GET["account_id"])) {
        $account_id = $_GET["account_id"];
        $sql = "SELECT * FROM accounts LEFT JOIN users ON accounts.account_id = users.account_id WHERE accounts.account_id = $account_id";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $user_id = $row['user_id'];
            $email = $row['email'];
            $full_name = $row['full_name'];
            $phone_number = $row['phone_number'];
            $address = $row['address'];

            $info_user = array(
                "user_id" => $user_id,
                "email" => $email,
                "full_name" => $full_name,
                "phone_number" => $phone_number,
                "address" => $address,
                "account_id" => $account_id
            );

            $response = array(
                "account_id" => $account_id,
                "username" => $row['username'],
                "password" => $row['password'],
                "role" => $row['role'],
                "info_user" => $info_user
            );

            echo json_encode($response);
        } else {
            echo json_encode(["error" => "Không tìm thấy thông tin tài khoản với account_id là $account_id"]);
        }
    } else {
        // Lấy danh sách tất cả các tài khoản và thông tin người dùng
        $sql = "SELECT * FROM accounts LEFT JOIN users ON accounts.account_id = users.account_id";
        $result = $conn->query($sql);

        if ($result && $result->num_rows > 0) {
            $rows = array();
            while ($row = $result->fetch_assoc()) {
                $account_id = $row['account_id'];
                $user_id = $row['user_id'];
                $email = $row['email'];
                $full_name = $row['full_name'];
                $phone_number = $row['phone_number'];
                $address = $row['address'];

                $info_user = array(
                    "user_id" => $user_id,
                    "email" => $email,
                    "full_name" => $full_name,
                    "phone_number" => $phone_number,
                    "address" => $address,
                    "account_id" => $account_id
                );

                $response = array(
                    "account_id" => $account_id,
                    "username" => $row['username'],
                    "password" => $row['password'],
                    "role" => $row['role'],
                    "info_user" => $info_user
                );

                $rows[] = $response;
            }
            echo json_encode($rows);
        } else {
            echo json_encode(["error" => "Không tìm thấy bản ghi nào"]);
        }
    }
}

// Cập nhật tài khoản trong bảng `account`
// if ($_SERVER["REQUEST_METHOD"] == "POST") {
//     $data = json_decode(file_get_contents('php://input'), true);
//     $action = $data["action"];

//     if ($action == "add") {
//         $username = $data["username"];
//         $password = $data["password"];

//         if (!empty($username) && !empty($password)) {
//             $sql = "INSERT INTO accounts (username, password) VALUES ('$username', '$password')";

//             if ($conn->query($sql) === TRUE) {
//                 echo "Thêm tài khoản thành công";
//             } else {
//                 echo "Lỗi: " . $sql . "<br>" . $conn->error;
//             }
//         } else {
//             echo "Thiếu thông tin tên đăng nhập hoặc mật khẩu";
//         }
//     }

//     if ($action == "update") {
//         $account_id = $data["account_id"];
//         $username = $data["username"];
//         $password = $data["password"];

//         if (!empty($account_id) && !empty($username) && !empty($password)) {
//             $sql = "UPDATE accounts SET username = '$username', password = '$password' WHERE account_id = $account_id";

//             if ($conn->query($sql) === TRUE) {
//                 echo "Cập nhật tài khoản thành công";
//             } else {
//                 echo "Lỗi: " . $sql . "<br>" . $conn->error;
//             }
//         } else {
//             echo "Thiếu thông tin tên đăng nhập, mật khẩu hoặc ID tài khoản";
//         }
//     }

//     if ($action == "delete") {
//         $account_id = $data["account_id"];

//         if (!empty($account_id)) {
//             $sql = "DELETE FROM accounts WHERE account_id = $account_id";

//             if ($conn->query($sql) === TRUE) {
//                 echo "Xóa tài khoản thành công";
//             } else {
//                 echo "Lỗi: " . $sql . "<br>" . $conn->error;
//             }
//         } else {
//             echo "Thiếu thông tin ID tài khoản";
//         }
//     }
// }

// if ($_SERVER["REQUEST_METHOD"] == "POST") {
//     $data = json_decode(file_get_contents('php://input'), true);
//     $action = $data["action"];

//     if ($action == "add") {
//         $username = $data["username"];
//         $password = $data["password"];

//         if (!empty($username) && !empty($password)) {
//             $sql = "INSERT INTO accounts (username, password) VALUES ('$username', '$password')";

//             if ($conn->query($sql) === TRUE) {
//                 echo "Thêm tài khoản thành công";
//             } else {
//                 echo "Lỗi: " . $sql . "<br>" . $conn->error;
//             }
//         } else {
//             echo "Thiếu thông tin tên đăng nhập hoặc mật khẩu";
//         }
//     }
// }

// if ($_SERVER["REQUEST_METHOD"] == "PUT") {
//     $data = json_decode(file_get_contents('php://input'), true);
//     $action = $data["action"];

//     if ($action == "update") {
//         $account_id = $data["account_id"];
//         $username = $data["username"];
//         $password = $data["password"];

//         if (!empty($account_id) && !empty($username) && !empty($password)) {
//             $sql = "UPDATE accounts SET username = '$username', password = '$password' WHERE account_id = $account_id";

//             if ($conn->query($sql) === TRUE) {
//                 echo "Cập nhật tài khoản thành công";
//             } else {
//                 echo "Lỗi: " . $sql . "<br>" . $conn->error;
//             }
//         } else {
//             echo "Thiếu thông tin tên đăng nhập, mật khẩu hoặc ID tài khoản";
//         }
//     }
// }

// if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
//     $data = json_decode(file_get_contents('php://input'), true);
//     $action = $data["action"];

//     if ($action == "delete") {
//         $account_id = $data["account_id"];

//         if (!empty($account_id)) {
//             $sql = "DELETE FROM accounts WHERE account_id = $account_id";

//             if ($conn->query($sql) === TRUE) {
//                 echo "Xóa tài khoản thành công";
//             } else {
//                 echo "Lỗi: " . $sql . "<br>" . $conn->error;
//             }
//         } else {
//             echo "Thiếu thông tin ID tài khoản";
//         }
//     }
// }

// // Kiểm tra phương thức gửi request
// if ($_SERVER["REQUEST_METHOD"] == "POST") {
//     // Kiểm tra xem có dữ liệu gửi lên không
//     if (!empty($_POST["username"]) && !empty($_POST["password"]) && isset($_POST["role"])) {
//         // Lấy dữ liệu gửi lên
//         $username = $_POST["username"];
//         $password = $_POST["password"];
//         $role = $_POST["role"];

//         // Kiểm tra trùng lặp username
//         $checkQuery = "SELECT * FROM accounts WHERE username = ?";
//         $checkStmt = $conn->prepare($checkQuery);
//         $checkStmt->bind_param("s", $username);
//         $checkStmt->execute();
//         $checkResult = $checkStmt->get_result();

//         if ($checkResult->num_rows > 0) {
//             $response = array("error" => "Username đã tồn tại");
//         } else {
//             // Tạo câu truy vấn INSERT
//             $insertQuery = "INSERT INTO accounts (username, password, role) VALUES (?, ?, ?)";
//             $insertStmt = $conn->prepare($insertQuery);
//             $insertStmt->bind_param("sss", $username, $password, $role);

//             if ($insertStmt->execute()) {
//                 $response = array("message" => "Thêm mới thành công");
//             } else {
//                 $response = array("error" => "Lỗi khi thêm mới: " . $insertStmt->error);
//             }

//             $insertStmt->close();
//         }

//         $checkStmt->close();
//     } else {
//         $response = array("error" => "Thiếu thông tin");
//     }
// } else {
//     $response = array("error" => "Phương thức không được hỗ trợ");
// }


// // Trả về kết quả dưới dạng JSON
// header('Content-Type: application/json');
// echo json_encode($response);

// // Kiểm tra phương thức gửi request
// if ($_SERVER["REQUEST_METHOD"] == "POST") {
//     // Kiểm tra xem có dữ liệu gửi lên không
//     if (!empty($_POST["account_id"]) && !empty($_POST["password"]) && isset($_POST["role"])) {
//         // Lấy dữ liệu gửi lên
//         $account_id = $_POST["account_id"];
//         $password = $_POST["password"];
//         $role = $_POST["role"];

//         // Kiểm tra xem account_id tồn tại trong cơ sở dữ liệu hay không
//         $checkQuery = "SELECT * FROM accounts WHERE account_id = ?";
//         $checkStmt = $conn->prepare($checkQuery);
//         $checkStmt->bind_param("i", $account_id);
//         $checkStmt->execute();
//         $checkResult = $checkStmt->get_result();

//         if ($checkResult->num_rows > 0) {
//             // Account tồn tại, thực hiện câu truy vấn UPDATE để sửa thông tin
//             $updateQuery = "UPDATE accounts SET password = ?, role = ? WHERE account_id = ?";
//             $updateStmt = $conn->prepare($updateQuery);
//             $updateStmt->bind_param("ssi", $password, $role, $account_id);

//             if ($updateStmt->execute()) {
//                 $response = array("message" => "Sửa thông tin thành công");
//             } else {
//                 $response = array("error" => "Lỗi khi sửa thông tin: " . $updateStmt->error);
//             }

//             $updateStmt->close();
//         } else {
//             $response = array("error" => "Account không tồn tại");
//         }

//         $checkStmt->close();
//     } else {
//         $response = array("error" => "Thiếu thông tin");
//     }
// } else {
//     $response = array("error" => "Phương thức không được hỗ trợ");
// }

// // Trả về kết quả dưới dạng JSON
// header('Content-Type: application/json');
// echo json_encode($response);

// Kiểm tra phương thức gửi request
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Kiểm tra xem có dữ liệu gửi lên không
    if (!empty($_POST["password"]) && isset($_POST["role"])) {
        $password = $_POST["password"];
        $role = $_POST["role"];

        // Kiểm tra xem có account_id được gửi lên hay không
        if (!empty($_POST["account_id"])) {
            $account_id = $_POST["account_id"];

            // Kiểm tra trùng lặp account_id
            $checkQuery = "SELECT * FROM accounts WHERE account_id = ?";
            $checkStmt = $conn->prepare($checkQuery);
            $checkStmt->bind_param("i", $account_id);
            $checkStmt->execute();
            $checkResult = $checkStmt->get_result();

            if ($checkResult->num_rows > 0) {
                // Account tồn tại, thực hiện câu truy vấn UPDATE để cập nhật thông tin
                $updateQuery = "UPDATE accounts SET password = ?, role = ? WHERE account_id = ?";
                $updateStmt = $conn->prepare($updateQuery);
                $updateStmt->bind_param("ssi", $password, $role, $account_id);

                if ($updateStmt->execute()) {
                    $response = array("message" => "Cập nhật thành công");
                } else {
                    $response = array("error" => "Lỗi khi cập nhật: " . $updateStmt->error);
                }

                $updateStmt->close();
            } else {
                $response = array("error" => "Account không tồn tại");
            }

            $checkStmt->close();
        } else {
            // Tạo mới account với dữ liệu gửi lên
            $username = $_POST["username"];

            // Kiểm tra trùng lặp username
            $checkQuery = "SELECT * FROM accounts WHERE username = ?";
            $checkStmt = $conn->prepare($checkQuery);
            $checkStmt->bind_param("s", $username);
            $checkStmt->execute();
            $checkResult = $checkStmt->get_result();

            if ($checkResult->num_rows > 0) {
                $response = array("error" => "Username đã tồn tại");
            } else {
                // Tạo câu truy vấn INSERT
                $insertQuery = "INSERT INTO accounts (username, password, role) VALUES (?, ?, ?)";
                $insertStmt = $conn->prepare($insertQuery);
                $insertStmt->bind_param("sss", $username, $password, $role);

                if ($insertStmt->execute()) {
                    $response = array("message" => "Thêm mới thành công");
                } else {
                    $response = array("error" => "Lỗi khi thêm mới: " . $insertStmt->error);
                }

                $insertStmt->close();
            }

            $checkStmt->close();
        }
    } else {
        $response = array("error" => "Thiếu thông tin");
    }
} else {
    $response = array("error" => "Phương thức không được hỗ trợ");
}

// Trả về kết quả dưới dạng JSON
header('Content-Type: application/json');
echo json_encode($response);

// if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
//     if (isset($_DELETE["account_id"])) {
//         $account_id = $_DELETE["account_id"];

//         // Kiểm tra xem $account_id có hợp lệ không
//         if (!empty($account_id)) {
//             $sql = "DELETE FROM accounts WHERE account_id = ?";

//             $stmt = $conn->prepare($sql);
//             $stmt->bind_param("i", $account_id);

//             if ($stmt->execute()) {
//                 $response = array("message" => "Xóa thành công");
//             } else {
//                 $response = array("error" => "Lỗi khi xóa: " . $stmt->error);
//             }

//             $stmt->close();
//             $conn->close();

//             // Trả về kết quả dưới dạng JSON
//             header('Content-Type: application/json');
//             echo json_encode($response);
//         } else {
//             $response = array("error" => "Thiếu thông tin ID tài khoản");
//             header('Content-Type: application/json');
//             echo json_encode($response);
//         }
//     } else {
//         $response = array("error" => "Thiếu thông tin ID tài khoản");
//         header('Content-Type: application/json');
//         echo json_encode($response);
//     }
// }

$conn->close();
?>