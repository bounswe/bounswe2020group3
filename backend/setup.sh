# prepare virtual environment and install packages
echo "starting to create virtual environment and install packages"
py -m venv orgenv

source orgenv/Scripts/activate

pip install -r requirements.txt
echo "finished to create virtual environment and install packages"


exit 0