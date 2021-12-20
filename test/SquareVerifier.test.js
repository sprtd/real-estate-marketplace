const SquareVerifier = artifacts.require('Verifier')
const truffleAssert = require('truffle-assertions')
const squareProof = require('../zokrates/code/square/proof.json')
const { proof: {a, b, c }, inputs } = squareProof



let squareVerifier

contract('Square Verifier', async payloadAccounts =>  {
	beforeEach(async() => {
		squareVerifier = await SquareVerifier.new()
	})
  
	contract('Verification', async () => {
		it('Passes verification with correct proof', async() => {
      const verificationResult = await squareVerifier.verifyTx(a, b, c, inputs)
			truffleAssert.eventEmitted(verificationResult, 'Verified', (ev) => {
        console.log({ev})
				return ev.s === 'Transaction successfully verified.'
      })
		})
		

		it('Fails verification with incorrect proof', async() => {
      const vagueInputs = ["0x1", "0xe"]
      const verificationResult = await squareVerifier.verifyTx(a, b, c, vagueInputs)
			truffleAssert.eventEmitted(verificationResult, 'UnVerified', (ev) => {
        console.log({ev})
				return ev.s === 'Transaction not verified.'
      })
		})
	})

})