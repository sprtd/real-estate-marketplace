
const RealEstateToken = artifacts.require('RealEstateToken.sol')


module.exports = (async (deployer, network, accounts) => {
    try {
        
        await deployer.deploy(RealEstateToken)
        const realEstateToken = await RealEstateToken.deployed()
        console.log('contract here', realEstateToken.address)
        console.log('accounts', accounts)

        
	    await realEstateToken.mintToken({from: accounts[0]})
        const resultTokenURI = await realEstateToken.getTokenURI(0)
        console.log('token uri', resultTokenURI)

        const newOwner = await realEstateToken.ownerOf(0)
        console.log({newOwner})
    } catch(err) {
        console.log('migration error', err)
    }

})