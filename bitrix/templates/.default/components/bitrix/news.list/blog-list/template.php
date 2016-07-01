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
?>
<ul class="posts">
	<?foreach($arResult['ITEMS'] as $arItem){
		$img = CFile::ResizeImageGet(
			$arItem['PREVIEW_PICTURE'],
			array('width'=>680, 'height'=>427),
			BX_RESIZE_IMAGE_PROPORTIONAL, true);
		?>
		<li>
			<img alt="" src="<?=$img['src'];?>" class="picture">
			<time><?=$arItem['DISPLAY_ACTIVE_FROM'];?></time>
			<h3><a href="<?=$arItem['DETAIL_PAGE_URL'];?>"><?=$arItem['NAME'];?></a></h3>
			<div class="text">
				<?=$arItem['~PREVIEW_TEXT'];?>
			</div>
			<div class="tags">
				<h4>Теги:</h4>
				<ul>
					<?foreach($arItem['TAG_ARRAY'] as $arTag){?>
						<li>
							<a href="#"><?=$arTag;?></a>
						</li>
					<?}?>
				</ul>
			</div>
		</li>
	<?}?>
</ul>
