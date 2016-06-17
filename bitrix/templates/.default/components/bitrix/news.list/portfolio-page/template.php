<?if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)die();
/** @var array $arParams */
/** @var array $arResult */
/** @global CMain $APPLICATION */
/** @global CUser $USER */
/** @global CDatabase $DB */
/** @var CBitrixComponentTemplate $this */
/** @var string $templateName */
/** @var string $templateFile */
/** @var string $templateFolder */
/** @var string $componentPath */
/** @var CBitrixComponent $component */
$this->setFrameMode(true);

$items = array();
foreach($arResult['ITEMS'] as $arItem){
	$items[] = array(
		'NAME' => $arItem['NAME'],
		'PREVIEW_PICTURE' => array(
			'SRC' => $arItem['PREVIEW_PICTURE']['SRC'],
			'ALT' => $arItem['PREVIEW_PICTURE']['ALT']
		),
		'PREVIEW_TEXT' => $arItem['PREVIEW_TEXT'],
		'URL' => $arItem['PROPERTIES']['ATT_LINK']['VALUE']
	);
}
$result = array(
	'ITEMS' => $items,
	'NEXT_PAGE' => (($arResult['NAV_RESULT']->NavPageCount - $arResult['NAV_RESULT']->NavPageNomer)>0)?true:false
);

echo json_encode($result);