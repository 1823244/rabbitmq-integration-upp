﻿
&НаСервере
Процедура ВыгрузитьЛюбойДокументНаФормуНаСервере()
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьЛюбойДокументНаФорму(Команда)
	ВыгрузитьЛюбойДокументНаФормуНаСервере();
	json = ксп_ИнтеграцияЕРП.ВыгрузитьДокументПоСсылке(ВыбДокЛюбой);
	тДок = Новый ТекстовыйДокумент;
	тДок.УстановитьТекст(json);
	тДок.Показать(ВыбДокЛюбой);
	
КонецПроцедуры

&НаСервере
Процедура ЛюбойДокументПолучитьПоГУИДуНаСервере()
	ВыбДокЛюбой = Документы["КомплектацияНоменклатуры"].ПолучитьСсылку(
		Новый УникальныйИдентификатор(ВыбДокЛюбойГУИД)
	);
КонецПроцедуры

&НаКлиенте
Процедура ЛюбойДокументПолучитьПоГУИДу(Команда)
	ЛюбойДокументПолучитьПоГУИДуНаСервере();
КонецПроцедуры

//// Универсальный метод, который в будущем переедет в общий модуль
////
//Функция ВыгрузитьДокументПоСсылке(ДанныеСсылка)
//	Если ТипЗнч(ДанныеСсылка) = Тип("ДокументСсылка.КорректировкаЗаписейРегистров") Тогда
//		json = ВыгрузитьКорректировкаЗаписейРегистровПоСсылке(ДанныеСсылка);
//		Возврат json;
//	КонецЕсли;
//	ТипСсылка = Тип(СтрЗаменить(ДанныеСсылка.метаданные().ПолноеИмя(),"Документ.","ДокументСсылка."));
//	Если ТипЗнч(ДанныеСсылка) = ТипСсылка Тогда
//		Обк = ДанныеСсылка.ПолучитьОбъект(); 
//	Иначе 
//		Обк = ДанныеСсылка; 
//	КонецЕсли;
//	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, Символы.Таб);
//	ЗаписьJson = Новый ЗаписьJSON;
//	ЗаписьJson.УстановитьСтроку(ПараметрыЗаписиJSON);
//	// Это основной объект json-сообщения
//	СтруктураОбъекта = Новый Структура;
//	СтруктураОбъекта.Вставить("source", "UPP");
//	СтруктураОбъекта.Вставить("type", Обк.метаданные().ПолноеИмя());
//	СтруктураОбъекта.Вставить("datetime", XMLСтрока(ТекущаяДатаСеанса()));
//	//identification = ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(Обк.Ссылка);
//	identification = ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(Обк.Ссылка);
//	СтруктураОбъекта.Вставить("identification", identification);
//	//	DEFINITION
//	definition = ксп_ИнтеграцияЕРП.СоздатьУзелDefinition(Обк.Ссылка);
//	Для каждого Реквизит Из Обк.метаданные().СтандартныеРеквизиты Цикл
//		РеквизитИмя = Реквизит.Имя;
//		РеквизитЗначение = Обк[РеквизитИмя];
//		Если ТипЗнч(РеквизитЗначение) = Тип("Булево") или ТипЗнч(РеквизитЗначение) = Тип("Строка") или ТипЗнч(РеквизитЗначение) = Тип("Число")
//				или ТипЗнч(РеквизитЗначение) = Тип("Дата") или ТипЗнч(РеквизитЗначение) = Тип("Неопределено") Тогда
//			definition.Вставить(РеквизитИмя, XMLСтрока(РеквизитЗначение));	
//		Иначе		
//			//definition.Вставить(РеквизитИмя, ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(РеквизитЗначение));	
//			definition.Вставить(РеквизитИмя, ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(РеквизитЗначение));	
//		КонецЕсли;	
//	КонецЦикла;
//	Для каждого Реквизит Из Обк.метаданные().Реквизиты Цикл
//		РеквизитИмя = Реквизит.Имя;
//		РеквизитЗначение = Обк[РеквизитИмя];
//		Если ТипЗнч(РеквизитЗначение) = Тип("Булево") или ТипЗнч(РеквизитЗначение) = Тип("Строка") или ТипЗнч(РеквизитЗначение) = Тип("Число")
//				или ТипЗнч(РеквизитЗначение) = Тип("Дата") или ТипЗнч(РеквизитЗначение) = Тип("Неопределено") Тогда
//			definition.Вставить(РеквизитИмя, XMLСтрока(РеквизитЗначение));	
//		Иначе
//			definition.Вставить(РеквизитИмя, ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(РеквизитЗначение));
//		КонецЕсли;	
//	КонецЦикла;
//	
//	Для каждого ИмяТЧ Из Обк.метаданные().ТабличныеЧасти Цикл
//		ТЧ_Документа = Новый Массив;
//		Для каждого стрк из Обк[ИмяТЧ.Имя] Цикл
//			НовСтр = Новый Структура;
//			Для каждого РеквизитТЧ из ИмяТЧ.Реквизиты Цикл
//				РеквизитИмя = РеквизитТЧ.Имя;
//				РеквизитЗначение = стрк[РеквизитТЧ.Имя];
//				Если ТипЗнч(РеквизитЗначение) = Тип("Булево") или ТипЗнч(РеквизитЗначение) = Тип("Строка") или ТипЗнч(РеквизитЗначение) = Тип("Число")
//						или ТипЗнч(РеквизитЗначение) = Тип("Дата") или ТипЗнч(РеквизитЗначение) = Тип("Неопределено") Тогда
//					НовСтр.Вставить(РеквизитИмя,XMLСтрока(РеквизитЗначение));
//				Иначе
//					НовСтр.Вставить(РеквизитИмя,ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(РеквизитЗначение));
//				КонецЕсли;
//			КонецЦикла;
//			ТЧ_Документа.Добавить(НовСтр);
//		КонецЦикла;
//		definition.Вставить("ТЧ"+ИмяТЧ.Имя, ТЧ_Документа);
//	КонецЦикла;
//	
//	//------------------------------------------------------ ФИНАЛ
//	СтруктураОбъекта.Вставить("definition", definition);
//	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
//	json = ЗаписьJson.Закрыть();
//	//сообщить(json);
//	Возврат json;
//КонецФункции

//Функция ВыгрузитьКорректировкаЗаписейРегистровПоСсылке(ДанныеСсылка) Экспорт
//	Если ТипЗнч(ДанныеСсылка) = Тип("ДокументСсылка.КорректировкаЗаписейРегистров") Тогда
//		Обк = ДанныеСсылка.ПолучитьОбъект(); 
//	Иначе 
//		Обк = ДанныеСсылка; 
//	КонецЕсли;
//	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, Символы.Таб);
//	ЗаписьJson = Новый ЗаписьJSON;
//	ЗаписьJson.УстановитьСтроку(ПараметрыЗаписиJSON);
//	// Это основной объект json-сообщения
//	СтруктураОбъекта = Новый Структура;
//	СтруктураОбъекта.Вставить("source", "ERP");
//	СтруктураОбъекта.Вставить("type", Обк.метаданные().ПолноеИмя());
//	СтруктураОбъекта.Вставить("datetime", XMLСтрока(ТекущаяДатаСеанса()));
//	identification = ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(Обк.Ссылка);
//	СтруктураОбъекта.Вставить("identification", identification);
//	//	DEFINITION          
//	definition = ксп_ИнтеграцияЕРП.СоздатьУзелDefinition(Обк.Ссылка);
//	definition.Вставить("Комментарий", Обк.Комментарий);
//	definition.Вставить("Контрагент", ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(Обк.Контрагент));
//	definition.Вставить("Подразделение", ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(Обк.Подразделение));
//	definition.Вставить("Ответственный", ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(Обк.Ответственный));

//	Для каждого ИмяРегистра Из Обк.ТаблицаРегистровНакопления Цикл
//		ТЧРегистра = Новый Массив;
//		ТЗ_Товары = ТаблицаДвиженийДокументаПоРегистру(ДанныеСсылка,ИмяРегистра.Имя);
//		Для каждого стрк из ТЗ_Товары Цикл
//			НовСтр = Новый Структура;
//			Для каждого колонка из ТЗ_Товары.Колонки Цикл
//				Значение = стрк[колонка.Имя];
//				Если ТипЗнч(Значение) = Тип("Булево") или ТипЗнч(Значение) = Тип("Строка") или ТипЗнч(Значение) = Тип("Число") Тогда
//					НовСтр.Вставить(колонка.Имя,Значение);
//				Иначе
//					НовСтр.Вставить(колонка.Имя,ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(Значение));
//				КонецЕсли;
//			КонецЦикла;
//			ТЧРегистра.Добавить(НовСтр);
//		КонецЦикла;
//		definition.Вставить("РегистрНакопления_"+ИмяРегистра.Имя, ТЧРегистра);
//	КонецЦикла;
//	
//	Для каждого ИмяРегистра Из Обк.ТаблицаРегистровСведений Цикл
//		ТЧРегистра = Новый Массив;
//		ТЗ_Товары = ТаблицаДвиженийДокументаПоРегистру(ДанныеСсылка,ИмяРегистра.Имя);
//		Для каждого стрк из ТЗ_Товары Цикл
//			НовСтр = Новый Структура;
//			Для каждого колонка из ТЗ_Товары.Колонки Цикл
//				Значение = стрк[колонка.Имя];
//				Если ТипЗнч(Значение) = Тип("Булево") или ТипЗнч(Значение) = Тип("Строка") или ТипЗнч(Значение) = Тип("Число") или ТипЗнч(Значение) = Тип("Дата") Тогда
//					НовСтр.Вставить(колонка.Имя,Значение);
//				Иначе
//					НовСтр.Вставить(колонка.Имя,ксп_ИнтеграцияЕРП.СоздатьУзелIdentification(Значение));
//				КонецЕсли;
//			КонецЦикла;
//			ТЧРегистра.Добавить(НовСтр);
//		КонецЦикла;
//		definition.Вставить("РегистрСведений_"+ИмяРегистра.Имя, ТЧРегистра);
//	КонецЦикла;
//	
//	//------------------------------------------------------ ФИНАЛ
//	СтруктураОбъекта.Вставить("definition", definition);
//	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
//	json = ЗаписьJson.Закрыть();
//	Возврат json;
//КонецФункции

//Функция ТаблицаДвиженийДокументаПоРегистру(ДанныеСсылка,ИмяРегистра) Экспорт
//	Попытка
//		Зап = ДанныеСсылка.ПолучитьОбъект().Движения[ИмяРегистра];
//		Зап.Прочитать();
//		Возврат Зап.Выгрузить();
//	Исключение
//		Возврат Новый ТаблицаЗначений;
//	КонецПопытки;
//КонецФункции

