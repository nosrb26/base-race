/**
 *Submitted for verification at basescan.org on 2025-01-13
*/

pragma solidity ^0.8.0;

contract MechanicWorkshop {
    // État du turbo de la voiture : installé ou non
    bool public isTurboInstalled;

    // Quantité totale de nitro ajoutée
    uint public totalNitro;

    // État du mode racing : installé ou non
    bool public isRacingModeInstalled;

    // Amélioration moteur totale (en puissance)
    uint public engineImprovement;

    // Événements pour suivre les actions
    event TurboChanged(bool state);
    event NitroAdded(uint amount);
    event RacingModeInstalled(bool state);
    event EngineStaged(uint improvement);

    // Constructeur pour initialiser les états
    constructor() {
        isTurboInstalled = false;
        totalNitro = 0;
        isRacingModeInstalled = false;
        engineImprovement = 0;
    }

    // Fonction pour changer l'état du turbo
    function changeTurbo() public {
        isTurboInstalled = !isTurboInstalled;
        emit TurboChanged(isTurboInstalled);
    }

    // Fonction pour ajouter de la nitro d'une quantité random
    function addNitro() public {
        uint randomNitro = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 50 + 1; // Nitro entre 1 et 50
        totalNitro += randomNitro;
        emit NitroAdded(randomNitro);
    }

    // Fonction pour installer le mode racing
    function installRacingMode() public {
        require(!isRacingModeInstalled, "Le mode racing est deja installe.");
        isRacingModeInstalled = true;
        emit RacingModeInstalled(isRacingModeInstalled);
    }

    // Fonction pour améliorer le moteur (stage d'une valeur random)
    function stageEngine() public {
        uint randomImprovement = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 100 + 1; // Amélioration entre 1 et 100
        engineImprovement += randomImprovement;
        emit EngineStaged(randomImprovement);
    }

    // Fonction pour obtenir l'état complet de la voiture
    function getCarStatus() public view returns (string memory) {
        string memory turboStatus = isTurboInstalled ? "installe" : "non installe";
        string memory racingModeStatus = isRacingModeInstalled ? "installe" : "non installe";
        return string(abi.encodePacked(
            "Turbo: ", turboStatus, ", Nitro totale: ", uintToString(totalNitro), ", Mode Racing: ", racingModeStatus, ", Amelioration moteur: ", uintToString(engineImprovement), " CV."
        ));
    }

    // Fonction utilitaire pour convertir un uint en string
    function uintToString(uint v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint maxLen = 100;
        bytes memory reversed = new bytes(maxLen);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i);
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - 1 - j];
        }
        return string(s);
    }
}
