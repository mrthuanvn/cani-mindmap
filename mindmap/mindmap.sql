-- phpMyAdmin SQL Dump
-- version 2.7.0-pl1
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Czas wygenerowania: 21 Lut 2007, 00:06
-- Wersja serwera: 5.0.18
-- Wersja PHP: 5.1.1
-- 
-- Baza danych: `mindmap`
-- 

-- --------------------------------------------------------

-- 
-- Struktura tabeli dla  `mindmap_users`
-- 

CREATE TABLE `mindmap_users` (
  `mindmapId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `rights` int(11) NOT NULL,
  KEY `mindmapId` (`mindmapId`,`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

-- --------------------------------------------------------

-- 
-- Struktura tabeli dla  `mindmaps`
-- 

CREATE TABLE `mindmaps` (
  `id` int(11) NOT NULL auto_increment,
  `name` tinytext collate utf8_polish_ci NOT NULL,
  `ownerId` int(11) NOT NULL,
  `requiresPassword` binary(1) NOT NULL,
  `password` tinytext collate utf8_polish_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Struktura tabeli dla  `users`
-- 

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `email` tinytext collate utf8_polish_ci NOT NULL,
  `password` tinytext collate utf8_polish_ci NOT NULL,
  `forname` tinytext collate utf8_polish_ci NOT NULL,
  `surname` tinytext collate utf8_polish_ci NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `activationKey` tinytext collate utf8_polish_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=19 ;
