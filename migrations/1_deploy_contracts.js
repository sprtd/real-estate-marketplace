const MyERC721Enumerable = artifacts.require('MyERC721Enumerable');

module.exports = (async deployer => {
    try {
        await deployer.deploy(MyERC721Enumerable, 'Alpha', 'ALPH' )
        const myERC721Enumerable = await MyERC721Enumerable.deployed()
        console.log('contract here', myERC721Enumerable.address)

    } catch(err) {
        console.log('migration error', err)
    }

})