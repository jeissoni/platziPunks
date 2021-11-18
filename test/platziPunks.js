const {expect} = require('chai');
const { base64 } = require('ethers/lib/utils');
const { ethers } = require('hardhat');

describe ('Platzi Punks Contract', ()=> {

    const setup = async({maxSupply = 10000}) => {
        const [owner] = await ethers.getSigners();
        const platziPunk = await ethers.getContractFactory("PlatziPunks");
        const deployed = await platziPunk.deploy(maxSupply);

        return{
            owner,
            deployed
        }
    }



    describe('deployment', ()=> {
        it('set max supply to passed param', async () =>{
            const maxSupply = 4000000;

            const {deployed} = await setup({maxSupply});

            const returnedMaxSupply = await deployed.maxSupply();

            expect(maxSupply).to.equal(returnedMaxSupply);
        })
    })

    describe('minting', ()=>{

        it ('mints a new token and assings it to owner', async () =>{
            const maxSupply = 4000000;
            const {deployed, owner} = await setup({maxSupply});

            await deployed.mint();

            const owenerOfMinter = await deployed.ownerOf(0)

            expect(owenerOfMinter).to.equal(owner.address)
        })

        it('hast a minting limit', async()=>{

            const maxSupply = 2;
            const {deployed} = await setup({maxSupply});
    
            //mintar todos 
            await deployed.mint();
            await deployed.mint();
    
            await expect(deployed.mint()).to.be.revertedWith("not platziPunks left :(");
    
        })
    })


    describe('tokenURI',()=>{
        it('returns valid metadata', async () =>{
            const {deployed, owner} = await setup({});

            await deployed.mint();

            const tokenURI = await deployed.tokenURI(0);

            const stringTokenURI = await tokenURI.toString();

            const [prefix, base64JSON] = stringTokenURI.split(
                "data:application/json;base64,"
            );

            const stringMetadata = await Buffer.from(
                base64JSON,
                "base64"
                ).toString("ascii");            
           
            const metadata = JSON.parse(stringMetadata);

            expect(metadata).to.have.all.keys("name", "description", "image");

        })
    })


})
