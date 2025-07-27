import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';


/// SHA256
String duSHA256(String input) {
  String salt = 'EIpWsyfiy@R@X#qn17!StJNdZK1fFF8iV6ffN!goZkqt#JxO'; // 加盐
  var bytes = utf8.encode(input + salt);
  var digest = sha256.convert(bytes);

  return digest.toString();
}

String rsaEncrypt(String publicKey, String plainText) {
    try {
      final rsaPublicKey = encrypt.RSAKeyParser().parse(publicKey) as RSAPublicKey;
      final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: rsaPublicKey));
      final encrypted = encrypter.encrypt(plainText);
      return encrypted.base64;
    } catch (e) {
      print('RSA加密失败: $e');
      return '';
    }
  }