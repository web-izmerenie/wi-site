<?
if(!defined('B_PROLOG_INCLUDED') || B_PROLOG_INCLUDED !== true)
	die();
	$tpPath = SITE_TEMPLATE_PATH;
	global $tpPath;

	$html_classes = array();

	if(defined('MAIN_PAGE'))
		$html_classes[] = 'general-page';

	if(!defined('MAIN_PAGE'))
		$html_classes[] = 'sub-page';

	if(defined('BLOG'))
		$html_classes[] = 'blog-page';

	$html_classes = implode(' ', $html_classes);
?>
<!DOCTYPE html>
<html lang="ru" class="no-js <?=$html_classes;?>">
	<head>
		<title><?$APPLICATION->ShowTitle()?></title>
		<?$APPLICATION->ShowHead();?>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<?=$tpPath;?>/static/build.css" rel="stylesheet" type="text/css" class="main-styles">
		<script src="http://maps.google.com/maps/api/js"></script>
		<script src="<?=$tpPath;?>/static/build.js"></script>
	</head>
	<body>
		<?$APPLICATION->ShowPanel();?>
		<div class="top-part">
			<header>
				<a href="/#card-n0" class="logo">
					<img alt="Логотип" src="<?=$tpPath;?>/static/images/wi-logo.svg" class="logo-image">
					<span class="logo-text">Web izmerenie</span>
				</a>
				<div class="fixed-header">
					<div class="bg-helper"></div>
					<a href="#menu" title="Открыть меню" class="call-menu">Открыть меню</a>
					<div id="menu" class="menu">
						<a href="/#card-n0" class="logo">
							<img alt="Логотип" src="<?=$tpPath;?>/static/images/wi-logo.svg" class="logo-image">
							<span class="logo-text">Web izmerenie</span>
						</a>
						<nav>
							<div class="wrap">
								<a href="/#portfolio">Работы</a>
								<a href="/#team">Команда</a>
								<a href="/#reviews">Отзывы</a>
								<a href="/#contacts">Контакты</a>
								<a href="/#order">Сделать заказ</a>
							</div>
						</nav>
					</div>
				</div>
			</header>
