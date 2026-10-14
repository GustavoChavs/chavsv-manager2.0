"""Compatibility checks for the unchanged upstream password encryption."""
import base64
import importlib.util
from pathlib import Path
import unittest
spec = importlib.util.spec_from_file_location('encryption', Path(__file__).parents[1] / 'backend/classes/encryption.py')
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

class EncryptionCompatibility(unittest.TestCase):
    def test_round_trip_with_portable_salt_and_password_spaces(self):
        enc = module.PasswordEncryption('  Senha-mestra-ç-2026  ')
        data = {'conta': 'apenas-exemplo', 'nota': 'Ação'}
        ciphertext = enc.encrypt_data(data)
        restored = module.PasswordEncryption('  Senha-mestra-ç-2026  ', enc.get_salt_b64())
        self.assertEqual(restored.decrypt_data(ciphertext), data)
        with self.assertRaises(Exception):
            module.PasswordEncryption('Senha-mestra-ç-2026', enc.get_salt_b64()).decrypt_data(ciphertext)

    def test_ciphertext_tampering_is_rejected(self):
        enc = module.PasswordEncryption('Senha-teste-2026')
        data = enc.encrypt_data({'test': True})
        raw = bytearray(base64.b64decode(data['ciphertext']))
        raw[0] ^= 1
        data['ciphertext'] = base64.b64encode(raw).decode()
        with self.assertRaises(Exception):
            enc.decrypt_data(data)

    def test_nonce_is_unique(self):
        enc = module.PasswordEncryption('Senha-teste-2026')
        a, b = enc.encrypt_data('mesmo texto'), enc.encrypt_data('mesmo texto')
        self.assertNotEqual(a['nonce'], b['nonce'])
        self.assertNotEqual(a['ciphertext'], b['ciphertext'])

if __name__ == '__main__':
    unittest.main()
