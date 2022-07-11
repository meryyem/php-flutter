<?php

    include "../connect.php";

    $userid = filterRequest("id");

    $stmt = $connect -> prepare("SELECT * FROM notes WHERE `notes_user` = ? ");

    $stmt -> execute(array($userid));
    //fetchAll to get all the data
    //here to get the data from the front i need a list that includes a map
    $data = $stmt -> fetchAll(PDO::FETCH_ASSOC);


    $count = $stmt ->rowCount();
    if ($count > 0) {
        echo json_encode(array("status" => "success", "data" => $data));
    }else {
        echo json_encode(array("status" => "fail"));
    }
?>