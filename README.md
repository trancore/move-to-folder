# 📡 使用技術

|使用技術|バージョン|
|---|---|
|Powershell|-|

# ✍️ このスクリプトについて

このスクリプトは、ディレクトリ名と同じ名前を持つファイル名を検索し、存在すればそのディレクトリにファイルを移動する、スクリプトになります。

# 📝 例

例えば、以下ディレクトリで考えます。

```plain
(root)
    |--- {移動したいファイルの入ったディレクトリ名}
    |       |--- test1 hoge.txt
    |       |--- test2 hoge.txt
    |       |___ test5.txt
    |--- test1
    |--- test2
    |___ test3
```

root直下でこのスクリプトを実行すると、test1 hoge.txt, test2 hoge.txtがそれぞれtest1, test2ディレクトリに移動します。

このとき、

```powershell
$directoryToBeMoved = {移動したいファイルの入ったディレクトリ名}
$delimiter = "hoge"
```

となるように設定してください。
