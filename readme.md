# Lenovo Chromebook S330に、VSCodeとPython+Keras+Tensorflowを導入する

## 概要

Lenovo Chromebook S330というARM系のChromebookを購入したので、Linux環境にVSCodeとPython+Keras+Tensorflowを導入しました。その作業手順を解説します。

## ハードウェア

今回使用するChromebookは次の機種です。

    機種名：Lenovo Chromebook S330
    モニタ：14.0型フルHD液晶(TN)
    CPU：MediaTek MT8173C
    メモリ：4GB
    ストレージ：64GB(eMMC)

## Python関連のバージョン

今回は次のバージョンを導入しました。

    Python       3.5.9
    pip          1.9.3
    wheel        0.33.6
    setuptools   44.0.0
    numpy        1.13.3
    matplotlib   2.1.1
    jupyter      1.0.0
    scipy        1.0.0
    scikit-learn 0.19.1
    Pillow       5.0.0
    pandas       0.24.1
    numba        0.30.1
    seaborn      0.9.0
    statsmodels  0.10.2
    tensorflow   1.4.0rc0
    Keras        2.0.8

## Linux環境の導入

Linux環境は次の作業でインストールします。

    1. 画面右下で時間表示をクリックする
    2. [設定]をクリックする
    3. [Linux（beta）]をクリックし、[有効にする]をクリックする
    4. 画面の指示に従って設定を進める
    5. 最後にターミナルウィンドウが開くので、Linuxコマンドを入力して動作確認する

## Linuxのバージョン

cat /etc/os-releaseを実行すると、次の内容が表示されました。

    PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
    NAME="Debian GNU/Linux"
    VERSION_ID="9"
    VERSION="9 (stretch)"
    VERSION_CODENAME=stretch
    ID=debian
    HOME_URL="https://www.debian.org/"
    SUPPORT_URL="https://www.debian.org/support"
    BUG_REPORT_URL="https://bugs.debian.org/"

## パッケージの更新

    $ sudo apt-get update
    $ sudo apt-get upgrade -y
    $ sudo apt-get dist-upgrade
    $ sudo apt-get autoclean

## GPG keyの導入

sudo apt-get update で次のようなワーニングが表示される場合があります。

    W: GPG error: https://packagecloud.io/headmelted/codebuilds/debian stretch InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 0CC3FD642696BFC8

この場合、GPG key の導入で対処できます。

    $ sudo apt-get install curl gnupg
    $ curl -L https://packagecloud.io/headmelted/codebuilds/gpgkey | sudo apt-key add -

## ビルド環境の導入

ソースから落としたPythonをビルドするためのツールやライブラリを導入します。

    $ sudo apt-get install build-essential zlib1g-dev libffi-dev libbz2-dev libreadline-dev libsqlite3-dev libssl-dev

## 日本語関連の設定

日本語フォントの追加

    $ sudo apt install fonts-noto

日本語入力の追加と設定

    $ sudo apt install fcitx-anthy

日本切替キーの設定

    $ fcitx-autostart
    $ fcitx-configtool
    ※ Input MethodにAnthyを追加する
    ※ Global ConfigでHotKeyを[ctrl]+[space]に設定

日本語入力の起動

    $ fcitx-autostart

日本語入力の停止

    $ pkill -f fcitx

## VSCode(VisualStudio Code) の導入

パッケージのダウンロード

    入手先→ https://github.com/headmelted/codebuilds/releases
    ファイル名→ code-oss_1.42.0-1575959662_arm64.deb

パッケージのインストール

    ダウンロードしたファイルを右クリック（ダブルタップ）する
    [Linux（ベータ版）でのインストール]をクリックする

VSCodeの起動

    ランチャーに追加されたアイコン[Code - OSS(headmelted)]をクリックする
    ターミナルで「code-oss .」と入力するとカレントディレクトリから起動する

メニューの日本語化

    1. [ctrl]+[shift]+[x]で拡張機能を表示する
    2. 「Japanese」を検索する
    3. 「Japanese Language Pack for VS Code」をインストールする

キーバインドの変更

    ※日本語入力の切替と重なるため「候補をトリガー」のキーバインドを変更する
    1. [ctrl]+[k]+[s]でキーボードショートカットを表示する
    2. 「候補」を検索する
    3. [alt]+[space]に変更する

## pyenvの導入

複数のPythonを切り替えて使えるように、plenvを導入します。

    $ git clone https://github.com/pyenv/pyenv.git ~/.pyenv

## 環境変数の設定

テキストエディタで「~/.profile」を開き、最下行に次の5行を追加します。
その後、sourceコマンドで再読込みします。

    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi

    $ source ~/.profile

## Pythonの導入

今回は、Arm64版のTensorflowを入れたいので[3.5.9]を導入します。

    $ pyenv install 3.5.9

## バージョンの有効化

globalコマンドで導入したバージョンを有効にして動作確認します。

    $ pyenv global 3.5.9
    $ python --version

## pipの動作確認

pipも導入されていることを確認します。

    $ pip list

## pipとsetuptoolsの更新

バージョンが古いので下記のコマンドで更新します。

    $ pip install --upgrade pip
    $ pip install --upgrade setuptools

## NumPyの導入

Tensorflowでのエラー回避のため古いバージョンを入れています。

    $ pip install numpy==1.13.3

## Matplotlibの導入

いくつかのライブラリの追加が必要です。

    $ sudo apt-get install pkg-config libpng-dev libfreetype6-dev
    $ pip install matplotlib

グラフは画像データとして保存します。

    [sample.py]
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    plt.plot([1, 2])
    plt.savefig('image.png')

## Jupyter Notebookの導入

こちらも普通にpipでできました。

    $ pip install jupyter
    $ jupyter notebook

## SciPyの導入

いくつかのライブラリの追加が必要です。

    $ sudo apt-get install libblas-dev liblapack-dev libatlas-base-dev

エラー回避のため古いバージョンを入れています。処理時間がすごくかかります。

    $ pip install scipy==1.0.0

## scikit-learnの導入

Tensorflowでのエラー回避のため古いバージョンを入れています。
こちらもかなり時間がかかります。

    $ pip install scikit-learn==0.19.1

## Pillowの導入

Jpeg関連のライブラリが必要です。

    $ sudo apt-get install libjpeg-dev

Tensorflowでのエラー回避のため古いバージョンを入れています。

    $ pip install Pillow==5.0.0

## Pandasの導入

Tensorflowでのエラー回避のため古いバージョンを入れています。
かなり時間がかかります。

    $ pip install pandas==0.24.1

## pandas-datareaderの導入

追加のライブラリが必要です。

    $ sudo apt-get install libxml2 libxslt-dev

こちらもかなり時間がかかります。

    $ pip install pandas-datareader

## Numbaの導入

llvmの導入が必要です。

    $ sudo apt-get install llvm-3.8
    $ LLVM_CONFIG=/usr/bin/llvm-config-3.8 pip install llvmlite==0.15.0

こちらもかなり時間がかかります。終わるまで気長に待ちましょう。

    $ LLVM_CONFIG=/usr/bin/llvm-config-3.8 pip install numba==0.30.1

## seabornとstatsmodelsの導入

Pandas本で必要だったので導入しました。

    $ pip install seaborn
    $ pip install statsmodels

## tensorflow-aarch64の導入

pipとwheelをインストール(更新)します。

    $ curl -sL https://bootstrap.pypa.io/get-pip.py | python3 -

tensorflow-aarch64をインストールします。

    $ curl -L https://github.com/lherman-cs/tensorflow-aarch64/releases/download/r1.4/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl > /tmp/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl
    $ python3 -m pip install /tmp/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl

## Kerasの導入

tensorflow-1.4と相性の良い2.0.8をインストールします。

    $ pip install keras==2.0.8

動作確認

    $ python
    Python 3.5.9 (default, Jan  6 2020, 21:51:58) 
    [GCC 6.3.0 20170516] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import keras
    Using TensorFlow backend.
    >>> exit()
