<?php
if ($_FILES['file']['error'] == 0) {
    $uploadDir = __DIR__ . '/upload/';
    $uploadFile = $uploadDir . basename($_FILES['file']['name']);

    // 파일 업로드 (검증 없이)
    move_uploaded_file($_FILES['file']['tmp_name'], $uploadFile);

    echo "Uploaded: " . htmlspecialchars($uploadFile);
} else {
    echo "Upload error";
}
?>
