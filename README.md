# Foundry_Project
`[⠔] Compiling...No files changed, compilation skipped
[⠒] Compiling...

Running 3 tests for test/NFTMarketplace.t.sol:NFTMarketplaceTest
[PASS] test_BuyNFT() (gas: 163975)
Logs:
  token.balanceOf(admin)== 100
  token.balanceOf(buyerAddress)== 9900

Traces:
  [163975] NFTMarketplaceTest::test_BuyNFT()
    ├─ [0] VM::startPrank(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF])
    │   └─ ← ()
    ├─ [78704] NFTMarketplace::listNFT(0, 100)
    │   ├─ [2620] MyNFT::ownerOf(0) [staticcall]
    │   │   └─ ← admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF]
    │   ├─ emit NFTListed(tokenId: 0, seller: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], price: 100)
    │   └─ ← ()
    ├─ [0] VM::startPrank(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02])
    │   └─ ← ()
    ├─ [85769] NFTMarketplace::buyNFT(0, 100)
    │   ├─ [35640] MyToken::transferFrom(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], 100)
    │   │   ├─ emit Transfer(from: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], to: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], value: 100)
    │   │   └─ ← true
    │   ├─ [41228] MyNFT::transferFrom(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 0)
    │   │   ├─ emit Transfer(from: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], to: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], tokenId: 0)
    │   │   └─ ← ()
    │   ├─ emit NFTSold(tokenId: 0, buyer: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], price: 100)
    │   └─ ← ()
    ├─ [563] MyToken::balanceOf(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF]) [staticcall]
    │   └─ ← 100
    ├─ [0] console::log("token.balanceOf(admin)==", 100) [staticcall]
    │   └─ ← ()
    ├─ [563] MyToken::balanceOf(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02]) [staticcall]
    │   └─ ← 9900
    ├─ [0] console::log("token.balanceOf(buyerAddress)==", 9900) [staticcall]
    │   └─ ← ()
    ├─ [0] VM::stopPrank()
    │   └─ ← ()
    ├─ [563] MyToken::balanceOf(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF]) [staticcall]
    │   └─ ← 100
    ├─ [563] MyToken::balanceOf(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02]) [staticcall]
    │   └─ ← 9900
    └─ ← ()

[PASS] test_listNFT() (gas: 110236)
Traces:
  [110236] NFTMarketplaceTest::test_listNFT()
    ├─ [0] VM::startPrank(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF])
    │   └─ ← ()
    ├─ [98604] NFTMarketplace::listNFT(1, 100)
    │   ├─ [2620] MyNFT::ownerOf(1) [staticcall]
    │   │   └─ ← admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF]
    │   ├─ emit NFTListed(tokenId: 1, seller: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], price: 100)
    │   └─ ← ()
    ├─ [0] VM::stopPrank()
    │   └─ ← ()
    ├─ [526] NFTMarketplace::getListByTokenID(1) [staticcall]
    │   └─ ← 1
    └─ ← ()

[PASS] test_tokensReceived() (gas: 184689)
Logs:
  abi decode== 1

Traces:
  [184689] NFTMarketplaceTest::test_tokensReceived()
    ├─ [0] VM::startPrank(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF])
    │   └─ ← ()
    ├─ [98604] NFTMarketplace::listNFT(1, 100)
    │   ├─ [2620] MyNFT::ownerOf(1) [staticcall]
    │   │   └─ ← admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF]
    │   ├─ emit NFTListed(tokenId: 1, seller: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], price: 100)
    │   └─ ← ()
    ├─ [0] VM::stopPrank()
    │   └─ ← ()
    ├─ [0] VM::startPrank(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02])
    │   └─ ← ()
    ├─ [0] console::log("abi decode==", 1) [staticcall]
    │   └─ ← ()
    ├─ [85963] MyToken::transferWithCallbackBuyNFT(NFTMarketplace: [0xDDd9A038D57372934f1b9c52bd8621F5ED4268DF], 100, 0x0000000000000000000000000000000000000000000000000000000000000001)
    │   ├─ [84188] NFTMarketplace::tokensReceived(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 0x0000000000000000000000000000000000000000, 100, 0x0000000000000000000000000000000000000000000000000000000000000001)
    │   │   ├─ [35640] MyToken::transferFrom(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], 100)
    │   │   │   ├─ emit Transfer(from: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], to: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], value: 100)
    │   │   │   └─ ← true
    │   │   ├─ [41228] MyNFT::transferFrom(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 1)
    │   │   │   ├─ emit Transfer(from: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], to: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], tokenId: 1)
    │   │   │   └─ ← ()
    │   │   ├─ emit NFTSold(tokenId: 1, buyer: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], price: 100)
    │   │   └─ ← true
    │   └─ ← true
    ├─ [0] VM::stopPrank()
    │   └─ ← ()
    ├─ [563] MyToken::balanceOf(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF]) [staticcall]
    │   └─ ← 100
    ├─ [563] MyToken::balanceOf(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02]) [staticcall]
    │   └─ ← 9900
    └─ ← ()

Test result: ok. 3 passed; 0 failed; 0 skipped; finished in 11.62ms
| src/MyNFT.sol:MyNFT contract |                 |       |        |       |         |
|------------------------------|-----------------|-------|--------|-------|---------|
| Deployment Cost              | Deployment Size |       |        |       |         |
| 1105953                      | 5928            |       |        |       |         |
| Function Name                | min             | avg   | median | max   | # calls |
| approve                      | 25119           | 25119 | 25119  | 25119 | 6       |
| ownerOf                      | 2620            | 2620  | 2620   | 2620  | 3       |
| safeMint                     | 50041           | 71941 | 71941  | 93841 | 6       |
| transferFrom                 | 41228           | 41228 | 41228  | 41228 | 2       |


| src/MyToken.sol:MyToken contract |                 |       |        |       |         |
|----------------------------------|-----------------|-------|--------|-------|---------|
| Deployment Cost                  | Deployment Size |       |        |       |         |
| 689130                           | 3843            |       |        |       |         |
| Function Name                    | min             | avg   | median | max   | # calls |
| approve                          | 24762           | 24762 | 24762  | 24762 | 3       |
| balanceOf                        | 563             | 563   | 563    | 563   | 6       |
| mint                             | 47042           | 47042 | 47042  | 47042 | 3       |
| transferFrom                     | 35640           | 35640 | 35640  | 35640 | 2       |
| transferWithCallbackBuyNFT       | 85963           | 85963 | 85963  | 85963 | 1       |


| src/NFTMarketplace.sol:NFTMarketplace contract |                 |       |        |       |         |
|------------------------------------------------|-----------------|-------|--------|-------|---------|
| Deployment Cost                                | Deployment Size |       |        |       |         |
| 724776                                         | 3718            |       |        |       |         |
| Function Name                                  | min             | avg   | median | max   | # calls |
| buyNFT                                         | 85769           | 85769 | 85769  | 85769 | 1       |
| getListByTokenID                               | 526             | 526   | 526    | 526   | 1       |
| listNFT                                        | 78704           | 91970 | 98604  | 98604 | 3       |
| tokensReceived                                 | 84188           | 84188 | 84188  | 84188 | 1       |



 
Ran 1 test suites: 3 tests passed, 0 failed, 0 skipped (3 total tests)`