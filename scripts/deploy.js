const deploy = async() => {    
    const [deployer] = await ethers.getSigners();
    console.log('Deploying contrat with the account: ', deployer.address)
    const platziPunk = await ethers.getContractFactory("PlatziPuns")
    const deployed = await platziPunk.deploy()
    console.log("platziPunks isdeployed at:", deployed.address )
}

deploy().then(()=> process.exit(0)).catch(error => {
    console.log(error);
    process.exit(1);
});

