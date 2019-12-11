# Chromebookにpyenv+pythonをインストールする

## 概要

Chromebookを購入してLinux環境にPythonを導入しました。その作業手順を解説します。

## ハードウェア

今回使用するChromebookは次の機種です。

    機種名：Lenovo Chromebook S330
    モニタ：14.0型フルHD液晶(TN)
    CPU：MediaTek MT8173C
    メモリ：4GB
    ストレージ：64GB(eMMC)

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

## ビルド環境の導入

ソースから落としたPythonをビルドするためのツールやライブラリを導入します。

    $ sudo apt-get install build-essential zlib1g-dev libffi-dev libbz2-dev libreadline-dev libsqlite3-dev libssl-dev

## Pythonの導入

今回は、Google Colaboratoryと同じ[3.6.9]を導入します。

    $ pyenv install 3.6.9

## バージョンの有効化

globalコマンドで導入したバージョンを有効にして動作確認します。

    $ pyenv global 3.6.9
    $ python --version

## pipの動作確認

pipも導入されていることを確認します。

    $ pip list

## pipの更新

pipのバージョンが古い場合は下記のコマンドで更新します。

    $ pip install --upgrade pip

## NumPyの導入

普通にpipでできました。

    $ pip install numpy

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
