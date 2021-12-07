const RealEstateToken = artifacts.require('RealEstateToken');


let deployer, addr1, addr2, addr3, realEstateToken
const tokenURI = 'https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/0'
contract('Real Estate Token', async payloadAccounts =>  {
	beforeEach(async() => {
		deployer = payloadAccounts[0]
		addr1 = payloadAccounts[1]
		addr2 = payloadAccounts[2]
		addr3 = payloadAccounts[3]

		realEstateToken = await RealEstateToken.new()
	})

	const mintUsingAccount = async (mintNum) => {
		for(i=0; i< mintNum; i++) {
			await realEstateToken.mintToken({from: deployer})
		}
	}    
    
	contract('ERC721 Spec', async () => {
		it('Reverts non-owner attempt to mint token', async() => {
			console.log({addr1})
			
			const REVERT  = 'Returned error: VM Exception while processing transaction: revert caller not owner'
      try {
				await realEstateToken.mint({from: addr1})
        throw null
      } catch(err) {
        assert(err.message.startsWith(REVERT), `Expected ${REVERT} but got ${err.message} instead`) 
      } 
		})

		it('Returns total supply', async() => {
			console.log('real estate contract', realEstateToken.address)

			await mintUsingAccount(4)

			const tokenSupply = await realEstateToken.getTotalTokenSupply.call()
			console.log('total supply', tokenSupply.toNumber())
			assert.equal(tokenSupply.toNumber(), 4, 'not minted')
		})

		it('Returns token URI', async() => { 
			await mintUsingAccount(3)


			const tokenURIResult = await realEstateToken.getTokenURI(0)
			const newOwner = await realEstateToken.ownerOf(0)
			console.log({newOwner})
			console.log('uri here:', tokenURIResult)
			const errorMsg = 'no token URI'
			assert.equal(tokenURI, tokenURIResult, errorMsg )

		})

		it('Returns contract owner', async() => { 
			
			const owner = await realEstateToken.getOwner()
			const errorMsg = 'no owner'
			assert.equal(owner, deployer, errorMsg )

		})

		it('Returns token balance of minter account', async() => { 
			await mintUsingAccount(5)
			const tokenBalanceAddr1 = await realEstateToken.balanceOf(deployer)
			const errorMsg = 'account mint error'
			assert.equal(tokenBalanceAddr1.toNumber(), 5, errorMsg )
		})

		it('Transfers token from one address to another', async () => {
			await mintUsingAccount(1)
			await realEstateToken.safeTransferFrom(deployer, addr3, 0, {from: deployer})
			const owner = await realEstateToken.ownerOf.call(0)
			console.log({owner})
			assert.equal(owner, addr3)
		})
	})

})