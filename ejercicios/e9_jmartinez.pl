#!/bin/perl

$diccionario = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
$path = "";

foreach $char (split('', $diccionario)) {
    $path = "$path$char/";
    $file = "$path$char.txt";
    mkdir("$path", 0755);
    system("touch $file");
}