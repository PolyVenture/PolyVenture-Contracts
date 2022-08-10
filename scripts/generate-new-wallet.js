
var Wallet = require('ethereumjs-wallet');

var addressData = Wallet['default'].generate();

console.log(addressData)
console.log("address: " + addressData.getAddressString());
console.log("privateKey: " + addressData.getPrivateKeyString());

