<?
define('MAIN_PAGE', 'Y');
require($_SERVER['DOCUMENT_ROOT'].'/bitrix/header.php');
$APPLICATION->SetTitle('Главная');
?>
<div class="general-cards">
  <div class="backgrounds">
    <div data-card-num='0' class="card-bg card-bg-n0">
      <div class="bg-pattern"></div>
    </div>
    <div data-card-num='1' class="card-bg card-bg-n1"></div>
    <div data-card-num='2' class="card-bg card-bg-n2"></div>
    <div data-card-num='3' class="card-bg card-bg-n3"></div>
    <div data-card-num='4' class="card-bg card-bg-n4"></div>
    <div data-card-num='5' class="card-bg card-bg-n5"></div>
  </div>
  <div class="cards">
    <section id="card-n0" data-card-num='0' class="card card-n0">
      <div class="content">
        <h1><span>Яркие решения для вашего</span><span>стремительного роста</span></h1>
        <h2></h2><a href="#card-n1" class="next"><span>Далее</span></a>
      </div>
    </section>
    <section id="card-n1" data-card-num='1' class="card card-n1">
      <div class="wrap"><img src="<?=$tpPath;?>/static/images/cards/slide1.png">
        <div class="text">
          <h2><span class="num">1</span><span class="title">Изучаем и проектируем</span></h2>
          <div class="description">
            <p>
              Внимательное изучение бизнеса клиентов позволяет нам
              предлагать эффективные решения.<br>
              Результатом этого этапа работ являются прототипы,
              наглядно показывающие концепцию и структуру <br>
              будущего сайта.
            </p>
          </div>
        </div>
      </div>
    </section>
    <section id="card-n2" data-card-num='2' class="card card-n2">
      <div class="wrap"><img src="<?=$tpPath;?>/static/images/cards/slide2.png">
        <div class="text">
          <h2><span class="num">2</span><span class="title">Визуализируем</span></h2>
          <div class="description">
            <p>
              Решения, принимаемые человеком на 100% <br> эмоциональны.
              Доводы разума служат лишь <br> оправданием уже сделанного
              выбора.<br>
              Поэтому мы уделяем особое внимание сильной <br> визуальной
              и эмоциональной составляющей.<br>
              Дизайн должен нравиться!
            </p>
          </div>
        </div>
      </div>
    </section>
    <section id="card-n3" data-card-num='3' class="card card-n3">
      <div class="wrap"><img src="<?=$tpPath;?>/static/images/cards/slide3.png">
        <div class="text">
          <h2><span class="num">3</span><span class="title">Готовим материал</span></h2>
          <div class="description">
            <p>
              Наши маркетологи и копирайтеры уделяют особое внимание
              подготовке материалов к публикации.<br>
              Посетители вашего сайта получают нужное сообщение о
              продукте в доступной и понятной форме. Интересный
              контент — залог успеха сайта.
            </p>
          </div>
        </div>
      </div>
    </section>
    <section id="card-n4" data-card-num='4' class="card card-n4">
      <div class="wrap"><img src="<?=$tpPath;?>/static/images/cards/slide4.png">
        <div class="text">
          <h2><span class="num">4</span><span class="title">Верстаем адаптивно!</span></h2>
          <div class="description">
            <p>
              Адаптивная верстка наших решений совместима с <br> широким
              спектром устройств — от смартфонов и планшетов, до
              телевизоров. Ваш сайт доступен для посетителей
              где бы они не находились!
            </p>
          </div>
        </div>
      </div>
    </section>
    <section id="card-n5" data-card-num='5' class="card card-n5">
      <div class="wrap"><img src="<?=$tpPath;?>/static/images/cards/slide5.png">
        <div class="text">
          <h2><span class="num">5</span><span class="title">Развиваем <br> и продвигаем</span></h2>
          <div class="description">
            <p>
              Любая реклама действует только при попадании в поле
              зрения своей целевой аудитории.<br>
              Мы обеспечиваем продуманное продвижение сайта,
              именно то, которое нужно данному бизнесу —
              SEO, SMM, контекстная, медийная реклама и
              вирусный маркетинг.
            </p>
          </div>
        </div>
      </div>
    </section>
  </div>
  <div class="controls">
    <ul class="cards-switcher">
      <li><a href="#card-n1">1</a></li>
      <li><a href="#card-n2">2</a></li>
      <li><a href="#card-n3">3</a></li>
      <li><a href="#card-n4">4</a></li>
      <li><a href="#card-n5">5</a></li>
    </ul>
  </div>
</div>
<?$APPLICATION->IncludeComponent("bitrix:news.list", "portfolio", Array(
	"ACTIVE_DATE_FORMAT" => "d.m.Y",	// Формат показа даты
		"ADD_SECTIONS_CHAIN" => "N",	// Включать раздел в цепочку навигации
		"AJAX_MODE" => "Y",	// Включить режим AJAX
		"AJAX_OPTION_ADDITIONAL" => "",	// Дополнительный идентификатор
		"AJAX_OPTION_HISTORY" => "N",	// Включить эмуляцию навигации браузера
		"AJAX_OPTION_JUMP" => "N",	// Включить прокрутку к началу компонента
		"AJAX_OPTION_STYLE" => "Y",	// Включить подгрузку стилей
		"CACHE_FILTER" => "N",	// Кешировать при установленном фильтре
		"CACHE_GROUPS" => "Y",	// Учитывать права доступа
		"CACHE_TIME" => "36000000",	// Время кеширования (сек.)
		"CACHE_TYPE" => "A",	// Тип кеширования
		"CHECK_DATES" => "Y",	// Показывать только активные на данный момент элементы
		"DETAIL_URL" => "",	// URL страницы детального просмотра (по умолчанию - из настроек инфоблока)
		"DISPLAY_BOTTOM_PAGER" => "N",	// Выводить под списком
		"DISPLAY_DATE" => "N",	// Выводить дату элемента
		"DISPLAY_NAME" => "Y",	// Выводить название элемента
		"DISPLAY_PICTURE" => "Y",	// Выводить изображение для анонса
		"DISPLAY_PREVIEW_TEXT" => "Y",	// Выводить текст анонса
		"DISPLAY_TOP_PAGER" => "N",	// Выводить над списком
		"FIELD_CODE" => array(	// Поля
			0 => "",
			1 => "",
		),
		"FILTER_NAME" => "",	// Фильтр
		"HIDE_LINK_WHEN_NO_DETAIL" => "N",	// Скрывать ссылку, если нет детального описания
		"IBLOCK_ID" => "1",	// Код информационного блока
		"IBLOCK_TYPE" => "main",	// Тип информационного блока (используется только для проверки)
		"INCLUDE_IBLOCK_INTO_CHAIN" => "N",	// Включать инфоблок в цепочку навигации
		"INCLUDE_SUBSECTIONS" => "N",	// Показывать элементы подразделов раздела
		"MESSAGE_404" => "",	// Сообщение для показа (по умолчанию из компонента)
		"NEWS_COUNT" => "3",	// Количество новостей на странице
		"PAGER_BASE_LINK_ENABLE" => "N",	// Включить обработку ссылок
		"PAGER_DESC_NUMBERING" => "N",	// Использовать обратную навигацию
		"PAGER_DESC_NUMBERING_CACHE_TIME" => "36000",	// Время кеширования страниц для обратной навигации
		"PAGER_SHOW_ALL" => "N",	// Показывать ссылку "Все"
		"PAGER_SHOW_ALWAYS" => "N",	// Выводить всегда
		"PAGER_TEMPLATE" => ".default",	// Шаблон постраничной навигации
		"PAGER_TITLE" => "Новости",	// Название категорий
		"PARENT_SECTION" => "",	// ID раздела
		"PARENT_SECTION_CODE" => "",	// Код раздела
		"PREVIEW_TRUNCATE_LEN" => "",	// Максимальная длина анонса для вывода (только для типа текст)
		"PROPERTY_CODE" => array(	// Свойства
			0 => "ATT_LINK",
			1 => "",
		),
		"SET_BROWSER_TITLE" => "N",	// Устанавливать заголовок окна браузера
		"SET_LAST_MODIFIED" => "N",	// Устанавливать в заголовках ответа время модификации страницы
		"SET_META_DESCRIPTION" => "N",	// Устанавливать описание страницы
		"SET_META_KEYWORDS" => "N",	// Устанавливать ключевые слова страницы
		"SET_STATUS_404" => "N",	// Устанавливать статус 404
		"SET_TITLE" => "N",	// Устанавливать заголовок страницы
		"SHOW_404" => "N",	// Показ специальной страницы
		"SORT_BY1" => "SORT",	// Поле для первой сортировки новостей
		"SORT_BY2" => "ACTIVE_FROM",	// Поле для второй сортировки новостей
		"SORT_ORDER1" => "ASC",	// Направление для первой сортировки новостей
		"SORT_ORDER2" => "DESC",	// Направление для второй сортировки новостей
	),
	false
);?>
<section id="team" class="team">
  <div class="title-block">
    <h1>Команда</h1>
    <h2><span>Пара слов про сплоченный коллектив суровых суперменов и</span><span>супервуменов, готовых наброситься на любую задачу</span></h2>
    <ul class="people">
                  <li><a href="#team-people-1"><img alt="" src="<?=$tpPath;?>/static/images/people/01.png"></a>
                    <blockquote id="team-people-1">
                      <div class="content-wrap">
                        <h3>Дизайнер:</h3>
                        <p>
                          Настоящий профи<br>
                          всегда внимателен к<br>
                          деталям. Сдвинь-ка<br>
                          чекбокс на 7px<br>
                          вправо, бро!
                        </p>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#team-people-2"><img alt="" src="<?=$tpPath;?>/static/images/people/02.png"></a>
                    <blockquote id="team-people-2">
                      <div class="content-wrap">
                        <h3>Дизайнер:</h3>
                        <p>
                          Настоящий профи<br>
                          всегда внимателен к<br>
                          деталям. Сдвинь-ка<br>
                          чекбокс на 7px<br>
                          вправо, бро!
                        </p>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#team-people-3"><img alt="" src="<?=$tpPath;?>/static/images/people/03.png"></a>
                    <blockquote id="team-people-3">
                      <div class="content-wrap">
                        <h3>Дизайнер:</h3>
                        <p>
                          Настоящий профи<br>
                          всегда внимателен к<br>
                          деталям. Сдвинь-ка<br>
                          чекбокс на 7px<br>
                          вправо, бро!
                        </p>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#team-people-4"><img alt="" src="<?=$tpPath;?>/static/images/people/04.png"></a>
                    <blockquote id="team-people-4">
                      <div class="content-wrap">
                        <h3>Дизайнер:</h3>
                        <p>
                          Настоящий профи<br>
                          всегда внимателен к<br>
                          деталям. Сдвинь-ка<br>
                          чекбокс на 7px<br>
                          вправо, бро!
                        </p>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#team-people-5"><img alt="" src="<?=$tpPath;?>/static/images/people/05.png"></a>
                    <blockquote id="team-people-5">
                      <div class="content-wrap">
                        <h3>Дизайнер:</h3>
                        <p>
                          Настоящий профи<br>
                          всегда внимателен к<br>
                          деталям. Сдвинь-ка<br>
                          чекбокс на 7px<br>
                          вправо, бро!
                        </p>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#team-people-6"><img alt="" src="<?=$tpPath;?>/static/images/people/06.png"></a>
                    <blockquote id="team-people-6">
                      <div class="content-wrap">
                        <h3>Дизайнер:</h3>
                        <p>
                          Настоящий профи<br>
                          всегда внимателен к<br>
                          деталям. Сдвинь-ка<br>
                          чекбокс на 7px<br>
                          вправо, бро!
                        </p>
                      </div>
                    </blockquote>
                  </li>
    </ul>
  </div>
</section>
<section id="reviews" class="reviews">
  <div class="inside">
    <h2><span>Каждый наш&nbsp;клиент уникален. Но&nbsp;все похожи в&nbsp;одном&nbsp;—&nbsp;в</span><span>стремлении к&nbsp;выдающимся результатам</span></h2>
    <ul class="reviews-list">
                  <li><a href="#reviews-item-1"><img alt="" src="<?=$tpPath;?>/static/images/reviews-logos/sb-invest.png"></a>
                    <blockquote id="reviews-item-1">
                      <div class="inside">
                        <div class="text">
                          <p>
                            Работа со студией «Веб-Измерение» нас вполне
                            удовлетворила. Коллектив очень творческий и
                            активный. Менеджеры работают чётко и все этапы
                            выполнялись в оговоренные сроки. Наш сайт
                            получился на достойном уровне как мы этого
                            и хотели.
                          </p>
                        </div>
                        <div class="signature">
                          <p><strong>Лысенко А.Е.</strong><em>Главный инженер «СЕВКАВНИПИАГРОПРОМ»</em></p>
                        </div>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#reviews-item-2"><img alt="" src="<?=$tpPath;?>/static/images/reviews-logos/rostvertol.png"></a>
                    <blockquote id="reviews-item-2">
                      <div class="inside">
                        <div class="text">
                          <p>
                            Работа со студией «Веб-Измерение» нас вполне
                            удовлетворила. Коллектив очень творческий и
                            активный. Менеджеры работают чётко и все этапы
                            выполнялись в оговоренные сроки. Наш сайт
                            получился на достойном уровне как мы этого
                            и хотели.
                          </p>
                        </div>
                        <div class="signature">
                          <p><strong>Лысенко А.Е.</strong><em>Главный инженер «СЕВКАВНИПИАГРОПРОМ»</em></p>
                        </div>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#reviews-item-3"><img alt="" src="<?=$tpPath;?>/static/images/reviews-logos/danaia.png"></a>
                    <blockquote id="reviews-item-3">
                      <div class="inside">
                        <div class="text">
                          <p>
                            Работа со студией «Веб-Измерение» нас вполне
                            удовлетворила. Коллектив очень творческий и
                            активный. Менеджеры работают чётко и все этапы
                            выполнялись в оговоренные сроки. Наш сайт
                            получился на достойном уровне как мы этого
                            и хотели.
                          </p>
                        </div>
                        <div class="signature">
                          <p><strong>Лысенко А.Е.</strong><em>Главный инженер «СЕВКАВНИПИАГРОПРОМ»</em></p>
                        </div>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#reviews-item-4"><img alt="" src="<?=$tpPath;?>/static/images/reviews-logos/industria-krasoty.png"></a>
                    <blockquote id="reviews-item-4">
                      <div class="inside">
                        <div class="text">
                          <p>
                            Работа со студией «Веб-Измерение» нас вполне
                            удовлетворила. Коллектив очень творческий и
                            активный. Менеджеры работают чётко и все этапы
                            выполнялись в оговоренные сроки. Наш сайт
                            получился на достойном уровне как мы этого
                            и хотели.
                          </p>
                        </div>
                        <div class="signature">
                          <p><strong>Лысенко А.Е.</strong><em>Главный инженер «СЕВКАВНИПИАГРОПРОМ»</em></p>
                        </div>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#reviews-item-5"><img alt="" src="<?=$tpPath;?>/static/images/reviews-logos/hi-home.png"></a>
                    <blockquote id="reviews-item-5">
                      <div class="inside">
                        <div class="text">
                          <p>
                            Работа со студией «Веб-Измерение» нас вполне
                            удовлетворила. Коллектив очень творческий и
                            активный. Менеджеры работают чётко и все этапы
                            выполнялись в оговоренные сроки. Наш сайт
                            получился на достойном уровне как мы этого
                            и хотели.
                          </p>
                        </div>
                        <div class="signature">
                          <p><strong>Лысенко А.Е.</strong><em>Главный инженер «СЕВКАВНИПИАГРОПРОМ»</em></p>
                        </div>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#reviews-item-6"><img alt="" src="<?=$tpPath;?>/static/images/reviews-logos/sb-invest.png"></a>
                    <blockquote id="reviews-item-6">
                      <div class="inside">
                        <div class="text">
                          <p>
                            Работа со студией «Веб-Измерение» нас вполне
                            удовлетворила. Коллектив очень творческий и
                            активный. Менеджеры работают чётко и все этапы
                            выполнялись в оговоренные сроки. Наш сайт
                            получился на достойном уровне как мы этого
                            и хотели.
                          </p>
                        </div>
                        <div class="signature">
                          <p><strong>Лысенко А.Е.</strong><em>Главный инженер «СЕВКАВНИПИАГРОПРОМ»</em></p>
                        </div>
                      </div>
                    </blockquote>
                  </li>
                  <li><a href="#reviews-item-7"><img alt="" src="<?=$tpPath;?>/static/images/reviews-logos/rostvertol.png"></a>
                    <blockquote id="reviews-item-7">
                      <div class="inside">
                        <div class="text">
                          <p>
                            Работа со студией «Веб-Измерение» нас вполне
                            удовлетворила. Коллектив очень творческий и
                            активный. Менеджеры работают чётко и все этапы
                            выполнялись в оговоренные сроки. Наш сайт
                            получился на достойном уровне как мы этого
                            и хотели.
                          </p>
                        </div>
                        <div class="signature">
                          <p><strong>Лысенко А.Е.</strong><em>Главный инженер «СЕВКАВНИПИАГРОПРОМ»</em></p>
                        </div>
                      </div>
                    </blockquote>
                  </li>
    </ul>
  </div>
</section>
<section id="contacts" class="contacts">
  <div class="head">
    <h2><img alt="Контакты" src="<?=$tpPath;?>/static/images/contacts.svg"></h2>
    <div data-mark-x="39.764460" data-mark-y="47.251650" data-pos-x="39.765236" data-pos-y="47.256611" data-zoom="14" class="map"><img alt="" src="<?=$tpPath;?>/static/images/map-marker.svg" class="marker"></div>
  </div>
  <div class="second">
    <div class="col">
      <div class="phone"><a href="tel:+78632215622"> 8 (863) 22-156-22</a></div>
      <div class="email"><a href="mailto:info@web-izmerenie.ru">info@web-izmerenie.ru</a></div>
      <address><span>344022, Ростов-на-Дону,</span> <span>пр. Сельмаша 90А/17Б, оф. 1204</span>
      </address>
    </div>
    <div class="col">
      <form id="order" action="/feedback-post.json" method="post">
        <input type="text" name="q" value="" style="display:none;" class="bot">
        <label class="text">
          <input type="text" name="name" value=""><span>Ваше имя</span>
        </label>
        <label class="text">
          <input type="text" name="phonemail" value=""><span>Телефон или почта</span>
        </label>
        <label class="textarea">
          <textarea name="message"></textarea><span>Сообщение</span>
        </label>
        <label class="submit">
          <input type="submit" value="Отправить"><span>Отправить</span>
        </label>
      </form>
    </div>
  </div>
</section>
<?
require($_SERVER['DOCUMENT_ROOT'].'/bitrix/footer.php');
?>
