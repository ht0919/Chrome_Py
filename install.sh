# Python 3.5.9
pip install numpy==1.16.2
pip install matplotlib==3.0.3
pip install jupyter==1.0.0
pip install scipy==1.2.0
pip install scikit-learn==0.19.1
pip install pandas==0.24.1
#
curl -sL https://bootstrap.pypa.io/get-pip.py | python -
curl -L https://github.com/lherman-cs/tensorflow-aarch64/releases/download/r1.4/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl > /tmp/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl
python -m pip install /tmp/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl
#
pip install Keras==2.0.8
