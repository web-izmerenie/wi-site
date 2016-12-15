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
<section id="portfolio" class="portfolio">
  <div class="title-block">
    <h2>Работы</h2>
    <h3>Более 100 проектов за 7 лет работы</h3>
  </div>
  <ul>
    <?foreach($arResult['ITEMS'] as $arItem){?>
      <li>
        <img alt="<?=$arItem['PREVIEW_PICTURE']['ALT'];?>" src="<?=$arItem['PREVIEW_PICTURE']['SRC'];?>" class="bg">
        <div class="text">
          <h3><?=$arItem['NAME'];?></h3>
          <h4><?=$arItem['PREVIEW_TEXT'];?></h4>
        </div>
        <?if($arItem['PROPERTIES']['ATT_LINK']['VALUE']){?>
          <a href="<?=$arItem['PROPERTIES']['ATT_LINK']['VALUE'];?>" target="_blank">Перейти на сайт</a>
        <?}?>
      </li>
    <?}?>
  </ul>
	<?if(($arResult['NAV_RESULT']->NavPageCount - $arResult['NAV_RESULT']->NavPageNomer)>0){?>
  <div class="more-block">
    <a href="/#portfolio-more" data-page="1">
      <i class="a"></i>
      <i class="b"></i>
      <span class="title">Показать ещё</span>
    </a>
  </div>
	<?}?>
</section>
