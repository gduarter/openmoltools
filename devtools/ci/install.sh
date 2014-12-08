MINICONDA=Miniconda-latest-Linux-x86_64.sh
MINICONDA_MD5=$(curl -s http://repo.continuum.io/miniconda/ | grep -A3 $MINICONDA | sed -n '4p' | sed -n 's/ *<td>\(.*\)<\/td> */\1/p')
wget http://repo.continuum.io/miniconda/$MINICONDA
if [[ $MINICONDA_MD5 != $(md5sum $MINICONDA | cut -d ' ' -f 1) ]]; then
    echo "Miniconda MD5 mismatch"
    exit 1
fi
bash $MINICONDA -b
PIP_ARGS="-U"

export PATH=$HOME/miniconda/bin:$PATH

sudo apt-get update
sudo apt-get install -qq -y g++ gfortran csh g++-multilib gcc-multilib openbabel

conda update --yes conda
echo "Update conda"
conda config --add channels http://conda.binstar.org/omnia
conda config --add channels https://conda.binstar.org/ric
#conda create --yes -n ${python} python=${python} --file devtools/ci/requirements-conda.txt  # Now using conda to automatically handle environment creation / testing
source activate $python
conda install --yes conda-build
echo "install conda build"
