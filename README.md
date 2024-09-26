<hr>
<!-- Donations -->
<div align = "center">
	<h3>Поддержать OpenSource разработку</h3>
	<a href="https://yookassa.ru/my/i/ZvMnfF25nCN8/l">
		<img src="https://yookassa.ru/files/Guide_files/logo-black.svg" alt="Donate RUB" width="240" height="80" />
	</a>
	<div>
		<b>Банковские карты RUB (СБП, SberPay и т.д.)</b>
	</div>
</div>
<!-- Donations -->

<hr/>

<!-- TG -->
<div align = "center">
	<h3>Вступайте в открытый чат по 1С Разработке</h3>
	<a href="https://t.me/grokking_1c">
		<img src="https://icon-icons.com/downloadimage.php?id=72055&root=923/PNG/256/&file=telegram_icon-icons.com_72055.png" alt="Telegram" width="80" height="80" />
	</a>
</div>
<div align = "center">
	<b><i>Общаемся, делимся мыслями, разработками и полезными материалами!</i></b>
</div>
<!-- TG -->

<hr/>

<!-- Content -->
<div align = "center">
	<h1>О Проекте</h1>
</div>

<div align = "center">
	<img src="https://infostart.ru/upload/iblock/a6a/a6ae268fdd278ad3d35dd27ef7dec05e.png" alt="Project thumbnail"/>
</div>

Это полноценная библиотека для интеграции 1С с сервисом GigaChat от Sber, который предоставляет полный доступ к их API для точной работы с диалогами и чатами. Вы можете под себя настраивать поведение нейросети, меняя те или иные настройки в её конфигурации!

Подробнее про сервис вы можете почитать ниже в спойлере "Про сервис"!

В библиотеке успешно реализованы все необходимые функции благодаря которым вы сможете разработать множество интересных и полезных решений для бизнеса!

<div align = "center">
	<img src="https://infostart.ru/upload/iblock/513/5131ebc1d614456c9d5942b8d89a62f0.png" alt="Project thumbnail"/>
</div>

<hr/>

<div align = "center">
	<h1>Функционал библиотеки</h1>
</div>

Ниже представлены элементы системы GigaChatAPI, с которыми Вы можете взаимодействовать, и способы взаимодействия с ними!

Диалоги

    - Создание новых диалогов
    - Удаление существующих диалогов

Сообщения

    - Получение тела сообщения
    - Создание новых сообщений
    - Удаление существующих сообщений
    - Получение всех сообщений диалога

Раздел будет пополняться с выходом новых функций!


<hr/>

<div align = "center">
	<h1>Установка</h1>
</div>

Пошаговая инструкция для начала работы с библиотекой

1. Для начала вам необходимо перейти  на сайт https://developers.sber.ru/studio/login

<div align = "center">
	<img src="https://infostart.ru/upload/iblock/bfd/bfd9317626eef56f64dc7e9f739631bc.png" alt="Project thumbnail" width = "300"/>
</div>

2. Нажмите на Sber ID и далее нажмите "По QR-коду"

<div align = "center">
	<img src="https://infostart.ru/upload/iblock/e17/e17168bbcfae796312965daac7521abd.png" alt="Project thumbnail" width = "300"/>
</div>
    
3. Далее запустите своё мобильное приложение Сбера, отсканируйте появившийся на экране QR и подтвердите вход

<div align = "center">
	<img src="https://infostart.ru/upload/iblock/0f4/0f44acefc315def3ec16822106595d2d.jpg" alt="Project thumbnail" width = "300"/>
</div>

4. Затем в списке проектов выберите GigaChat API

<div align = "center">
	<img src="https://infostart.ru/upload/iblock/597/597c770bdde8ba962380edc557de28bf.png" alt="Project thumbnail" width = "300"/>
</div>

5. Затем откройте проект и нажмите "Сгенерировать токен/новый"

<div align = "center">
	<img src="https://infostart.ru/upload/iblock/2d1/2d14f27d212ca1e416b3c70e65d34b2a.png" alt="Project thumbnail" width = "300"/>
</div>

6. В появившемся окне скопируйте Авторизационные данные из второго поля

<div align = "center">
	<img src="https://infostart.ru/upload/iblock/ed7/ed7342d3ad559b303a2b714328207d7a.png" alt="Project thumbnail" width = "300"/>
</div>

7. И вставьте скопированную строку в функцию "ПолучитьАвторизационныеДанные" в общем модуле "GigaChat_Сервер"

<div align = "center">
	<img src="https://infostart.ru/upload/iblock/c41/c416a743eddcd07588547650fc61322e.png" alt="Project thumbnail" width = "300"/>
</div>


<hr/>

<div align = "center">
	<h1>Пример использования библиотеки</h1>
</div>

```
НовыйДиалог = GigaChat_Сервер.СоздатьДиалог(Наименование);
НовоеСообщение = GigaChat_Сервер.СоздатьСообщение(Новый УникальныйИдентификатор(НовыйДиалог.ИдентификаторДиалога),Содержимое);
СообщенияДиалога = GigaChat_Сервер.ПолучитьСообщенияДиалога(Новый УникальныйИдентификатор(НовыйДиалог.ИдентификаторДиалога));
```
В итоге переменная будет содержать все сообщения этого диалога, который вы сможете отобразить. 

Для удобства в библиотеке уже есть форма для работы с диалогами и сообщениям, которую вы можете использовать как есть или доработать под себя!

<div align = "left">
	<img src="https://infostart.ru/upload/iblock/2b3/2b37d874d5099f8f80443a8fd0203fa7.png" alt="Project thumbnail" width = "200"/>
	<img src="https://infostart.ru/upload/iblock/f16/f1638bcfab24fee04801432c55f94ba6.png" alt="Project thumbnail" width = "200"/>
	<img src="https://infostart.ru/upload/iblock/821/821df575f40c3bace23e0cb782542bc2.png" alt="Project thumbnail" width = "200"/>
	<img src="https://infostart.ru/upload/iblock/e59/e595d0e902414113c5c0f5e04653fb8e.png" alt="Project thumbnail" width = "200"/>
	<img src="https://infostart.ru/upload/iblock/d37/d37cab9f53bd71c7118c388d3e135814.png" alt="Project thumbnail" width = "200"/>
	<img src="https://infostart.ru/upload/iblock/db2/db290272e20828621c9e92dbcc929254.png" alt="Project thumbnail" width = "500"/>
</div>



<hr/>

<div align = "center">
	<h1>Совместимость</h1>
</div>

Обратите внимание что версии ПО на вашем компьютере не обязательно должны быть идентичными версиям ниже, так как у библиотеки нет строгой зависимости. В разделе "Полезные советы" вы можете найти немного информации по этому вопросу!

<b>Платформа (На которой проводилось последнее тестирование): 8.3.25.1394</b>


<hr/>

<div align = "center">
	<h1>Про сервис</h1>
</div>

GigaChat — это сервис, который умеет взаимодействовать с пользователем в формате диалога, писать код, создавать тексты и картинки по запросу пользователя. При этом GigaChat стремится избегать спорных этических вопросов или провокаций.

GigaChat поддерживает русский и английский языки.

<div align = "left">
	<img src="https://infostart.ru/upload/iblock/3b2/3b2e651e1b331d9d7e113ece134b8d95.png" alt="Project thumbnail"/>
</div>

<!-- Content -->

<!-- Partner -->
<hr>
<div align = "center">
	<h3>Страница проекта на Infostart</h3>
	<a href="https://infostart.ru/1c/tools/2194329/">
		<img src="https://infostart.ru/bitrix/templates/sandbox_empty/assets/tpl/abo/img/logo.svg" alt="Infostart" width="240" height="80" />
	</a>
</div>
<hr>
<!-- Partner -->
