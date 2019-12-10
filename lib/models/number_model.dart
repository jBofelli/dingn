import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Number extends Equatable{
  const Number(this.number, this.words, this.mostFavoriteWord, this.mostFavoriteCount, this.myFavoriteWord);

  final List<String> words;
  final String number;
  final String mostFavoriteWord;
  final String myFavoriteWord;
  String get favoriteWord => myFavoriteWord ?? mostFavoriteWord;
  final int mostFavoriteCount;

  Number setMyFavoriteWord(String favorite){
    return Number(number, words, mostFavoriteWord, mostFavoriteCount, favorite);
  }

  Number setMostFavoriteWord(String mostFavoriteWord, int mostFavoriteCount){
    return Number(number, words, mostFavoriteWord, mostFavoriteCount, myFavoriteWord);
  }

  @override
  List<Object> get props => [number];
}
