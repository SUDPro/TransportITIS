<html>
<head>
    <title>
        Trip
    </title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/timetable.css"/>
</head>
<body>
<nav class="site-header sticky-top py-1" style="background: #f1f1f1 !important;">
    <#if user??>
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
    <#else>
        <div class="container d-flex flex-column flex-md-row justify-content-between">
            <a class="py-2 d-none d-md-inline-block" href="/trips">Поездки</a>
            <a class="py-2 d-none d-md-inline-block" href="/auth">Войти</a>
            <a class="py-2 d-none d-md-inline-block" href="/reg">Регистрация</a>
        </div>
    </#if>
</nav>
<div style="horiz-align: center;" class="side-bar">
    <!-- Professional Details -->
    <h1> <span> Поездка: </span> ${trip.getName()}  </h1>

    <h1> <span> Водитель: </span> ${trip.getDriver().getName()} </h1>

    <h1> <span> Адрес(СТАРТ): </span>${trip.getStart()}</h1>

    <h1> <span> Адрес(ФИНИШ): </span> ${trip.getFinish()}</h1>

    <h1> <span> Мест свободно: </span> ${trip.getQuota() - trip.getInBus()} / ${trip.getQuota()}</h1>

    <h1> <span> Пассажиры: </span></h1>

<#if error??>
    <span class="alert-danger">${error}</span>
    <br>
</#if>
    <#if user.getRole() == "STUDENT">
        <#if trip.open>
<form method="post">
    <button type="submit" style="background-color: #4CAF50" name="apply">Присоединиться</button>

    <button style="background-color: red" type="submit" name="decline"> Отказаться </button>
</form>
        <#else>
            <span class="alert-danger">Поездка закрыта!</span>
        </#if>
    </#if>
    <#if user.getRole() == "ADMIN">
       <a href="http://gen.ulnar.ru/route/%7B%22start%22:%5B${trip.getStartCoordinates()}%5D,%22end%22:%5B${trip.getFinishCoordinates()}%5D,%22points%22:%5B%5B<#list users as user>${user.getCoordinates()}%5D,%5B</#list>${trip.getFinishCoordinates()}%5D%5D,%22method%22:%221%22,%22optimization%22:%222%22,%22center%22:%5B55.82092599998725,49.12610499999999%5D,%22zoom%22:13%7D">Open map</a>
    </#if>

<TABLE class="Timetable">
    <THEAD>
    <TR>
        <TH>Имя</TH>
        <TH>Фамилия</TH>
        <TH>Дата рождения</TH>
    </TR>
    </THEAD>
    <TBODY>
    <#list users as user>
        <TR>
            <TD>
                <div class="subject"> ${user.getName()}</div>
            </TD>
            <TD>
                <div class="subject"> ${user.getSurname()}</div>
            </TD>
            <TD>
                <div class="subject"> ${user.getDate()}</div>
            </TD>

        </TR>
    </#list>
    </TBODY>
</TABLE>
</body>
</html>