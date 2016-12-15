<?
define("BLOG", "Y");
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/header.php");
$APPLICATION->SetTitle("Блог");
if($_REQUEST["ELEMENT_CODE"]){
	$sectionClass = "blog-detail";
}else{
	$sectionClass = "blog-list";
}
?>
<section class="blog <?=$sectionClass;?>">
	<div class="top-line">
		<?if($_REQUEST["ELEMENT_CODE"]){?>
			<span class="valign-helper"></span>
			<a href="/blog/" class="back-link">
				<span>К списку публикаций</span>
			</a>
		<?}?>
		<!-- <form class="search-form">
			<label class="text">
				<input type="text" name="q" value=""><span>Поиск по блогу</span>
			</label>
			<label class="submit">
				<input type="submit" value="Поиск">
			</label>
		</form> -->
		<hr>
	</div>
	<div class="content-zone">
		<div class="col col-right">
			<!-- <div class="tags">
				<h3>Теги:</h3>
				<ul>
					<li class="special"><a href="#">все</a></li>
					<li><a href="#">IT</a></li>
					<li><a href="#">вакансии</a></li>
					<li><a href="#">проекты</a></li>
					<li><a href="#">акции</a></li>
					<li><a href="#">студия</a></li>
					<li><a href="#">партнёры</a></li>
					<li><a href="#">статьи</a></li>
				</ul>
			</div> -->
			<div class="fb-widget">
				<iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2Fwebizmerenie%2F&tabs=timeline&width=273&height=566&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId" width="273" height="566" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
			</div>
		</div>
		<div class="col col-left">
			<?if($_REQUEST["ELEMENT_CODE"]){?>
				<?$APPLICATION->IncludeComponent("bitrix:news.detail", "blog-detail", Array(
					"ACTIVE_DATE_FORMAT" => "j F Y",	// Формат показа даты
						"ADD_ELEMENT_CHAIN" => "N",	// Включать название элемента в цепочку навигации
						"ADD_SECTIONS_CHAIN" => "N",	// Включать раздел в цепочку навигации
						"AJAX_MODE" => "N",	// Включить режим AJAX
						"AJAX_OPTION_ADDITIONAL" => "",	// Дополнительный идентификатор
						"AJAX_OPTION_HISTORY" => "N",	// Включить эмуляцию навигации браузера
						"AJAX_OPTION_JUMP" => "N",	// Включить прокрутку к началу компонента
						"AJAX_OPTION_STYLE" => "Y",	// Включить подгрузку стилей
						"BROWSER_TITLE" => "NAME",	// Установить заголовок окна браузера из свойства
						"CACHE_GROUPS" => "Y",	// Учитывать права доступа
						"CACHE_TIME" => "36000000",	// Время кеширования (сек.)
						"CACHE_TYPE" => "A",	// Тип кеширования
						"CHECK_DATES" => "Y",	// Показывать только активные на данный момент элементы
						"DETAIL_URL" => "",	// URL страницы детального просмотра (по умолчанию - из настроек инфоблока)
						"DISPLAY_BOTTOM_PAGER" => "N",	// Выводить под списком
						"DISPLAY_DATE" => "Y",	// Выводить дату элемента
						"DISPLAY_NAME" => "Y",	// Выводить название элемента
						"DISPLAY_PICTURE" => "Y",	// Выводить детальное изображение
						"DISPLAY_PREVIEW_TEXT" => "Y",	// Выводить текст анонса
						"DISPLAY_TOP_PAGER" => "N",	// Выводить над списком
						"ELEMENT_CODE" => $_REQUEST["ELEMENT_CODE"],	// Код новости
						"ELEMENT_ID" => $_REQUEST["ELEMENT_ID"],	// ID новости
						"FIELD_CODE" => array(	// Поля
							0 => "TAGS",
							1 => "CREATED_USER_NAME",
							2 => "",
						),
						"IBLOCK_ID" => "4",	// Код информационного блока
						"IBLOCK_TYPE" => "blog",	// Тип информационного блока (используется только для проверки)
						"IBLOCK_URL" => "",	// URL страницы просмотра списка элементов (по умолчанию - из настроек инфоблока)
						"INCLUDE_IBLOCK_INTO_CHAIN" => "N",	// Включать инфоблок в цепочку навигации
						"MESSAGE_404" => "",	// Сообщение для показа (по умолчанию из компонента)
						"META_DESCRIPTION" => "-",	// Установить описание страницы из свойства
						"META_KEYWORDS" => "-",	// Установить ключевые слова страницы из свойства
						"PAGER_BASE_LINK_ENABLE" => "N",	// Включить обработку ссылок
						"PAGER_SHOW_ALL" => "N",	// Показывать ссылку "Все"
						"PAGER_TEMPLATE" => ".default",	// Шаблон постраничной навигации
						"PAGER_TITLE" => "Страница",	// Название категорий
						"PROPERTY_CODE" => array(	// Свойства
							0 => "",
							1 => "",
						),
						"SET_BROWSER_TITLE" => "N",	// Устанавливать заголовок окна браузера
						"SET_CANONICAL_URL" => "N",	// Устанавливать канонический URL
						"SET_LAST_MODIFIED" => "N",	// Устанавливать в заголовках ответа время модификации страницы
						"SET_META_DESCRIPTION" => "N",	// Устанавливать описание страницы
						"SET_META_KEYWORDS" => "N",	// Устанавливать ключевые слова страницы
						"SET_STATUS_404" => "Y",	// Устанавливать статус 404
						"SET_TITLE" => "N",	// Устанавливать заголовок страницы
						"SHARE_HANDLERS" => array(	// Используемые соц. закладки и сети
							0 => "twitter",
							1 => "facebook",
							2 => "vk",
						),
						"SHARE_HIDE" => "N",	// Не раскрывать панель соц. закладок по умолчанию
						"SHARE_SHORTEN_URL_KEY" => "",	// Ключ для для bit.ly
						"SHARE_SHORTEN_URL_LOGIN" => "",	// Логин для bit.ly
						"SHARE_TEMPLATE" => "",	// Шаблон компонента панели соц. закладок
						"SHOW_404" => "N",	// Показ специальной страницы
						"USE_PERMISSIONS" => "N",	// Использовать дополнительное ограничение доступа
						"USE_SHARE" => "Y",	// Отображать панель соц. закладок
					),
					false
				);?>
			<?}else{?>
				<?$APPLICATION->IncludeComponent(
					"bitrix:news.list",
					"blog-list",
					array(
						"ACTIVE_DATE_FORMAT" => "j F Y",
						"ADD_SECTIONS_CHAIN" => "N",
						"AJAX_MODE" => "N",
						"AJAX_OPTION_ADDITIONAL" => "",
						"AJAX_OPTION_HISTORY" => "N",
						"AJAX_OPTION_JUMP" => "N",
						"AJAX_OPTION_STYLE" => "Y",
						"CACHE_FILTER" => "N",
						"CACHE_GROUPS" => "Y",
						"CACHE_TIME" => "36000000",
						"CACHE_TYPE" => "A",
						"CHECK_DATES" => "Y",
						"DETAIL_URL" => "",
						"DISPLAY_BOTTOM_PAGER" => "Y",
						"DISPLAY_DATE" => "Y",
						"DISPLAY_NAME" => "Y",
						"DISPLAY_PICTURE" => "Y",
						"DISPLAY_PREVIEW_TEXT" => "Y",
						"DISPLAY_TOP_PAGER" => "N",
						"FIELD_CODE" => array(
							0 => "TAGS",
							1 => "",
						),
						"FILTER_NAME" => "",
						"HIDE_LINK_WHEN_NO_DETAIL" => "N",
						"IBLOCK_ID" => "4",
						"IBLOCK_TYPE" => "blog",
						"INCLUDE_IBLOCK_INTO_CHAIN" => "N",
						"INCLUDE_SUBSECTIONS" => "Y",
						"MESSAGE_404" => "",
						"NEWS_COUNT" => "20",
						"PAGER_BASE_LINK_ENABLE" => "N",
						"PAGER_DESC_NUMBERING" => "N",
						"PAGER_DESC_NUMBERING_CACHE_TIME" => "36000",
						"PAGER_SHOW_ALL" => "N",
						"PAGER_SHOW_ALWAYS" => "N",
						"PAGER_TEMPLATE" => ".default",
						"PAGER_TITLE" => "Новости",
						"PARENT_SECTION" => "",
						"PARENT_SECTION_CODE" => "",
						"PREVIEW_TRUNCATE_LEN" => "",
						"PROPERTY_CODE" => array(
							0 => "",
							1 => "",
						),
						"SET_BROWSER_TITLE" => "N",
						"SET_LAST_MODIFIED" => "N",
						"SET_META_DESCRIPTION" => "N",
						"SET_META_KEYWORDS" => "N",
						"SET_STATUS_404" => "N",
						"SET_TITLE" => "N",
						"SHOW_404" => "N",
						"SORT_BY1" => "ACTIVE_FROM",
						"SORT_BY2" => "SORT",
						"SORT_ORDER1" => "DESC",
						"SORT_ORDER2" => "ASC",
						"COMPONENT_TEMPLATE" => "blog-list"
					),
					false
				);?>
			<?}?>
			<?if($_REQUEST["ELEMENT_CODE"]){
				global $arrFilter;
				$arFilter = array('!ID' => $GLOBALS['ID_POST']);?>
				<?$APPLICATION->IncludeComponent(
					"bitrix:news.list",
					"module_blog_posts",
					array(
						"ACTIVE_DATE_FORMAT" => "j F Y",
						"ADD_SECTIONS_CHAIN" => "N",
						"AJAX_MODE" => "N",
						"AJAX_OPTION_ADDITIONAL" => "",
						"AJAX_OPTION_HISTORY" => "N",
						"AJAX_OPTION_JUMP" => "N",
						"AJAX_OPTION_STYLE" => "Y",
						"CACHE_FILTER" => "N",
						"CACHE_GROUPS" => "Y",
						"CACHE_TIME" => "36000000",
						"CACHE_TYPE" => "A",
						"CHECK_DATES" => "Y",
						"DETAIL_URL" => "",
						"DISPLAY_BOTTOM_PAGER" => "N",
						"DISPLAY_DATE" => "Y",
						"DISPLAY_NAME" => "Y",
						"DISPLAY_PICTURE" => "Y",
						"DISPLAY_PREVIEW_TEXT" => "Y",
						"DISPLAY_TOP_PAGER" => "N",
						"FIELD_CODE" => array(
							0 => "ID",
							1 => "",
						),
						"FILTER_NAME" => "arFilter",
						"HIDE_LINK_WHEN_NO_DETAIL" => "N",
						"IBLOCK_ID" => "4",
						"IBLOCK_TYPE" => "blog",
						"INCLUDE_IBLOCK_INTO_CHAIN" => "N",
						"INCLUDE_SUBSECTIONS" => "Y",
						"MESSAGE_404" => "",
						"NEWS_COUNT" => "3",
						"PAGER_BASE_LINK_ENABLE" => "N",
						"PAGER_DESC_NUMBERING" => "N",
						"PAGER_DESC_NUMBERING_CACHE_TIME" => "36000",
						"PAGER_SHOW_ALL" => "N",
						"PAGER_SHOW_ALWAYS" => "N",
						"PAGER_TEMPLATE" => ".default",
						"PAGER_TITLE" => "Новости",
						"PARENT_SECTION" => "",
						"PARENT_SECTION_CODE" => "",
						"PREVIEW_TRUNCATE_LEN" => "",
						"PROPERTY_CODE" => array(
							0 => "",
							1 => "",
						),
						"SET_BROWSER_TITLE" => "N",
						"SET_LAST_MODIFIED" => "N",
						"SET_META_DESCRIPTION" => "N",
						"SET_META_KEYWORDS" => "N",
						"SET_STATUS_404" => "N",
						"SET_TITLE" => "N",
						"SHOW_404" => "N",
						"SORT_BY1" => "RAND",
						"SORT_BY2" => "SORT",
						"SORT_ORDER1" => "DESC",
						"SORT_ORDER2" => "ASC",
						"COMPONENT_TEMPLATE" => "module_blog_posts"
					),
					false
				);?>
			<?}?>
		</div>
	</div>
</section>
<div class="prop"></div>
<?require($_SERVER["DOCUMENT_ROOT"]."/bitrix/footer.php");?>
