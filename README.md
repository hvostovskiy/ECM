# Тестовое задание

### Задание 1.

1. Необходимо восстановить тестовую БД test из файла полной резервной копии test.bak.

2. В тестовой БД существует таблица Users со списком пользователей. Необходимо в эту таблицу загрузить пользователей, которые есть в Excel-файле users.xlsx, но отсутствуют в таблице БД. Синхронизация записей должна производиться по полю Login. Следует учесть, что данная операция является разовой и создание утилит для пользователей не требуется.

3. Добавить в тестовую БД структуру таблиц, необходимую для ведения списка подразделений и сотрудников (таблица Users), входящих в них. Для подразделений необходимо хранить:
                * Наименование подразделения
                * Буквенный код подразделения
Необходимо учесть иерархичность подразделений, т.е. одно подразделение может быть родительским для нескольких других подразделений.

Результатом выполнения задания является резервная копия БД с дозагруженными пользователями и наличием новых таблиц. Необходимо также кратко описать шаги для выполнения п. 2 настоящего задания.

### Задание 2.

Предположим, что некая информационная система ведет журнал работы в текстовом файле c:\log.txt. Задача состоит в том, чтобы настроить еженочное резервное копирование данного журнала в папку D:\Backup, причем хранить копии файла необходимо 7 дней. Файлы старше 7 дней должны удаляться или заменяться в папке D:\Backup.

Результатом выполнения задания является сценарий, который выполняет резервное копирование и инструкция по его настройке. Язык сценария (bat, PS) вы можете выбрать самостоятельно. Текст сценария необходимо отправить в текстовом файле с расширением .txt!

### Задание 3.

Необходимо написать регулярное выражение, которое из текстового файла определяет номер платежного поручения. Текст файла:

Поступ. в банк плат.
01.01.2017
Списано со сч. плат.
01.01.2017
0401060
Дата
01.01.2017 электронно
Вид платежа
ПЛАТЕЖНОЕ ПОРУЧЕНИЕ № 14343
Сумма
прописью
Двести тысяч рублей 00 копеек
0000000000
Акционерное общество "Авиакомпания"
Сч. №
Сумма 200000=
00000000000000000000
ИНН КПП 000000000
ПАО РОСБАНК БИК 000000000
Плательщик
Г. МОСКВА Сч. № 00000000000000000000
Банк Плательщика
СИБИРСКИЙ БАНК ПАО СБЕРБАНК Г. НОВОСИБИРСК 000000000 БИК
Сч. № 00000000000000000000
Банк Получателя
Получатель
ИНН 0000000000
АО "Аэропорт"
Сч. №
Вид оп.
Наз. пл.
Код
00000000000000000000
01
5 Очер. плат.
Рез. поле
000000000 КПП
Срок плат.
Назначение платежа
Предоплата за ____________ за период по __-__-2017 по договору № 00/0-00/2014 от 31.01.2014. Сумма 200000-00 руб.
Без налога (НДС).
Подписи Отметки Банка
М.П.
СИБИРСКИЙ БАНК СБЕРБАНКА РФ
Новосибирское отделение № 0000 ПАО
"Сбербанк России"
УДО №0000/0000
БИК000000000
ПРОВЕДЕНО
00.00.2017

Для отладки регулярного выражения можно использовать онлайн-сервис: https://regex101.com/
