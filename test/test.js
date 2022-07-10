const { EtherscanProvider } = require('@ethersproject/providers')
const { expect } = require('chai')
const { ethers } = require('hardhat')

describe('RecordHelper', function () {
    let RecordHelper, RecordContract, owner, addr1, addr2, addr3, addrs
    beforeEach(async function () {
        RecordHelper = await ethers.getContractFactory("RecordHelper")
        ;[owner, addr1, addr2, addr3, ...addrs] = await ethers.getSigners()
        RecordContract = await RecordHelper.deploy()
        RecordContract.connect(addr1).createRecord("test","number")
    })

    describe ('addApproved', function () {
        it("Should fail if someone attempts to add approved and isn't the owner of a record", async function () {
            await expect(
                RecordContract.connect(addr2).addApproved(1, addr3.address),
            ).to.be.reverted   
        })
    })

    describe ('createRecord', function () {
        it("Should fail if a user already has a record stored on the blockchain", async function () {
            await expect(
                RecordContract.connect(addr1).createRecord("test", "number"),
            ).to.be.reverted
        })
    })
})

