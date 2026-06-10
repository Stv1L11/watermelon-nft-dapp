# 🍉 Watermelon NFT Game Item System

本專案是一個基於 **Ethereum Sepolia Testnet** 的西瓜 NFT 遊戲道具系統。使用者可以透過 DApp 連接 MetaMask，進行隨機抽瓜、十連抽瓜、查看背包、查詢 NFT 資料，並支援 NFT 上架交易功能。

本系統結合了課程中的區塊鏈相關技術，包括 **Smart Contract、Sepolia Testnet、Sepolia ETH、MetaMask、Remix、DApp、IPFS、NFT** 等。

---

## 📌 專案簡介

Watermelon NFT Game Item System 是一個以「西瓜遊戲道具」為主題的 NFT DApp。每一顆西瓜 NFT 都是 ERC-721 Token，具有不同的品質、能力值與固定價格。

NFT 圖片與 Metadata 存放於 IPFS，智能合約部署於 Sepolia 測試網，前端使用 HTML、CSS、JavaScript 與 ethers.js 與區塊鏈互動。

---

## 🎯 專案目標

- 實作 ERC-721 NFT 智能合約
- 使用 IPFS 儲存 NFT 圖片與 Metadata
- 使用 MetaMask 連接錢包
- 部署智能合約到 Sepolia Testnet
- 建立可互動的 DApp 前端
- 實作 NFT 隨機抽取與十連抽功能
- 實作 NFT 背包顯示功能
- 實作指定買家交易與自由市場交易功能

---

## 🧰 使用技術

| 技術 | 用途 |
|---|---|
| Solidity | 撰寫 NFT 智能合約 |
| ERC-721 | NFT 標準 |
| OpenZeppelin | 使用安全的 ERC-721 合約模板 |
| Remix IDE | 編譯與部署智能合約 |
| Sepolia Testnet | 測試網部署環境 |
| Sepolia ETH | 測試網交易費用與購買 NFT |
| MetaMask | 錢包連接與交易簽署 |
| IPFS / Pinata | 儲存 NFT 圖片與 Metadata |
| HTML / CSS / JavaScript | DApp 前端介面 |
| ethers.js | 前端與智能合約互動 |
| GitHub Pages | 部署前端網頁 |

---

## 🍉 NFT 西瓜種類

| typeId | 名稱 | 品質 | Power | Defense | 固定價格 |
|---:|---|---|---:|---:|---:|
| 1 | Normal Watermelon | Common | 10 | 5 | 0.0001 ETH |
| 2 | Yellow Watermelon | Rare | 25 | 15 | 0.0005 ETH |
| 3 | Square Watermelon | Epic | 45 | 25 | 0.0010 ETH |
| 4 | Frozen Watermelon | Epic+ | 60 | 40 | 0.0020 ETH |
| 5 | Golden Watermelon | Legendary | 90 | 50 | 0.0030 ETH |

---

## 🎲 抽瓜機率

| 西瓜 | typeId | 機率 |
|---|---:|---:|
| Normal Watermelon | 1 | 50% |
| Yellow Watermelon | 2 | 25% |
| Square Watermelon | 3 | 15% |
| Frozen Watermelon | 4 | 8% |
| Golden Watermelon | 5 | 2% |

> 注意：本專案的隨機數使用區塊資訊產生，適合期末專題 Demo，不適合正式商業抽獎或高價值 NFT 系統。

---

## ✨ 系統功能

### 1. 連接 MetaMask

使用者可以透過前端 DApp 連接 MetaMask 錢包，並確認目前網路是否為 Sepolia Testnet。

### 2. 隨機抽瓜

使用者可以按下「隨機抽瓜」，系統會根據設定機率鑄造一顆西瓜 NFT。

### 3. 十連抽瓜

使用者可以一次抽取 10 顆西瓜 NFT，前端會顯示每一抽的 Token ID、名稱、品質、能力值與 Token URI。

### 4. 我的背包

系統會掃描目前合約中的 Token，找出目前錢包擁有的 Watermelon NFT，並顯示圖片與屬性資料。

### 5. 固定價格

每種西瓜 NFT 根據品質有固定價格，價格寫入智能合約中。

### 6. 指定買家交易

賣家可以將某一顆 NFT 上架給指定買家，只有該指定錢包地址可以購買。

流程：

```text
賣家輸入 Token ID
賣家輸入指定買家地址
賣家上架 NFT
買家連接 MetaMask
買家付款購買 NFT
合約自動轉移 NFT 與 Sepolia ETH
```

### 7. 自由市場交易

賣家可以將 NFT 上架到自由市場，任何不是賣家本人的使用者都可以購買。

流程：

```text
賣家輸入 Token ID
賣家上架到自由市場
其他使用者在市場列表看到 NFT
買家付款購買 NFT
合約自動完成 NFT 與 ETH 交換
```

### 8. 賣瓜市場 / 上架列表

前端會顯示目前正在出售的 NFT，包括：

- NFT 圖片
- Token ID
- 西瓜名稱
- 品質
- Power
- Defense
- 價格
- 賣家地址
- 市場類型
- 指定買家或自由市場資訊

### 9. 查詢 NFT 資料

使用者可以輸入 Token ID 查詢：

- NFT 擁有者
- 西瓜名稱
- 品質
- Power
- Defense
- Token URI
- 固定價格
- 上架狀態

---

## 🏗️ 系統架構

```text
使用者
  │
  ▼
MetaMask 錢包
  │
  ▼
DApp 前端 index.html
  │
  ├── ethers.js 呼叫智能合約
  │
  ▼
Sepolia Testnet
  │
  ▼
WatermelonNFT Smart Contract
  │
  ├── Mint NFT
  ├── 隨機抽瓜
  ├── 十連抽瓜
  ├── 查詢 NFT
  ├── 上架 NFT
  ├── 購買 NFT
  └── 取消上架

IPFS / Pinata
  │
  ├── NFT 圖片
  └── NFT Metadata JSON
```

---

## 📁 專案檔案結構

```text
watermelon-nft-dapp/
│
├── contracts/
│   └── WatermelonNFT.sol
│
├── metadata/
│   ├── normal-watermelon.json
│   ├── yellow-watermelon.json
│   ├── square-watermelon.json
│   ├── frozen-watermelon.json
│   └── golden-watermelon.json
│
├── images/
│   ├── normal-watermelon.png
│   ├── yellow-watermelon.png
│   ├── square-watermelon.png
│   ├── frozen-watermelon.png
│   └── golden-watermelon.png
│
├── index.html
└── README.md
```

---

## 🔗 Metadata 範例

以下為 Normal Watermelon 的 Metadata 範例：

```json
{
  "name": "Normal Watermelon",
  "description": "A common watermelon NFT game item.",
  "image": "ipfs://你的圖片CID",
  "attributes": [
    {
      "trait_type": "Type ID",
      "value": 1
    },
    {
      "trait_type": "Rarity",
      "value": "Common"
    },
    {
      "trait_type": "Power",
      "value": 10
    },
    {
      "trait_type": "Defense",
      "value": 5
    }
  ]
}
```

---

## 🚀 部署流程

### 1. 上傳圖片到 IPFS

將五張西瓜圖片上傳到 Pinata 或其他 IPFS 服務，取得圖片 CID。

建議檔名：

```text
normal-watermelon.png
yellow-watermelon.png
square-watermelon.png
frozen-watermelon.png
golden-watermelon.png
```

### 2. 建立 Metadata JSON

每種西瓜建立一份 Metadata JSON，並將 `image` 欄位設定成對應圖片的 IPFS 路徑。

```json
"image": "ipfs://圖片CID"
```

### 3. 上傳 Metadata 到 IPFS

將五個 JSON 檔案上傳至 IPFS，取得各自的 Metadata CID。

### 4. 使用 Remix 部署智能合約

1. 開啟 Remix IDE
2. 建立 `WatermelonNFT.sol`
3. 貼上智能合約程式碼
4. 編譯 Solidity 0.8.20 或以上版本
5. Environment 選擇 `Injected Provider - MetaMask`
6. MetaMask 切換到 Sepolia Testnet
7. Deploy 合約
8. 複製合約地址

### 5. 設定五種西瓜資料

部署完成後，在 Remix 呼叫 `setItemType()` 五次。

範例：

```text
setItemType(
  1,
  "Normal Watermelon",
  "Common",
  10,
  5,
  "ipfs://NormalMetadataCID"
)
```

五種 typeId 都必須設定：

```text
1 = Normal Watermelon
2 = Yellow Watermelon
3 = Square Watermelon
4 = Frozen Watermelon
5 = Golden Watermelon
```

### 6. 更新前端合約地址

在 `index.html` 中找到：

```javascript
const CONTRACT_ADDRESS = "填你的新合約地址";
```

改成你部署後的新合約地址。

### 7. 部署到 GitHub Pages

1. 將 `index.html` 上傳到 GitHub Repository
2. 進入 Repository 的 Settings
3. 開啟 Pages
4. Source 選擇 `Deploy from a branch`
5. Branch 選擇 `main`
6. Folder 選擇 `/root`
7. 等待 GitHub Pages 部署完成

---

## 💰 合約價格設定

智能合約中的價格如下：

```solidity
typePrices[1] = 0.0001 ether;
typePrices[2] = 0.0005 ether;
typePrices[3] = 0.001 ether;
typePrices[4] = 0.002 ether;
typePrices[5] = 0.003 ether;
```

如果合約已經部署，也可以使用 `setTypePrice()` 更新價格。Remix 中必須輸入 wei，不能輸入小數 ETH。

| typeId | ETH | wei |
|---:|---:|---:|
| 1 | 0.0001 ETH | 100000000000000 |
| 2 | 0.0005 ETH | 500000000000000 |
| 3 | 0.0010 ETH | 1000000000000000 |
| 4 | 0.0020 ETH | 2000000000000000 |
| 5 | 0.0030 ETH | 3000000000000000 |

---

## 🧪 測試流程

### Mint 測試

1. 連接 MetaMask
2. 確認網路為 Sepolia
3. 點選「隨機抽瓜」或「十連抽瓜」
4. MetaMask 確認交易
5. 查看查詢結果
6. 重新整理背包

### 指定買家交易測試

1. 賣家錢包擁有 NFT
2. 賣家輸入 Token ID
3. 賣家輸入指定買家地址
4. 賣家上架 NFT
5. 買家切換到指定錢包
6. 買家在市場列表中購買 NFT
7. NFT 轉給買家，ETH 轉給賣家

### 自由市場交易測試

1. 賣家錢包擁有 NFT
2. 賣家輸入 Token ID
3. 賣家上架到自由市場
4. 其他錢包連接 DApp
5. 市場列表會顯示可購買 NFT
6. 買家付款購買
7. NFT 轉給買家，ETH 轉給賣家

---

## ⚠️ 常見問題

### 1. 為什麼 `setTypePrice()` 不能輸入 0.0001？

因為 Solidity 的 `uint256` 只能接收整數，ETH 價格要用 wei 表示。

例如：

```text
0.0001 ETH = 100000000000000 wei
```

### 2. 為什麼抽瓜失敗，顯示某個 Watermelon not set？

代表該 typeId 還沒有呼叫 `setItemType()`。五種西瓜都必須先設定完成，隨機抽瓜才會成功。

### 3. 為什麼前端顯示 contract function is not a function？

通常是前端連到舊合約地址。若 Solidity 有新增功能，必須重新部署新合約，並更新 `index.html` 的 `CONTRACT_ADDRESS`。

### 4. 為什麼圖片顯示失敗？

可能原因：

- Metadata 的 `image` CID 錯誤
- IPFS Gateway 暫時無法讀取
- JSON 格式錯誤
- 圖片沒有成功上傳到 IPFS

### 5. 為什麼不能買某顆 NFT？

可能原因：

- NFT 尚未上架
- 你是賣家本人
- 該 NFT 是指定買家交易，但你不是指定買家
- 你的 Sepolia ETH 不足

---

## 📄 授權

本專案僅作為課程期末專題與學習用途。

---

## 👨‍💻 作者

- Project: Watermelon NFT Game Item System
- Topic: NFT 遊戲道具系統
- Network: Sepolia Testnet
