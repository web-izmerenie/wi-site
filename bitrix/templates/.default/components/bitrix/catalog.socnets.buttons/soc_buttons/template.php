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
$APPLICATION->AddHeadString('<script src="https://yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>');
$APPLICATION->AddHeadString('<script src="https://yastatic.net/share2/share.js"></script>');
?>
<div id="soc"></div>
<script>
	document.socInfo = <?=json_encode($arResult);?>
</script>
<script>
var share = Ya.share2('soc', {
	content: {
		title: document.socInfo.TITLE,
		description: document.socInfo.DESCRIPTION
	},
	theme: {
		services: 'facebook,gplus,vkontakte',
		counter: true,
		size: 'm'
	}
});
</script>
