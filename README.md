
# Description

> In this project, ERC-721 tokenized representation of  title properties were minted. Prior to minting, property ownership is verfied using zokrates, a zkSNARKS framework to prove property title ownership without revealing that details about the property being vetted. Following token verification, it was listed on OpenSea marketplace.


## Token

Name: RealEstateToken<br>
Symbol: RET<br>
Token Address: [0x84739ed0ac39bf8b865ccef724ef11c08ae6dff7](https://rinkeby.etherscan.io/tx/0x27543d239dc1a97d001a829dd878eab4cea6fab3787a300162925f83a59d9cbd)




## OpenSea 

[Token Owner](https://rinkeby.opensea.io/accounts/0xd6bedbc5eb7ee960a35d07c4b0e08dc1482ace6c)<br>
Purchase Transaction: [0x66494174d5bc260e57fa3def06d57fb9a96d9b3b694d29f1ff5f2bb4c6184fec](https://rinkeby.etherscan.io/tx/0x66494174d5bc260e57fa3def06d57fb9a96d9b3b694d29f1ff5f2bb4c6184fec)

[OpenSea Store Front Link](https://testnets.opensea.io/collection/realestatetoken-8lu6ddtaho)


## Contracts

[Verifier Contract Address](https://rinkeby.etherscan.io/tx/0x459e4b05e815cdfa7b46eba24d0528e640a0003ba3d7484b864a883aeb91cb08)<br>
[RealEstateToken Contract Address](https://rinkeby.etherscan.io/token/0x84739ED0ac39bF8b865CCef724Ef11c08ae6Dff7)


## Testing

######  To proceed to test, install necessary dependencies (esp. @openzeppelin/contracts@4.4.1 and truffle-assertions@0.9.2, an assertion library for testing emitted events):
- [x] Run `npm install`

######  To test Zokrates-generated SquareVerifier contract:
- [x] Run `truffle test './test/SquareVerifier.test.js' --network dev`

######  To test SolnSquareVerifier contract:
- [x] Run `truffle test './test/SolnSquareVerifier.test.js' --network dev`




## ABIs

Path to contract ABIs - `/build/contracts`


## Environment


```bash
Truffle v5.4.22 (core: 5.4.22)
Solidity - >=0.5.0 <0.9.0 (solc-js)
Node v16.13.1
Web3.js v1.5.3
```

