<?
$arUrlRewrite = array(
	array(
		"CONDITION" => "#^/blog/(.+?).php(\\?|\$)#",
		"RULE" => "ELEMENT_CODE=\$1&",
		"ID" => "",
		"PATH" => "/blog/index.php",
	),
);

?>