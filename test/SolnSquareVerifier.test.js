const SolnSquareVerifier = artifacts.require('SolnSquareVerifier')
const SquareVerifier = artifacts.require('Verifier')

const squareProof = require('../zokrates/code/square/proof.json')
const { proof: {a, b, c }, inputs } = squareProof



let squareVerifier, solnSquareVerifier, deployer

contract('Square Solution Verifier', async payloadAccounts =>  {
	beforeEach(async() => {
    deployer = payloadAccounts[0]
		squareVerifier = await SquareVerifier.new()
		solnSquareVerifier = await SolnSquareVerifier.new(squareVerifier.address)

    // console.log('soln square verifier', solnSquareVerifier)

	})

  const mintUsingAccount = async (mintNum) => {
		for(i=0; i< mintNum; i++) {
			await solnSquareVerifier.mintNFT(a, b, c, inputs, {from: deployer})
		}
	}  
  
	contract('Solution Verification', async () => {
		it('Adds solution based on correct proof entry', async() => {
      // const tokenId = 
      const tokenSupply = await solnSquareVerifier.getTotalTokenSupply.call()
      await solnSquareVerifier.addSolution(a, b, c, inputs, { from: deployer })
      const solutionDetails = await solnSquareVerifier.getSolutionDetails(tokenSupply)
      console.log('solution details', solutionDetails)

      const { minter, status }  = solutionDetails
      assert.equal(minter, deployer)
      assert.equal(status, 'Verified')
			
		})
		

		it('Mints NFT following successful solution verification with incorrect proof', async() => {
      await mintUsingAccount(10)
      const tokenSupply = await solnSquareVerifier.getTotalTokenSupply.call()
			console.log('total supply', tokenSupply.toNumber())
      const solutionDetails = await solnSquareVerifier.getSolutionDetails(1)
      console.log('solution details', solutionDetails)

      const { minter, status }  = solutionDetails
			assert.equal(tokenSupply.toNumber(), 10, 'not minted')
      assert.equal(minter, deployer)
      assert.equal(status, 'Minted')
		})
	})

})