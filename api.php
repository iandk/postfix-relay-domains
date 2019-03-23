<?php
if (!isset($_GET["key"])) {
    exit("Error, no authentification!");
}
elseif ($_GET["key"] !== "123456") {
    exit("Error, invalid authentification!");
}
else {
    $pdo = new PDO('mysql:host=localhost;dbname=keyhelp', 'mysqladmin', '123123123123');
    $statement = $pdo->prepare("SELECT domain FROM domains WHERE is_emaildomain = 1");
    $statement->execute(array());  
    $domains=""; 
    while($row = $statement->fetch()) {
        $domains .= $row['domain'] . ", ";
    }
    echo substr_replace($domains ,"",-2);
}
?>
