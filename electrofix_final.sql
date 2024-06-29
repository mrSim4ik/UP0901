-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июн 28 2024 г., 04:14
-- Версия сервера: 8.0.30
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `electrofix_final`
--

-- --------------------------------------------------------

--
-- Структура таблицы `device_type`
--

CREATE TABLE `device_type` (
  `ID_Device_type` int NOT NULL,
  `type_device` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `device_type`
--

INSERT INTO `device_type` (`ID_Device_type`, `type_device`) VALUES
(1, 'Телефон'),
(2, 'Ноутбук'),
(3, 'Планшет'),
(4, 'Бытовая техника'),
(5, 'Телевизор'),
(6, 'Ноутбук'),
(11, 'Смартфон'),
(13, 'Макбук');

-- --------------------------------------------------------

--
-- Структура таблицы `engineers`
--

CREATE TABLE `engineers` (
  `ID_Engineer` int NOT NULL,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `surname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `engineers`
--

INSERT INTO `engineers` (`ID_Engineer`, `name`, `surname`) VALUES
(1, 'Михаил', 'Игорев'),
(3, 'Дмитрий', 'Шпеков');

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `ID_Order` int NOT NULL,
  `ID_Status_repair` int NOT NULL,
  `ID_Engineer` int DEFAULT NULL,
  `ID_User` int NOT NULL,
  `ID_Device_type` int NOT NULL,
  `start_date` date NOT NULL,
  `completion_date` date DEFAULT NULL,
  `component` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `warranty` date DEFAULT NULL,
  `manufacturer` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`ID_Order`, `ID_Status_repair`, `ID_Engineer`, `ID_User`, `ID_Device_type`, `start_date`, `completion_date`, `component`, `warranty`, `manufacturer`, `model`) VALUES
(13, 2, 1, 97, 1, '2024-06-22', '2024-06-29', 'Матрица', '2024-06-30', 'Samsung', 'galaxy'),
(14, 2, NULL, 98, 2, '2024-06-23', NULL, 'Клавиатура', NULL, 'MSI', 'A21O21');

-- --------------------------------------------------------

--
-- Структура таблицы `status_repair`
--

CREATE TABLE `status_repair` (
  `ID_Status_repair` int NOT NULL,
  `status_repair` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `status_repair`
--

INSERT INTO `status_repair` (`ID_Status_repair`, `status_repair`) VALUES
(1, 'Готов'),
(2, 'В работе'),
(3, 'Отменен');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `ID_User` int NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `surname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `isAdmin` int NOT NULL,
  `hash` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email_confirmed` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`ID_User`, `email`, `name`, `surname`, `password`, `isAdmin`, `hash`, `email_confirmed`) VALUES
(97, 'isip_d.a.alekseev@mpt.ru', 'Дмитрий', 'Алексеев', '351dae3e98d39e9437729b56a7feaf67', 1, 'e9db171a86294ee2059fcca586c0db7f', 1),
(98, 'dimon23361@gmail.com', 'Игорь', 'Алексеев', '351dae3e98d39e9437729b56a7feaf67', 0, '2ea0bd6864ac3b9d6821b3ecfd0e2844', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `users_2`
--

CREATE TABLE `users_2` (
  `ID_User_2` int NOT NULL,
  `telephone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status_call` tinyint(1) NOT NULL,
  `curr_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users_2`
--

INSERT INTO `users_2` (`ID_User_2`, `telephone`, `name`, `status_call`, `curr_datetime`) VALUES
(29, '+7(999)999-99-99', 'сергей', 0, NULL),
(30, '+7(900)999-99-99', 'Рома', 0, NULL),
(33, '+7(999)999-99-99', 'Маша', 0, NULL);

--
-- Триггеры `users_2`
--
DELIMITER $$
CREATE TRIGGER `set_curr_datetime` BEFORE INSERT ON `users_2` FOR EACH ROW BEGIN
    IF NEW.status_call = 1 THEN
        SET NEW.curr_datetime = CURRENT_TIMESTAMP;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_curr_datetime` BEFORE UPDATE ON `users_2` FOR EACH ROW BEGIN
    IF NEW.status_call = 1 THEN
        SET NEW.curr_datetime = CURRENT_TIMESTAMP;
    END IF;
END
$$
DELIMITER ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `device_type`
--
ALTER TABLE `device_type`
  ADD PRIMARY KEY (`ID_Device_type`);

--
-- Индексы таблицы `engineers`
--
ALTER TABLE `engineers`
  ADD PRIMARY KEY (`ID_Engineer`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ID_Order`),
  ADD KEY `orders_ibfk_1` (`ID_Device_type`),
  ADD KEY `orders_ibfk_2` (`ID_Engineer`),
  ADD KEY `orders_ibfk_3` (`ID_Status_repair`),
  ADD KEY `orders_ibfk_4` (`ID_User`);

--
-- Индексы таблицы `status_repair`
--
ALTER TABLE `status_repair`
  ADD PRIMARY KEY (`ID_Status_repair`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID_User`);

--
-- Индексы таблицы `users_2`
--
ALTER TABLE `users_2`
  ADD PRIMARY KEY (`ID_User_2`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `device_type`
--
ALTER TABLE `device_type`
  MODIFY `ID_Device_type` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `engineers`
--
ALTER TABLE `engineers`
  MODIFY `ID_Engineer` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `ID_Order` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `status_repair`
--
ALTER TABLE `status_repair`
  MODIFY `ID_Status_repair` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `ID_User` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT для таблицы `users_2`
--
ALTER TABLE `users_2`
  MODIFY `ID_User_2` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`ID_Device_type`) REFERENCES `device_type` (`ID_Device_type`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`ID_Engineer`) REFERENCES `engineers` (`ID_Engineer`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`ID_Status_repair`) REFERENCES `status_repair` (`ID_Status_repair`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`ID_User`) REFERENCES `users` (`ID_User`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
