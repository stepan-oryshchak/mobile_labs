import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String _broker = 'broker.hivemq.com';
  final int _port = 1883;
  final String _topic = 'devices/control';
  final String _clientId =
      'smart_home_app_${DateTime.now().millisecondsSinceEpoch}';

  late MqttServerClient _client;
  var logger = Logger();

  MqttService() {
    _client = MqttServerClient(_broker, _clientId);
    _client.port = _port;
    _client.logging(on: false);
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = _onDisconnected;
    _client.onConnected = _onConnected;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(_clientId)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    _client.connectionMessage = connMessage;
  }

  Future<void> connect() async {
    try {
      await _client.connect();
      if (_client.connectionStatus!.state == MqttConnectionState.connected) {
        logger.i('✅ Connected to MQTT Broker');
        _client.subscribe(_topic, MqttQos.atMostOnce);
      } else {
        logger.e('❌ Connection failed: ${_client.connectionStatus}');
        _client.disconnect();
      }
    } catch (e) {
      logger.e('🐛 Exception during connection: $e');
      _client.disconnect();
    }
  }

  void _onConnected() {
    logger.i('🔌 MQTT Connected');
  }

  void _onDisconnected() {
    logger.w('🔌 MQTT Disconnected');
  }

  void listenToMessages(Function(Map<String, bool>) onMessage) {
    _client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final message = event[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      logger.i('📥 New message: $payload');

      try {
        final data = jsonDecode(payload) as Map<String, dynamic>;
        final devices = data.map((key, value) => MapEntry(key, value as bool));
        onMessage(devices);
      } catch (e) {
        logger.e('❗ Error decoding payload: $e');
      }
    });
  }

  void disconnect() {
    _client.disconnect();
    logger.w('🔌 Disconnected manually');
  }
}
