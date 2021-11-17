// SPDX-License-Identifier: MIT

//ADN: un numero 256, se tomaran 13 atributos
//Cada atributo corresponde a un par de numeros
//se usaran los ultimo 26 numero de un entero 256

pragma solidity ^0.8.0;

contract PunkDNA {
    string[] private _accessoriesType = [
        "Blank",
        "Kurt",
        "Prescription01",
        "Prescription02",
        "Round",
        "Sunglasses",
        "Wayfarers"
    ];

    string[] private _clotheColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _clotheType = [
        "BlazerShirt",
        "BlazerSweater",
        "CollarSweater",
        "GraphicShirt",
        "Hoodie",
        "Overall",
        "ShirtCrewNeck",
        "ShirtScoopNeck",
        "ShirtVNeck"
    ];

    string[] private _eyeType = [
        "Close",
        "Cry",
        "Default",
        "Dizzy",
        "EyeRoll",
        "Happy",
        "Hearts",
        "Side",
        "Squint",
        "Surprised",
        "Wink",
        "WinkWacky"
    ];

    string[] private _eyebrowType = [
        "Angry",
        "AngryNatural",
        "Default",
        "DefaultNatural",
        "FlatNatural",
        "RaisedExcited",
        "RaisedExcitedNatural",
        "SadConcerned",
        "SadConcernedNatural",
        "UnibrowNatural",
        "UpDown",
        "UpDownNatural"
    ];

    string[] private _facialHairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "Platinum",
        "Red"
    ];

    string[] private _facialHairType = [
        "Blank",
        "BeardMedium",
        "BeardLight",
        "BeardMagestic",
        "MoustacheFancy",
        "MoustacheMagnum"
    ];

    string[] private _hairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "PastelPink",
        "Platinum",
        "Red",
        "SilverGray"
    ];

    string[] private _hatColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _graphicType = [
        "Bat",
        "Cumbia",
        "Deer",
        "Diamond",
        "Hola",
        "Pizza",
        "Resist",
        "Selena",
        "Bear",
        "SkullOutline",
        "Skull"
    ];

    string[] private _mouthType = [
        "Concerned",
        "Default",
        "Disbelief",
        "Eating",
        "Grimace",
        "Sad",
        "ScreamOpen",
        "Serious",
        "Smile",
        "Tongue",
        "Twinkle",
        "Vomit"
    ];

    string[] private _skinColor = [
        "Tanned",
        "Yellow",
        "Pale",
        "Light",
        "Brown",
        "DarkBrown",
        "Black"
    ];

    string[] private _topType = [
        "NoHair",
        "Eyepatch",
        "Hat",
        "Hijab",
        "Turban",
        "WinterHat1",
        "WinterHat2",
        "WinterHat3",
        "WinterHat4",
        "LongHairBigHair",
        "LongHairBob",
        "LongHairBun",
        "LongHairCurly",
        "LongHairCurvy",
        "LongHairDreads",
        "LongHairFrida",
        "LongHairFro",
        "LongHairFroBand",
        "LongHairNotTooLong",
        "LongHairShavedSides",
        "LongHairMiaWallace",
        "LongHairStraight",
        "LongHairStraight2",
        "LongHairStraightStrand",
        "ShortHairDreads01",
        "ShortHairDreads02",
        "ShortHairFrizzle",
        "ShortHairShaggyMullet",
        "ShortHairShortCurly",
        "ShortHairShortFlat",
        "ShortHairShortRound",
        "ShortHairShortWaved",
        "ShortHairSides",
        "ShortHairTheCaesar",
        "ShortHairTheCaesarSidePart"
    ];

    uint8 constant ADN_SECTION_SIZE = 2;

    //funcion determinista seudo aleatorio, no debe ser usado en produccion
    function deterministicPseudoRadomDNA(uint256 _tokenId, address _minter)
        public
        pure
        returns (uint256)
    {
        //se ecnode un addres a entero, un exadecimal a entero. para el addres es un entero de 160
        uint256 combineParams = _tokenId + uint160(_minter);

        //entero representado por bits
        bytes memory encodeParams = abi.encodePacked(combineParams);

        // funcion interna de solidity que genera un hash
        bytes32 hashParams = keccak256(encodeParams);

        return uint256(hashParams);
    }

    function getDNASection(uint256 _dna, uint256 _righDiscard)
        internal
        pure
        returns (uint256)
    {
        return
            uint256(
                (_dna % (1 * 10**(_righDiscard * ADN_SECTION_SIZE))) /
                    (1 * 10**_righDiscard)
            );
    }

    function getAccesoriesType(uint256 _dna)
        public
        view
        returns (string memory)
    {
        uint256 dnaSection = getDNASection(_dna, 0);
        return _accessoriesType[dnaSection % _accessoriesType.length];
    }

    function getClotheColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 2);
        return _clotheColor[dnaSection % _clotheColor.length];
    }

    function getClotheType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 4);
        return _clotheType[dnaSection % _clotheType.length];
    }

    function getEyeType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 6);
        return _eyeType[dnaSection % _eyeType.length];
    }

    function getEyeBrowType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 8);
        return _eyebrowType[dnaSection % _eyebrowType.length];
    }

    function getFacialHairColor(uint256 _dna)
        public
        view
        returns (string memory)
    {
        uint256 dnaSection = getDNASection(_dna, 10);
        return _facialHairColor[dnaSection % _facialHairColor.length];
    }

    function getFacialHairType(uint256 _dna)
        public
        view
        returns (string memory)
    {
        uint256 dnaSection = getDNASection(_dna, 12);
        return _facialHairType[dnaSection % _facialHairType.length];
    }

    function getHairColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 14);
        return _hairColor[dnaSection % _hairColor.length];
    }

    function getHatColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 16);
        return _hatColor[dnaSection % _hatColor.length];
    }

    function getGraphicType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 18);
        return _graphicType[dnaSection % _graphicType.length];
    }

    function getMouthType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 20);
        return _mouthType[dnaSection % _mouthType.length];
    }

    function getSkinColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 22);
        return _skinColor[dnaSection % _skinColor.length];
    }

    function getTopType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = getDNASection(_dna, 24);
        return _topType[dnaSection % _topType.length];
    }
}
