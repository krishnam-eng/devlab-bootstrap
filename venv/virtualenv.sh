# virtual environment keeps dependencies required by different projects in separate places.

# install venv
sudo apt-get install python-virtualenv
# or
pip3 install --user virtualenv

# You can specify the version of Python with the --python argument.
# Then, use the activate script to set the PATH, entering the virtual environment:

cd my-project-folder
virtualenv --python python3 my-venv
source my-venv/bin/activate

# When bundling your own packages or projects for other people, you can use:
pip freeze > requirements.txt

# Collaborators can install all of the dependencies in their own virtual environment when given a requirements.txt file by typing:
pip install -r requirements.txt

# To return to normal system settings, type
deactivate

