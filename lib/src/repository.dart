library repository;

import 'dart:async';

import "package:redis_client/redis_client.dart";

abstract class Repository
{
  Future setValue(String key, String value);
  Future<String> getValue(String key);
}

class RedisRepository implements Repository {
  String connectionString;

  RedisRepository(this.connectionString);

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