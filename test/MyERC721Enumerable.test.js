const MyERC721Enumerable = artifacts.require('MyERC721Enumerable');


let deployer, addr1, addr2, addr3, myERC721Enumerable
contract('ERC721Enumerable', async payloadAccounts =>  {
	beforeEach(async() => {
		deployer = payloadAccounts[0]
		addr1 = payloadAccounts[1]
		addr2 = payloadAccounts[2]
		addr3 = payloadAccounts[3]
		
		myERC721Enumerable = await MyERC721Enumerable.new('Alpha', 'ALPH')
	})

	const mintUsingAccounts = async () => {
		for(i=0; i<4; i++) {
			await myERC721Enumerable.mintToken({from: payloadAccounts[i]})
		}
	}    
    
	contract('ERC721 Spec', async () => {
		it('Returns total supply', async() => {
			console.log({addr1})
			await mintUsingAccounts()
			console.log('enumerable contract', myERC721Enumerable.address)
			const tokenSupply = await myERC721Enumerable.getTotalTokenSupply.call()
			console.log('total supply', tokenSupply.toNumber())
			assert.equal(tokenSupply.toNumber(), 4, 'not minted')
		})

		it('Returns token balance of each account', async() => { 
			await mintUsingAccounts()
			const tokenBalanceAddr1 = await myERC721Enumerable.balanceOf(deployer)
			const tokenBalanceAddr2 = await myERC721Enumerable.balanceOf(addr1)
			const errorMsg = 'account mint error'
			assert.equal(tokenBalanceAddr1.toNumber(), 1, errorMsg )
			assert.equal(tokenBalanceAddr2.toNumber(), 1, errorMsg)

		})
	})

})