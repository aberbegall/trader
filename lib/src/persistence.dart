library persistence;

import 'dart:async';
import "package:redis_client/redis_client.dart";

abstract class Persistence
{
  Future setValue(String key, String value);
  Future<String> getValue(String key);
}

class RedisPersistence implements Persistence {
  String connectionString;

  RedisPersistence(this.connectionString);

  Future setValue(String key, String value) {
    return RedisClient
        .connect(this.connectionString)
        .then((RedisClient client) => client.set(key, value));
  }

  Future<String> getValue(String key) {
    return RedisClient
        .connect(this.connectionString)
        .then((RedisClient client) => client.get(key));
  }
}