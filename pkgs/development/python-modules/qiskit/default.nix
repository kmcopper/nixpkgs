{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
  # Python Inputs
, qiskit-aer
, qiskit-aqua
, qiskit-ibmq-provider
, qiskit-ignis
, qiskit-terra
  # Check Inputs
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "qiskit";
  # NOTE: This version denotes a specific set of subpackages. See https://qiskit.org/documentation/release_notes.html#version-history
  version = "0.18.2";

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = "qiskit";
    rev = version;
    sha256 = "05pwpcps1ksqx6m6hwq90l8sbak64fsz76yv4q3jplfjf6597k6p";
  };

  propagatedBuildInputs = [
    qiskit-aer
    qiskit-aqua
    qiskit-ibmq-provider
    qiskit-ignis
    qiskit-terra
  ];

  checkInputs = [ pytestCheckHook ];
  dontUseSetuptoolsCheck = true;
  # following doesn't work b/c they are distributed across different nix sitePackages dirs. Tested with pytest though.
  # pythonImportsCheck = [ "qiskit" "qiskit.terra" "qiskit.ignis" "qiskit.aer" "qiskit.aqua" ];

  meta = {
    description = "Software for developing quantum computing programs";
    homepage = "https://qiskit.org";
    downloadPage = "https://github.com/QISKit/qiskit/releases";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ drewrisinger pandaman ];
  };
}
