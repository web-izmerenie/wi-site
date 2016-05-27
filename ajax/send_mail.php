<?
$json_result = array();
$error = null;
$arrErorInput = array();

$bot = $_POST["q"];
unset($_POST["q"]);

$arData = $_POST;

if(!filter_var($arData['phonemail'], FILTER_VALIDATE_EMAIL) &&
!preg_match( '/^[+]?([\d]{0,3})?[\(\.\-\s]?([\d]{3})[\)\.\-\s]*([\d]{3})[\.\-\s]?([\d]{4})$/', $arData['phonemail'])){
	$error = "incorrect-fields";
}

foreach ($arData as $key => $data) {
	if(empty($data)){
		$error = "required-fields";
		$arrErorInput[] = $key;
	}
}

if(!empty($bot)){
	$error = "go-fuck-yourself-stupid-robot";
}

if($error == "required-fields"){
	header('Content-Type: application/json', true, 400);

	$json_result = array(
		"status" => "error",
		"fields" => $arrErorInput
	);
}else if($error == "go-fuck-yourself-stupid-robot"){
	header('Content-Type: application/json', true, 404);

	$json_result = array(
		"status" => "error"
	);
}else if($error == "incorrect-fields"){
	header('Content-Type: application/json', true, 406);

	$json_result = array(
		"status" => "error",
		"fields" => array("phonemail")
	);
}else{
	header('Content-Type: application/json', true);
	
	$json_result = array(
		"status" => "success"
	);
}

$json_result["error_code"] = $error;

print json_encode($json_result);
