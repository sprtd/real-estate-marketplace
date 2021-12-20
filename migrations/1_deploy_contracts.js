
const RealEstateToken = artifacts.require('RealEstateToken')
const SquareVerifier = artifacts.require('Verifier')
const SolnSquareVerifier = artifacts.require('SolnSquareVerifier')


module.exports = (async (deployer, network, accounts) => {
    try {
        
        await deployer.deploy(RealEstateToken)
        const realEstateToken = await RealEstateToken.deployed()
        console.log('contract here', realEstateToken.address)
        console.log('accounts', accounts)

        await deployer.deploy(SquareVerifier)
        const squareVerifier = await SquareVerifier.deployed()
        console.log('square verifier address', squareVerifier.address)

        await deployer.deploy(SolnSquareVerifier, squareVerifier.address)
        const solnSquareVerifier = await SolnSquareVerifier.deployed()
        console.log('contract here', solnSquareVerifier.address)

        
	   
    } catch(err) {
        console.log('migration error', err)
    }

})