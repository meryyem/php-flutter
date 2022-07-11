<?php

    include "../connect.php";

    $title = filterRequest("title");
    $content = filterRequest("content");
    $userid = filterRequest("id");

    $imagename = imageUpload("file");
    if($imagename != 'fail') {

        $stmt = $connect -> prepare("
        INSERT INTO `notes`(`notes_title`, `notes_content`, `notes_user`, `notes_image`) 
        VALUES (?, ?, ?, ?)
        ");
        
        $stmt -> execute(array($title, $content, $userid, $imagename));

        $data = $stmt -> fetch(PDO::FETCH_ASSOC);


        $count = $stmt ->rowCount();
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        }else {
            echo json_encode(array("status" => "fail"));
        }
    } else {
        echo json_encode(array("status" => "fail"));
    }
?>