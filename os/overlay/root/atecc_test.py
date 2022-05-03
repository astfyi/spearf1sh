from cryptoauthlib import *
cfg = cfg_ateccx08a_i2c_default()
cfg.cfg.atcai2c.bus = 0
cfg.cfg.atcai2c.baud = 100000
atcab_init(cfg)
randombytes = bytearray(32)
atcab_random(randombytes)
print(randombytes.hex())



key_id = 0
msg = bytearray(32)
signature = bytearray(64)
assert atcab_sign(key_id, msg, signature) == Status.ATCA_SUCCESS
calib/calib_sign.c:73:f4:calib_sign_base - execution failed
calib/calib_sign.c:142:f4:calib_sign_base - failed
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AssertionError

public_key = bytearray(64)
assert atcab_genkey(key_id, public_key) == Status.ATCA_SUCCESS

print(public_key.hex())
fa85eb1b89b7b11b49f318ce534cbf6fb49c378e14da4c31ff6364a1267ba440a2f9908b307d5b4b13e58cf9d6c01ce54525c9d88c9a4961928a861af0b23be6

assert atcab_sign(key_id, msg, signature) == Status.ATCA_SUCCESS
is_verified = AtcaReference(2)
assert atcab_verify_extern(msg, signature, public_key, is_verified) == Statu
s.ATCA_SUCCESS
is_verified
<cryptoauthlib.library.AtcaReference object at 0xb69bb118>
is_verified.value
1
from ecdsa import SigningKey
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ModuleNotFoundError: No module named 'ecdsa'
from hashlib import sha256
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import ec
private_key = ec.generate_private_key(
...     ec.SECP256R1())
>>>
