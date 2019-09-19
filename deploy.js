// require('dotenv').load();
const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider (

  'romance fashion little pull fashion digital network true leave kangaroo frog fiber',
  'https://rinkeby.infura.io/v3/70c931b94f584415b5ec6a6cec0c4def'
);

const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log('Attempting to deploy from account' + accounts[0]);
  const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({ data: bytecode })
    .send({ gas: '1000000', from: accounts[0] });
console.log(interface);
console.log('Contract deployed to', result.options.address);
};
deploy();
