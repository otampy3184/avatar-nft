const AvatarNFT = artifacts.require("AvatarNFT");

module.exports = function (deployer) {
  deployer.deploy(AvatarNFT);
};
