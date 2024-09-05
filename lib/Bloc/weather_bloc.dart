import 'package:app/Dio/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../services/api_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiService apiService;

  WeatherBloc(this.apiService) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final weatherData = await apiService.getWeather(event.city);
        yield WeatherLoaded(weatherData);
      } catch (e) {
        yield WeatherError(e.toString());
      }
    }
  }
}
