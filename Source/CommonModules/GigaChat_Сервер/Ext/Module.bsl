﻿#Область ЛокальныеФункции 

Функция ВставитьПараметры(Адрес,Параметры)
	Адрес = Адрес + "?";
	Для Каждого Стр Из Параметры Цикл
		Адрес = Адрес + "&" + Стр.Ключ + "=" + Стр.Значение;
	КонецЦикла;
	Возврат Адрес;
КонецФункции
//
Функция ПолучитьСоединение(Хост = Неопределено,Порт = Неопределено)
	ЗС = Новый ЗащищенноеСоединениеOpenSSL();
	//
	Если Хост <> Неопределено И Порт <> Неопределено Тогда
		HTTPСоединение = Новый HTTPСоединение(Хост,Порт,,,,,ЗС,);
	Иначе
		HTTPСоединение = Новый HTTPСоединение("gigachat.devices.sberbank.ru",,,,,,ЗС,);	
	КонецЕсли;
	//
	Возврат HTTPСоединение;
КонецФункции
//
Функция ПолучитьЗаголовки()
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Authorization","Bearer "+"");
	Заголовки.Вставить("Content-Type","application/json");
	Возврат Заголовки;
КонецФункции
//
Функция ОбработатьОтвет(Ответ)
	Если Ответ.КодСостояния = 200 Или Ответ.КодСостояния = 204 Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
КонецФункции
//
Функция УбратьРазделители(Стр)
	Если Стр <> Неопределено Тогда
		Врем = Строка(Стр);
		Врем = СтрЗаменить(Врем,",","");
		Врем = СтрЗаменить(Врем,".","");
		Врем = СтрЗаменить(Врем,"'","");
		Возврат Врем;
	Иначе
		Возврат Стр;
	КонецЕсли;
КонецФункции
//
Функция ПолучитьJSONФайл(ДанныеТела)
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("json");
	ЗаписьJSON = Новый ЗаписьJSON; 
	ЗаписьJSON.ОткрытьФайл(ИмяВременногоФайла);
	ЗаписатьJSON(ЗаписьJSON, ДанныеТела,Новый НастройкиСериализацииJSON); 
	ЗаписьJSON.Закрыть();
	Возврат ИмяВременногоФайла;
КонецФункции

#Область Авторизация

Процедура ЗаписатьТокенВбазу(Токен = Неопределено)
	МенеджерЗаписи = РегистрыСведений.GigaChat_ТокеныАвторизации.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Период = ТекущаяДата();
	МенеджерЗаписи.ИдентификаторТокена = Новый УникальныйИдентификатор;
	МенеджерЗаписи.Токен = Токен;
	МенеджерЗаписи.Записать();
КонецПроцедуры
//
Процедура ОбновитьТокенАвторизации()
	Соединение = ПолучитьСоединение("ngw.devices.sberbank.ru",9443);
	//
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Authorization","Bearer " + ПолучитьАвторизационныеДанные());
	Заголовки.Вставить("Content-Type","application/x-www-form-urlencoded");
	Заголовки.Вставить("Accept","*/*");
	Заголовки.Вставить("Accept-Encoding","gzip, deflate, br");
	Заголовки.Вставить("Connection","keep-alive");
	Заголовки.Вставить("RqUID","6f0b1291-c7f3-43c6-bb2e-9f3efb2dc98e");
	//
	Параметры = Новый Соответствие;
	//
	HTTPЗапрос = Новый HTTPЗапрос(ВставитьПараметры("/api/v2/oauth",Параметры),Заголовки);
	HTTPЗапрос.УстановитьТелоИзСтроки("scope=GIGACHAT_API_PERS");
	Ответ = Соединение.ВызватьHTTPМетод("POST",HTTPЗапрос);
	Если Ответ.КодСостояния = 200 Тогда
		ЧтениеJSON = Новый ЧтениеJSON;
		ЧтениеJSON.УстановитьСтроку(Ответ.ПолучитьТелоКакСтроку());
		ДанныеJSON = ПрочитатьJSON(ЧтениеJSON);
		ЧтениеJSON.Закрыть();
		//
		ЗаписатьТокенВбазу(ДанныеJSON.access_token);
	Иначе
		//
	КонецЕсли;
	//TODO: Запись в лог результат
КонецПроцедуры
//
Функция ПолучитьАвторизационныеДанные()
	Возврат "MzljOWFkNDItMGJmNy00NmUxLWJiZTUtMmM2MzhhZjhkNjIwOmRkYTdkMTQ2LWI5OGQtNDQwOC05OWZhLTYxY2Q0YjQ2MTNiNg==";
КонецФункции

#КонецОбласти

#КонецОбласти

#Область ГлобальныеФункции

#Область Авторизация

Функция ПолучитьАктуальныйТокен() Экспорт
	Период = Неопределено;
	Токен = Неопределено;
	//
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	GigaChat_ТокеныАвторизацииСрезПоследних.ИдентификаторТокена КАК ИдентификаторТокена,
	               |	GigaChat_ТокеныАвторизацииСрезПоследних.Токен КАК Токен,
	               |	GigaChat_ТокеныАвторизацииСрезПоследних.Период КАК Период
	               |ИЗ
	               |	РегистрСведений.GigaChat_ТокеныАвторизации.СрезПоследних КАК GigaChat_ТокеныАвторизацииСрезПоследних
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	GigaChat_ТокеныАвторизацииСрезПоследних.Период УБЫВ";
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		ОбновитьТокенАвторизации();
		//
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
		               |	GigaChat_ТокеныАвторизацииСрезПоследних.Токен КАК Токен
		               |ИЗ
		               |	РегистрСведений.GigaChat_ТокеныАвторизации.СрезПоследних КАК GigaChat_ТокеныАвторизацииСрезПоследних
		               |
		               |УПОРЯДОЧИТЬ ПО
		               |	GigaChat_ТокеныАвторизацииСрезПоследних.Период УБЫВ";
		РезультатЗапроса = Запрос.Выполнить();
		Если РезультатЗапроса.Пустой() Тогда
			Токен = Неопределено;
		Иначе
			ВыборкаЗапроса = РезультатЗапроса.Выбрать();
			Пока ВыборкаЗапроса.Следующий() Цикл
				Токен = ВыборкаЗапроса.Токен;
			КонецЦикла;
		КонецЕсли;
	Иначе
		ВыборкаЗапроса = РезультатЗапроса.Выбрать();
		Пока ВыборкаЗапроса.Следующий() Цикл
			Период = ВыборкаЗапроса.Период;
			Токен = ВыборкаЗапроса.Токен;
		КонецЦикла;
		//
		Если ТекущаяДата() >= (Период + 1800)  Тогда
			ОбновитьТокенАвторизации();
			Запрос = Новый Запрос;
			Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
			               |	GigaChat_ТокеныАвторизацииСрезПоследних.Токен КАК Токен
			               |ИЗ
			               |	РегистрСведений.GigaChat_ТокеныАвторизации.СрезПоследних КАК GigaChat_ТокеныАвторизацииСрезПоследних
			               |
			               |УПОРЯДОЧИТЬ ПО
			               |	GigaChat_ТокеныАвторизацииСрезПоследних.Период УБЫВ";
			РезультатЗапроса = Запрос.Выполнить();
            ВыборкаЗапроса = РезультатЗапроса.Выбрать();
			Пока ВыборкаЗапроса.Следующий() Цикл
				Токен = ВыборкаЗапроса.Токен;
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	//
	Возврат Токен;
КонецФункции

#КонецОбласти

#Область Диалоги

Функция СоздатьДиалог(Наименование = Неопределено) Экспорт
	МенеджерЗаписи = РегистрыСведений.GigaChat_Диалоги.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Период = ТекущаяДата();
	МенеджерЗаписи.ИдентификаторДиалога = Новый УникальныйИдентификатор;
	Если Наименование <> Неопределено Тогда
		МенеджерЗаписи.Наименование = Наименование;
	КонецЕсли;
	МенеджерЗаписи.Записать();
	//
	ТекущийДиалог = Новый Структура;
	ТекущийДиалог.Вставить("ИдентификаторДиалога",МенеджерЗаписи.ИдентификаторДиалога);
	ТекущийДиалог.Вставить("Наименование",МенеджерЗаписи.Наименование);
	Возврат ТекущийДиалог;
КонецФункции
//
Функция УдалитьДиалог(ИдентификаторДиалога = Неопределено) Экспорт
	Если ИдентификаторДиалога = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	//
	НаборЗаписейСообщения = РегистрыСведений.GigaChat_Сообщения.СоздатьНаборЗаписей();
	НаборЗаписейСообщения.Отбор.ИдентификаторДиалога.Установить(ИдентификаторДиалога);
	НаборЗаписейСообщения.Записать();
	//
	МенеджерЗаписиДиалог = РегистрыСведений.GigaChat_Диалоги.СоздатьМенеджерЗаписи();
	МенеджерЗаписиДиалог.ИдентификаторДиалога = ИдентификаторДиалога;
	МенеджерЗаписиДиалог.Прочитать();
	Если МенеджерЗаписиДиалог.Выбран() Тогда
		МенеджерЗаписиДиалог.Удалить();
	КонецЕсли;
	//
	Возврат Истина;
КонецФункции
//
Функция ПолучитьСообщенияДиалога(ИдентификаторДиалога = Неопределено) Экспорт
	Если ИдентификаторДиалога = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	//
	Сообщения = Новый Массив;
	//
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	GigaChat_СообщенияСрезПоследних.Период КАК Период,
	               |	GigaChat_СообщенияСрезПоследних.ИдентификаторСообщения КАК ИдентификаторСообщения,
	               |	GigaChat_СообщенияСрезПоследних.Содержимое КАК Содержимое,
				   |	GigaChat_СообщенияСрезПоследних.ОтПользователя КАК ОтПользователя
	               |ИЗ
	               |	РегистрСведений.GigaChat_Сообщения.СрезПоследних КАК GigaChat_СообщенияСрезПоследних
	               |ГДЕ
	               |	GigaChat_СообщенияСрезПоследних.ИдентификаторДиалога = &ИдентификаторДиалога
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Период";
	Запрос.УстановитьПараметр("ИдентификаторДиалога",ИдентификаторДиалога);
	РезультатЗапроса = Запрос.Выполнить();
	//
	ВыборкаЗапроса = РезультатЗапроса.Выбрать();
	Пока ВыборкаЗапроса.Следующий() Цикл
		ТекущееСообщение = Новый Структура;
		ТекущееСообщение.Вставить("ДатаОтправки",ВыборкаЗапроса.Период);
		ТекущееСообщение.Вставить("ИдентификаторСообщения",ВыборкаЗапроса.ИдентификаторСообщения);
		ТекущееСообщение.Вставить("Содержимое",ВыборкаЗапроса.Содержимое);
		ТекущееСообщение.Вставить("ОтПользователя",ВыборкаЗапроса.ОтПользователя);
		Сообщения.Добавить(ТекущееСообщение);
	КонецЦикла;
	//
	Возврат Сообщения;
КонецФункции

#КонецОбласти

#Область Сообщения

Функция ПолучитьТелоСообщения(ИдентификаторДиалога = Неопределено, Содержимое = Неопределено)
	Сообщения = ПолучитьСообщенияДиалога(ИдентификаторДиалога);
	//TODO: Вынести настройки отдельно
	ТелоСообщения = Новый Структура;
	ТелоСообщения.Вставить("model","GigaChat:latest");
	ТелоСообщения.Вставить("temperature",0.87);
	ТелоСообщения.Вставить("top_p",0.47);
	ТелоСообщения.Вставить("n",1);
	ТелоСообщения.Вставить("max_tokens",512);
	ТелоСообщения.Вставить("repetition_penalty",1.07);
	ТелоСообщения.Вставить("stream",Ложь);
	ТелоСообщения.Вставить("update_interval",0);
	ТелоСообщения.Вставить("messages",Новый Массив);
	//
	Для Каждого Сообщение Из Сообщения Цикл
		ТекущееСообщение = Новый Структура;
		Если Сообщение.ОтПользователя Тогда
			ТекущееСообщение.Вставить("role","user");
		Иначе
			ТекущееСообщение.Вставить("role", "assistant");
		КонецЕсли;
		ТекущееСообщение.Вставить("content",Сообщение.Содержимое);
		//
		ТелоСообщения.messages.Добавить(ТекущееСообщение);
	КонецЦикла;
	//
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON,ТелоСообщения);	
	Возврат ЗаписьJSON.Закрыть();
КонецФункции
//
Функция СоздатьСообщение(ИдентификаторДиалога = Неопределено, Содержимое = Неопределено) Экспорт
	Если ИдентификаторДиалога = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	//
	МенеджерЗаписиСообщение = РегистрыСведений.GigaChat_Сообщения.СоздатьМенеджерЗаписи();
	МенеджерЗаписиСообщение.Период = ТекущаяДата();
	МенеджерЗаписиСообщение.ИдентификаторСообщения = Новый УникальныйИдентификатор;
	МенеджерЗаписиСообщение.ИдентификаторДиалога = ИдентификаторДиалога;
	МенеджерЗаписиСообщение.Содержимое = Содержимое;
	МенеджерЗаписиСообщение.ОтПользователя = Истина;
	МенеджерЗаписиСообщение.Записать();
	//
	Соединение = ПолучитьСоединение();
	//
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Authorization","Bearer " + ПолучитьАктуальныйТокен());
	Заголовки.Вставить("Content-Type","application/json");
	Заголовки.Вставить("Accept","*/*");
	Заголовки.Вставить("Accept-Encoding","gzip, deflate, br");
	Заголовки.Вставить("Connection","keep-alive");
	Заголовки.Вставить("X-Request-ID","79e41a5f-f180-4c7a-b2d9-393086ae20a1");
	Заголовки.Вставить("X-Session-ID","b6874da0-bf06-410b-a150-fd5f9164a0b2");
	Заголовки.Вставить("X-Client-ID","b6874da0-bf06-410b-a150-fd5f9164a0b2");
	//
	Параметры = Новый Соответствие;
	//
	HTTPЗапрос = Новый HTTPЗапрос("/api/v1/chat/completions",Заголовки);
	HTTPЗапрос.УстановитьТелоИзСтроки(ПолучитьТелоСообщения(ИдентификаторДиалога,Содержимое));
	Ответ = Соединение.ВызватьHTTPМетод("POST",HTTPЗапрос);
	HTTPЗапрос.ПолучитьТелоКакСтроку();
	Ответ.ПолучитьТелоКакСтроку();
	Если Ответ.КодСостояния = 200 Тогда
		ЧтениеJSON = Новый ЧтениеJSON;
		ЧтениеJSON.УстановитьСтроку(Ответ.ПолучитьТелоКакСтроку());
		ДанныеJSON = ПрочитатьJSON(ЧтениеJSON);
		ЧтениеJSON.Закрыть();
		//
		МенеджерЗаписиСообщение = РегистрыСведений.GigaChat_Сообщения.СоздатьМенеджерЗаписи();
		МенеджерЗаписиСообщение.Период = ТекущаяДата();
		МенеджерЗаписиСообщение.ИдентификаторДиалога = ИдентификаторДиалога;
		МенеджерЗаписиСообщение.ИдентификаторСообщения = Новый УникальныйИдентификатор;
		МенеджерЗаписиСообщение.Содержимое = ДанныеJSON.choices[0].message.content;
		МенеджерЗаписиСообщение.Записать();
		//
		Возврат МенеджерЗаписиСообщение.ИдентификаторСообщения;
	Иначе
		//
	КонецЕсли;
	//TODO: Запись в лог результат
КонецФункции
//
Функция УдалитьСообщение(ИдентификаторДиалога = Неопределено, ИдентификаторСообщения = Неопределено, ОтПользователя = Неопределено) Экспорт
	НаборЗаписейСообщения = РегистрыСведений.GigaChat_Сообщения.СоздатьНаборЗаписей();
	НаборЗаписейСообщения.Отбор.ИдентификаторСообщения.Установить(ИдентификаторСообщения);
	НаборЗаписейСообщения.Отбор.ИдентификаторДиалога.Установить(ИдентификаторДиалога);
	НаборЗаписейСообщения.Отбор.ОтПользователя.Установить(ОтПользователя);
	НаборЗаписейСообщения.Записать();
КонецФункции

#КонецОбласти

#КонецОбласти

//https://www.youtube.com/watch?v=QrV_zhnKz6A&list=PL9PLUrw0CbcSPQtPDruzw2NXjqQcSCZ91&index=2
//https://www.youtube.com/watch?v=fSZvkr21dqk&list=PL9PLUrw0CbcSPQtPDruzw2NXjqQcSCZ91&index=6