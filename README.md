# CE Devops Recuitment Test 

This is a super complex project but doesn't have a CI. It
To work this project has 3 scripts

1. buildProject.sh : This builds the super complex project output. Needs current build number as argument.
2. signProject.sh : This takes the output of buildProject and signs the project with the recently generated key and generates signed version.
3. generateSigningKey.sh : This generates the super secure signing key to sign the project in a hidden location. This key is only valid for 5 minutes and need to be regenerated every 5 minutes. This key is used by signProject.sh to sign. generateSigningKey is not compatible with `figlet` so this needs to run in machine without `figlet` installed.

## CI Implementation

1. Whenever a build is requested CI needs to download the code and execute `buildProject.sh <arg>` on a slave with `figlet` installed. This will generate `<arg>-output.txt`
2. This `<arg>-output.txt` needs to be signed using `signProject.sh` on slave which generates signing key every 5 minutes. This generates `<arg>-output.txt-signed.txt`
3. Both the files `<arg>-output.txt-signed.txt` and `<arg>-output.txt` need to be saved as pipeline output.

## Build Pipeline

We need a jenkins piepline with 2 stages build and sign which performs building and signing process.
The arg to `buildProject.sh` is the SHA of the current code which you can get by executing `git rev-parse HEAD` in cloned repository.
