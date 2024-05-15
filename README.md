
### Project TravelTaipei-HW

-   **Models**
    -   `AttractionsModel`: 從API取得的資料結構。
-   **ViewControllers**
    -   `HomeViewController`:
    -   `NewsDetailViewController`: 
-   **ViewModels**
    -   `AttractionViewModel`: 管理與取得景點資料相關的業務邏輯。
-   **Services**
    -   `AttractionsAPIServiceProtocol`: 定義用於取得資料的協議。
    -   `AttractionsAPIService`: 實現與網路層互動的協定並使用以下命令檢索資料  `NetworkServices`.
-   **Networking**
    -   `APIConfiguration`: 定義配置 API 請求所需屬性的協定。
    -   `AttractionsAPIConfiguration`: 符合 APIConfiguration 的 enum，指定用於取得景點的 API 端點和參數。
    -   `NetworkServices`: 使用 Alamofire 封裝網路邏輯以發出 API 請求並處理回應
-   **Utilities**
    -   `LanguageManager`: 管理應用程式的目前語言設定。
    -   `AlertUtils`: 提供實用功能來顯示自訂 Alert
