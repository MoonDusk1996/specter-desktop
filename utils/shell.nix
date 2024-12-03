with import <nixpkgs> { };
with pkgs.python310;
stdenv.mkDerivation {
  name = "specter-desktop";
  buildInputs = [
    python310Full
    python310Packages.virtualenv
    python310Packages.pip
    python310Packages.pip-tools
    libusb1
  ];
  shellHook = ''
    cd ..
    pip-compile --generate-hashes requirements.in > requirements.txt
    pip3 install virtualenv
    virtualenv --python=python3 .env
    source .env/bin/activate
    pip3 install -r requirements.txt --require-hashes
    pip3 install -e .
    python3 setup.py install
  '';
}
