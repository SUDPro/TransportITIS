<html>
<head>
    <title>
        Profile
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!--
        Укажите свой API-ключ. Тестовый ключ НЕ БУДЕТ работать на других сайтах.
        Получить ключ можно в Кабинете разработчика: https://developer.tech.yandex.ru/keys/
    -->
    <script src="https://api-maps.yandex.ru/2.1/?apikey=<0f81e2ba-2097-4277-afdd-754647ceee0d>&lang=ru_RU"
            type="text/javascript"></script>
    <style type="text/css">
         #map {
            width: 100%;
            height: 60%;
            margin: 0;
            padding: 0;
        }
    </style>
    <link href="https://fonts.googleapis.com/css?family=Croissant+One" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Raleway:400,500,600,700,800,900" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="/css/test.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script>
        function makeId(length) {
            var result = '';
            var characters = 'abcdefghijklmnopqrstuvwxyz';
            var charactersLength = characters.length;
            for (var i = 0; i < length; i++) {
                result += characters.charAt(Math.floor(Math.random() * charactersLength));
            }
            return result;
        }
    </script>
</head>
<body>
<nav class="site-header sticky-top py-1" style="background: #f1f1f1 !important;">

        <#if user.getRole() == "STUDENT">
            <div class="container d-flex flex-column flex-md-row justify-content-between">
                <a class="py-2 d-none d-md-inline-block" href="/trips">Поездки</a>
                <a class="py-2 d-none d-md-inline-block" href="/profile">Профиль</a>
                <a class="py-2 d-none d-md-inline-block" href="/logout">Выход</a>
            </div>
        </#if>
        <#if user.getRole() == "ADMIN">
            <div class="container d-flex flex-column flex-md-row justify-content-between">
                <a class="py-2 d-none d-md-inline-block" href="/trips">Поездки</a>
                <a class="py-2 d-none d-md-inline-block" href="/profile">Профиль</a>
                <a class="py-2 d-none d-md-inline-block" href="/new_driver">Добавить водителя</a>
                <a class="py-2 d-none d-md-inline-block" href="/new_trip">Добавить поездку</a>
                <a class="py-2 d-none d-md-inline-block" href="/admin">Чаты поддержки</a>
                <a class="py-2 d-none d-md-inline-block" href="/logout">Выход</a>
            </div>
        </#if>

</nav>
<br>
<#if user.getRole() == "ADMIN">
        <div class="row" style="display: inline; horiz-align: right; height: 50% !important; width: 100% !important;">
            <a href="/new_trip">
                <div class="col-md-4 col-sm-4" style="padding-left: 20px;">
                    <div class="design-development one">
                        <i class="material-icons">lightbulb_outline</i>
                        <h2>Новая поездка</h2>
                        <p>Здесь вы можете создать новую поездку</p>
                    </div>
                </div>
            </a>
            <a href="/new_driver">
                <div class="col-md-4 col-sm-4">
                    <div class="design-development two">
                        <i class="material-icons">color_lens</i>
                        <h2>Добавить водителя</h2>
                        <p>Здесь вы можете добавить водителя</p>
                    </div>
                </div>
            </a>
            <a href="/admin">
                <div class="col-md-4 col-sm-4" style="padding-right: 0">
                    <div class="design-development three">
                        <i class="material-icons">developer_board</i>
                        <h2>Чаты поддержки</h2>
                        <p>Здесь вы можете ответить на сообщения</p>
                    </div>
                </div>
            </a>
        </div>
</#if>

<#if user.getRole() == "STUDENT">

        <div style="horiz-align: center; margin-left: 40%" class="side-bar">
            <!-- Professional Details -->
                    <h1> <span> Имя: </span> ${user.getName()}  </h1>

                    <h1> <span> Фамилия: </span> ${user.getSurname()} </h1>

                    <h1> <span> Дата рождения: </span>${user.getDate()}</h1>

                    <h1> <span> Email: </span> ${user.getEmail()} </h1>

                    <h1> <span> Адрес: </span> ${user.getAddress()} </h1>

        </div>
    <br>
    <br>
    <div style="horiz-align: center" id="map"></div>
    <div class="msg_box" style="right:50px" rel="skp">
        <div class="msg_head">
            Поддержка
        </div>
        <div id="username-page">
            <div class="username-page-container">
                <h1 class="title">Введите имя</h1>
                <form id="usernameForm" name="usernameForm">
                    <div class="form-group">
                        <input type="text" id="name" placeholder="Username" autocomplete="off" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <input type="hidden" id="room-id" placeholder="Room ID" autocomplete="off"
                               class="form-control"/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="accent username-submit">Начать!</button>
                    </div>
                </form>
            </div>
        </div>

        <div id="chat-page" class="hidden">
            <div class="chat-container">
                <div class="chat-header">
                    <h2>Чат <span id="room-id-display"></span></h2>
                </div>
                <div class="connecting">
                    Соединяем...
                </div>
                <div class="message-box">
                    <ul style="overflow: hidden; width: 300px; height: 200px;" id="messageArea">

                    </ul>
                </div>
                <form id="messageForm" name="messageForm" nameForm="messageForm">
                    <div class="form-group">
                        <div class="input-group clearfix">
                            <input type="text" id="message" placeholder="Type a message..."
                                   autocomplete="off" class="form-control"/>
                            <button type="submit" class="primary">Отправить</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="/webjars/sockjs-client/1.0.0/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
    <script src="/webjars/js-cookie/js.cookie.js"></script>
<#--<script src="/js/test.js"></script>-->
    <script src="/js/main.js"></script>
    <script src="/js/test.js"></script>
    <script type="text/javascript">
        ymaps.ready(init);

        function init() {
            var myMap = new ymaps.Map('map', {
                center: [55.753994, 37.622093],
                zoom: 9
            });

            // Поиск координат центра Нижнего Новгорода.
            ymaps.geocode('${user.getAddress()}', {
                /**
                 * Опции запроса
                 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/geocode.xml
                 */
                // Сортировка результатов от центра окна карты.
                // boundedBy: myMap.getBounds(),
                // strictBounds: true,
                // Вместе с опцией boundedBy будет искать строго внутри области, указанной в boundedBy.
                // Если нужен только один результат, экономим трафик пользователей.
                results: 1
            }).then(function (res) {
                // Выбираем первый результат геокодирования.
                var firstGeoObject = res.geoObjects.get(0),
                    // Координаты геообъекта.
                    coords = firstGeoObject.geometry.getCoordinates(),
                    // Область видимости геообъекта.
                    bounds = firstGeoObject.properties.get('boundedBy');

                firstGeoObject.options.set('preset', 'islands#darkBlueDotIconWithCaption');
                // Получаем строку с адресом и выводим в иконке геообъекта.
                firstGeoObject.properties.set('iconCaption', firstGeoObject.getAddressLine());

                // Добавляем первый найденный геообъект на карту.
                myMap.geoObjects.add(firstGeoObject);
                // Масштабируем карту на область видимости геообъекта.
                myMap.setBounds(bounds, {
                    // Проверяем наличие тайлов на данном масштабе.
                    checkZoomRange: true
                });

                /**
                 * Все данные в виде javascript-объекта.
                 */
                console.log('Все данные геообъекта: ', firstGeoObject.properties.getAll());
                /**
                 * Метаданные запроса и ответа геокодера.
                 * @see https://api.yandex.ru/maps/doc/geocoder/desc/reference/GeocoderResponseMetaData.xml
                 */
                console.log('Метаданные ответа геокодера: ', res.metaData);
                /**
                 * Метаданные геокодера, возвращаемые для найденного объекта.
                 * @see https://api.yandex.ru/maps/doc/geocoder/desc/reference/GeocoderMetaData.xml
                 */
                console.log('Метаданные геокодера: ', firstGeoObject.properties.get('metaDataProperty.GeocoderMetaData'));
                /**
                 * Точность ответа (precision) возвращается только для домов.
                 * @see https://api.yandex.ru/maps/doc/geocoder/desc/reference/precision.xml
                 */
                console.log('precision', firstGeoObject.properties.get('metaDataProperty.GeocoderMetaData.precision'));
                /**
                 * Тип найденного объекта (kind).
                 * @see https://api.yandex.ru/maps/doc/geocoder/desc/reference/kind.xml
                 */
                console.log('Тип геообъекта: %s', firstGeoObject.properties.get('metaDataProperty.GeocoderMetaData.kind'));
                console.log('Название объекта: %s', firstGeoObject.properties.get('name'));
                console.log('Описание объекта: %s', firstGeoObject.properties.get('description'));
                console.log('Полное описание объекта: %s', firstGeoObject.properties.get('text'));
                /**
                 * Прямые методы для работы с результатами геокодирования.
                 * @see https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/GeocodeResult-docpage/#getAddressLine
                 */
                console.log('\nГосударство: %s', firstGeoObject.getCountry());
                console.log('Населенный пункт: %s', firstGeoObject.getLocalities().join(', '));
                console.log('Адрес объекта: %s', firstGeoObject.getAddressLine());
                console.log('Наименование здания: %s', firstGeoObject.getPremise() || '-');
                console.log('Номер здания: %s', firstGeoObject.getPremiseNumber() || '-');

                /**
                 * Если нужно добавить по найденным геокодером координатам метку со своими стилями и контентом балуна, создаем новую метку по координатам найденной и добавляем ее на карту вместо найденной.
                 */
                /**
                 var myPlacemark = new ymaps.Placemark(coords, {
             iconContent: 'моя метка',
             balloonContent: 'Содержимое балуна <strong>моей метки</strong>'
             }, {
             preset: 'islands#violetStretchyIcon'
             });

                 myMap.geoObjects.add(myPlacemark);
                 */
            });
        }
    </script>
</#if>
</body>
</html>