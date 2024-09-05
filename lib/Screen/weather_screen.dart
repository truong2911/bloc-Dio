import 'package:app/Bloc/weather_bloc.dart';
import 'package:app/Bloc/weather_state.dart';
import 'package:app/Dio/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/weather_event.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: BlocProvider(
        create: (context) => WeatherBloc(ApiService()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Enter city',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final city = _cityController.text;
                  context.read<WeatherBloc>().add(FetchWeather(city));
                },
                child: Text('Get Weather'),
              ),
              SizedBox(height: 20),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return CircularProgressIndicator();
                  } else if (state is WeatherLoaded) {
                    final weather = state.weather;
                    return Text(
                        'Weather in ${weather['name']}: ${weather['weather'][0]['description']}');
                  } else if (state is WeatherError) {
                    return Text('Error: ${state.message}');
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
