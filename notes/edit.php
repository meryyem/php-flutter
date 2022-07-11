<?php

    include "../connect.php";

    
    $title = filterRequest("title");
    $content = filterRequest("content");
    $imagename = filterRequest("imagename");
    $noteid = filterRequest("id");

    //to verify if i did change the image name
    if (isset($_FILES['file'])){
        
        deleteFile("../upload", $imagename);
        $imagename = imageUpload("file");
    }


    $stmt = $connect -> prepare("
        UPDATE `notes` SET 
        `notes_title`=?,
        `notes_content`= ?,
        notes_image= ?
        WHERE notes_id = ?
    ");

    $stmt -> execute(array($title, $content, $imagename, $noteid));


    $count = $stmt ->rowCount();
    if ($count > 0) {
        echo json_encode(array("status" => "success"));
    } else {
        echo json_encode(array("status" => "fail"));
    }
?>