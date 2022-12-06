import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'WeatherModel.dart';
import 'WeatherRepo.dart';


@immutable
abstract class WeatherEvent{
}

class FetchWeather extends WeatherEvent{
  final _city;
  FetchWeather(this._city);
  List<Object> get props => [_city];
}

class ResetWeather extends WeatherEvent{

}

@immutable
abstract class WeatherState {

}


class WeatherIsNotSearched extends WeatherState{
}

class WeatherIsLoading extends WeatherState{
}

class WeatherIsLoaded extends WeatherState{
  final _weather;
  WeatherIsLoaded(this._weather);
  WeatherModel get getWeather => _weather;
  List<Object> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState{
  final String message;
  WeatherIsNotLoaded(this.message);
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
 late WeatherRepo weatherRepo;
  WeatherBloc(this.weatherRepo) : super(WeatherIsNotSearched());
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherIsLoading();
      try{
        WeatherModel weather = await weatherRepo.getWeather(event._city);
        yield WeatherIsLoaded(weather);
      }catch(e){
        yield WeatherIsNotLoaded("NO INTERNET Connection");
      }
    }else if(event is ResetWeather){
      yield WeatherIsNotSearched();
    }
  }
}
