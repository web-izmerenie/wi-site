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
$img = CFile::ResizeImageGet(
	$arResult['DETAIL_PICTURE'],
	array('width'=>680, 'height'=>440),
	BX_RESIZE_IMAGE_PROPORTIONAL,
	true);
$soc_desc = strip_tags(preg_replace("/&#?[a-z0-9]+;/i","",$arResult['PREVIEW_TEXT']));
$GLOBALS['ID_POST'] = $arResult['ID'];
?>
<main class="detail-content">
	<div class="title-block">
		<time><?=$arResult['DISPLAY_ACTIVE_FROM'];?></time>
		<h1><?=$arResult['NAME'];?></h1>
		<div class="text"><?=$arResult['~PREVIEW_TEXT'];?></div>
	</div>
	<figure class="picture">
		<!-- todo wrap with text-->
		<p><img alt="" src="<?=$img['src'];?>"></p>
		<figcaption>У картинок могут быть названия или пояснения</figcaption>
	</figure>
	<div class="text"><?=$arResult['~DETAIL_TEXT'];?></div>
	<div class="signature">
		<!-- <p>Умничал: <a href="mailto:someone@somewhere">Михаил Дзамукоф</a>
		</p> -->
	</div>
</main>
<div class="separate-line">
	<a href="/blog/" class="back-link"><span>К списку публикаций</span></a>
	<?$APPLICATION->IncludeComponent(
		"bitrix:catalog.socnets.buttons",
		"soc_buttons",
		array(
			"FB_USE" => "Y",
			"VK_USE" => "Y",
			"GP_USE" => "Y",
			"DESCRIPTION" => $soc_desc,
			"IMAGE" => $img['src'],
			"TITLE" => $arResult['NAME'],
			"URL_TO_LIKE" => $arResult['DETAIL_PAGE_URL'],
			"TW_HASHTAGS" => "",
			"TW_RELATED" => "",
			"TW_USE" => "N",
			"TW_VIA" => "",
			"COMPONENT_TEMPLATE" => "soc_buttons"
		),
		false
	);?>
</div>
