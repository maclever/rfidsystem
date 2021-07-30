-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 25-Jul-2021 às 18:32
-- Versão do servidor: 10.4.19-MariaDB
-- versão do PHP: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ispb_sistemarfid`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `name` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(20) NOT NULL,
  `timetable` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  `entrance` int(11) NOT NULL,
  `card_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cards`
--

CREATE TABLE `cards` (
  `id` int(11) NOT NULL,
  `card_id` varchar(20) NOT NULL,
  `name` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  `new` int(11) NOT NULL,
  `block` int(11) NOT NULL,
  `date` date NOT NULL,
  `comment` varchar(33) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `cards`
--

INSERT INTO `cards` (`id`, `card_id`, `name`, `active`, `new`, `block`, `date`, `comment`) VALUES
(15, '69ACF697', 0, 0, 1, 0, '2021-07-25', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `Numero` varchar(24) NOT NULL,
  `name` varchar(24) NOT NULL,
  `date` date NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `employee`
--

INSERT INTO `employee` (`id`, `Numero`, `name`, `date`, `telephone`, `email`) VALUES
(1, '161010011', 'Herman Figueiredo', '1997-09-21', '998642326', 'herman.figueiredo@ltiangola.com');

-- --------------------------------------------------------

--
-- Estrutura da tabela `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `parent` int(11) NOT NULL,
  `link` varchar(30) NOT NULL,
  `icon` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `menu`
--

INSERT INTO `menu` (`id`, `name`, `parent`, `link`, `icon`) VALUES
(1, 'Acessos', 1, 'ea/index.php', ''),
(2, 'Cartões', 1, 'ea/cards.php', ''),
(3, 'Utentes', 2, 'hr/index.php', ''),
(4, 'Modulos', 0, '', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `module`
--

CREATE TABLE `module` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `link` varchar(20) NOT NULL,
  `active` int(11) NOT NULL,
  `sequence` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `module`
--

INSERT INTO `module` (`id`, `name`, `link`, `active`, `sequence`) VALUES
(1, 'ACESSOS', 'ea', 1, 1),
(2, 'REGISTRO DE UTENTES', 'hr', 1, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `new_cards`
--

CREATE TABLE `new_cards` (
  `id` int(11) NOT NULL,
  `card_id` varchar(20) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `new_cards`
--

INSERT INTO `new_cards` (`id`, `card_id`, `status`) VALUES
(1, '', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `acitve` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `acitve`) VALUES
(1, 'hermanfigueiredo', 'ispbenguela', 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `new_cards`
--
ALTER TABLE `new_cards`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT de tabela `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `module`
--
ALTER TABLE `module`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `new_cards`
--
ALTER TABLE `new_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
