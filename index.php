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
<section id="portfolio" class="portfolio">
  <div class="title-block">
    <h2>Работы</h2>
    <h3>Более 100 проектов за 7 лет работы</h3>
  </div>
  <ul>
    <li><img alt="Текстильная фабрика «ДМ-Текстиль»" src="<?=$tpPath;?>/static/images/portfolio/dmtextile.jpg" class="bg">
      <div class="text">
        <h3>ДМ-Текстиль</h3>
        <h4>Сайт текстильной фабрики</h4>
      </div><a href="http://dmtextile.ru/" target="_blank">Перейти на сайт</a>
    </li>
    <li><img alt="Portland" src="<?=$tpPath;?>/static/images/portfolio/portlandshow.jpg" class="bg">
      <div class="text">
        <h3>Portland</h3>
        <h4>Сайт для арт-шоу ресторана Portland</h4>
      </div><a href="http://portlandshow.ru/" target="_blank">Перейти на сайт</a>
    </li>
    <li><img alt="Даная" src="<?=$tpPath;?>/static/images/portfolio/danaia.jpg" class="bg">
      <div class="text">
        <h3>Даная</h3>
        <h4>Сайт ювелирного дома</h4>
      </div><a href="http://jhdanaya.ru/" target="_blank">Перейти на сайт</a>
    </li>
  </ul>
  <div class="more-block"><a href="/#portfolio-more"><i class="a"></i><i class="b"></i><span class="title">Показать ещё</span></a></div>
</section>
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
