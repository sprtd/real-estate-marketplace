const SquareVerifier = artifacts.require('Verifier')
const squareProof = require('../zokrates/code/square/proof.json')
const { proof, inputs } = squareProof

let squareVerifier

contract('Square Verifier', async payloadAccounts =>  {
	beforeEach(async() => {
		squareVerifier = await SquareVerifier.new()
	})
  
	contract('Verification', async () => {
		it('Passes verification with correct proof', async() => {
      const result = await squareVerifier.verifyTx(proof, inputs)
      console.log('this is the result', result)
      assert.equal(result, true, 'verification failed')
		})

		it('Fails verification with incorrect proof', async() => {
      const vagueInputs = ["0x1", "0xe"]
      const result = await squareVerifier.verifyTx(proof, vagueInputs)
      console.log('this is the result', result)
      assert.equal(result, false, 'verification passed')
		})
	})

})