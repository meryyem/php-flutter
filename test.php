//<?php
//EXPLODE & IN_ARRAY--------------------------------------------------------------------------------------------------------------
  //explode : change string to array

  //$text = "maryem sakly" ;

  //explode fctn needs two parameters => separator + variable
 /* $strtoarray = explode(" ", $text) ;

  echo "<pre>" ;
  print_r($strtoarray) ;
  echo "</pre>" ;

  $img = "image.jpg" ;

  $strtoarray = explode(".", $img);

  echo $strtoarray[1] ;
  print_r("                   ");
  echo end($strtoarray);*/

  //in array => role : search in an array => return : boolean
  /*print_r("                   ");

  $fileName = "image.jpg" ;

  $strtoarray = explode(".", $fileName);

  $ext = end($strtoarray) ;

  $allowExt = array("jpg" , "png" , "gif");

  if (in_array($ext, $allowExt)) {
    echo "yes";
  } else {
    echo "no";
  }*/

//FILES--------------------------------------------------------------------------------------------------------------
  //$file = $_FILES['file'] ;
  //echo "<pre>" ;
  //print_r($_FILES['file']);
  //echo "</pre>" ;
//FUNCTION TO UPLOAD IMAGES => DYNAMIC TO USE IT WHEREVER I WANT--------------------------------------------------------------------------------------------------------------
//define constante by define
//define('MB', 1048576);


//this function's code must be in functions.php file
//function imageUpload($imageRequest) {
    //global $msgError;

    //$imagename = rand(1000, 10000) . $_FILES[$imageRequest]['name'];
    //$imagetmp = $_FILES[$imageRequest]['tmp_name'];
    //$imagesize = $_FILES[$imageRequest]['size'];
    //$allowExt = array("jpg" , "png" , "gif", "mp3", "pdf");
   // $strToArray = explode(".", $imagename);
    //$ext = end($strToArray) ;
    //$ext = strtolower($ext) ;
   // if (!empty($imagename) && !in_array($ext , $allowExt)) {
    //    $msgError[] = "Ext";
    //}
  //  if ($imagesize > 2 * MB) {
     //   $msgError[] = "SIZE";
  //  }
   // if(empty($msgError)) {
   //     move_uploaded_file($imagetmp, "../upload/" . $imagename);
    //    return $imagename;
   // } else {
   //     echo "<pre>" ; 
    //    print_r($msgError);
     //   echo "</pre>";
    //    return "fail";
   // }
    
  ///}
//how to use this function in my application
//include "connect.php";

//imageUpload("file");
//?>