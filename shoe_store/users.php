<?php

// Kết nối đến cơ sở dữ liệu
require_once 'config.php';

// Kết nối đến cơ sở dữ liệu
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Kết nối không thành công: " . $conn->connect_error);
}

// Lấy thông tin người dùng từ ID của bảng accounts và trả về dưới dạng JSON
function getUserInfo($accountID) {
  global $conn;
  
  $sql = "SELECT * FROM users WHERE account_id = ?";
  
  $stmt = $conn->prepare($sql);
  $stmt->bind_param('s', $accountID);
  $stmt->execute();
  
  $result = $stmt->get_result();
  $user = $result->fetch_assoc();
  
  // Chuyển đổi mảng kết quả thành chuỗi JSON
  $jsonUser = json_encode($user);
  
  return $jsonUser;
}

// Thêm người dùng mới và trả về kết quả thành công hoặc thất bại dưới dạng JSON
function addUser($username, $password, $email, $fullName, $phoneNumber, $address, $accountID) {
  global $conn;
  
  $sql = "INSERT INTO users (username, password, email, full_name, phone_number, address, account_id)
          VALUES (:username, :password, :email, :fullName, :phoneNumber, :address, :accountID)";
  
  $stmt = $conn->prepare($sql);
  $stmt->bindParam(':username', $username);
  $stmt->bindParam(':password', $password);
  $stmt->bindParam(':email', $email);
  $stmt->bindParam(':fullName', $fullName);
  $stmt->bindParam(':phoneNumber', $phoneNumber);
  $stmt->bindParam(':address', $address);
  $stmt->bindParam(':accountID', $accountID);
  
  if ($stmt->execute()) {
    $response = array('status' => 'success', 'message' => 'User added successfully');
  } else {
    $response = array('status' => 'error', 'message' => 'Failed to add user');
  }
  
  // Chuyển đổi mảng kết quả thành chuỗi JSON
  $jsonResponse = json_encode($response);
  
  return $jsonResponse;
}

// Sửa thông tin người dùng và trả về kết quả thành công hoặc thất bại dưới dạng JSON
function updateUser($userID, $username, $password, $email, $fullName, $phoneNumber, $address) {
  global $conn;
  
  $sql = "UPDATE users
          SET username = :username, password = :password, email = :email, full_name = :fullName,
              phone_number = :phoneNumber, address = :address
          WHERE user_id = :userID";
  
  $stmt = $conn->prepare($sql);
  $stmt->bindParam(':username', $username);
  $stmt->bindParam(':password', $password);
  $stmt->bindParam(':email', $email);
  $stmt->bindParam(':fullName', $fullName);
  $stmt->bindParam(':phoneNumber', $phoneNumber);
  $stmt->bindParam(':address', $address);
  $stmt->bindParam(':userID', $userID);
  
  if ($stmt->execute()) {
    $response = array('status' => 'success', 'message' => 'User updated successfully');
  } else {
    $response = array('status' => 'error', 'message' => 'Failed to update user');
  }
  
  // Chuyển đổi mảng kết quả thành chuỗi JSON
  $jsonResponse = json_encode($response);
  
  return $jsonResponse;
}

// Xóa người dùng và trả về kết quả thành công hoặc thất bại dưới dạng JSON
function deleteUser($userID) {
  global $conn;
  
  $sql = "DELETE FROM users WHERE user_id = :userID";
  
  $stmt = $conn->prepare($sql);
  $stmt->bindParam(':userID', $userID);
  
  if ($stmt->execute()) {
    $response = array('status' => 'success', 'message' => 'User deleted successfully');
  } else {
    $response = array('status' => 'error', 'message' => 'Failed to delete user');
  }
  
  // Chuyển đổi mảng kết quả thành chuỗi JSON
  $jsonResponse = json_encode($response);
  
  return $jsonResponse;
}

// Kiểm tra phương thức HTTP được sử dụng
$method = $_SERVER['REQUEST_METHOD'];

// Xử lý yêu cầu GET
if ($method == 'GET') {
  // Kiểm tra nếu yêu cầu lấy thông tin người dùng
  if (isset($_GET['accountID'])) {
    $accountID = $_GET['accountID'];
    $userInfo = getUserInfo($accountID);
    echo $userInfo;
  }
}

// Xử lý yêu cầu POST
if ($method == 'POST') {
  // Kiểm tra nếu yêu cầu thêm người dùng mới
  if (isset($_POST['username']) && isset($_POST['password']) && isset($_POST['email']) && isset($_POST['fullName']) && isset($_POST['phoneNumber']) && isset($_POST['address']) && isset($_POST['accountID'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $email = $_POST['email'];
    $fullName = $_POST['fullName'];
    $phoneNumber = $_POST['phoneNumber'];
    $address = $_POST['address'];
    $accountID = $_POST['accountID'];
    
    $addUserResult = addUser($username, $password, $email, $fullName, $phoneNumber, $address, $accountID);
    echo $addUserResult;
  }
  
  // Kiểm tra nếu yêu cầu sửa thông tin người dùng
  if (isset($_POST['userID']) && isset($_POST['username']) && isset($_POST['password']) && isset($_POST['email']) && isset($_POST['fullName']) && isset($_POST['phoneNumber']) && isset($_POST['address'])) {
    $userID = $_POST['userID'];
    $username = $_POST['username'];
    $password = $_POST['password'];
    $email = $_POST['email'];
    $fullName = $_POST['fullName'];
    $phoneNumber = $_POST['phoneNumber'];
    $address = $_POST['address'];
    
    $updateUserResult = updateUser($userID, $username, $password, $email, $fullName, $phoneNumber, $address);
    echo $updateUserResult;
  }
}

// Xử lý yêu cầu DELETE
if ($method == 'DELETE') {
  // Kiểm tra nếu yêu cầu xóa người dùng
  parse_str(file_get_contents("php://input"), $deleteParams);
  if (isset($deleteParams['userID'])) {
    $userID = $deleteParams['userID'];
    
    $deleteUserResult = deleteUser($userID);
    echo $deleteUserResult;
  }
}

?>