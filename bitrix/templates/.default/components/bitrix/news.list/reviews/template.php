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
<section id="reviews" class="reviews">
  <div class="inside">
    <h2>
      <span>Каждый наш&nbsp;клиент уникален. Но&nbsp;все похожи в&nbsp;одном&nbsp;—&nbsp;в</span>
      <span>стремлении к&nbsp;выдающимся результатам</span>
    </h2>
    <ul class="reviews-list">
      <?foreach($arResult['ITEMS'] as $arItem){
        $img = CFile::ResizeImageGet(
          $arItem['PREVIEW_PICTURE'],
          array('width'=>165, 'height'=>100),
          BX_RESIZE_IMAGE_PROPORTIONAL,
          true);?>
        <li>
          <a href="#reviews-item-<?=$arItem['ID'];?>">
            <img alt="<?=$arItem['PREVIEW_PICTURE']['ALT'];?>" src="<?=$img['src'];?>">
          </a>
          <blockquote id="reviews-item-<?=$arItem['ID'];?>">
            <div class="inside">
              <div class="text"><?=$arItem['PREVIEW_TEXT'];?></div>
              <div class="signature">
                <p>
                  <strong><?=$arItem['PROPERTIES']['AUTHOR']['VALUE'];?></strong>
                  <em><?=$arItem['PROPERTIES']['POSITION']['VALUE'];?></em>
                </p>
              </div>
            </div>
          </blockquote>
        </li>
      <?}?>
    </ul>
  </div>
</section>
