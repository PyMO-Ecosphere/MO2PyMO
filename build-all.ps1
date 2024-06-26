$PYMOGAMES_DIR = "E:/PyMO-Database/pymogames"
$GAMES = @(
    @{
        ID = "MO1"
        GameTitle = "秋之回忆"
    },
    @{
        ID = "MO2"
        GameTitle = "秋之回忆2"
    },
    @{
        ID = "yosuga"
        GameTitle = "缘之空"
    })

$PLATFORMS = @("android", "s60v3", "s60v5")
$CUR_DIR = $pwd.Path
$MO2PYMO = "$CUR_DIR/mo2pymo.ps1"
$BUILD_DIR = "$CUR_DIR/build"

if (Test-Path $BUILD_DIR) {
    rm -Recurse -Force $BUILD_DIR
}

mkdir $BUILD_DIR

foreach ($game in $GAMES) {
    foreach ($platform in $PLATFORMS) {
        cd ($PYMOGAMES_DIR + "/" + $game.ID + "_" + $platform)
        powershell $MO2PYMO
        $file_name = "MO2PyMO补丁_" + $game.GameTitle + "_" + $game.ID + "_" + $platform + ".zip"
        Compress-Archive `
            -Path @("./script", "gameconfig.txt") `
            -DestinationPath ($BUILD_DIR + "/" + $file_name) `
            -CompressionLevel "Optimal"
    }
}

cd $CUR_DIR
