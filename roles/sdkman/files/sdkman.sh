#--------------------------------------------------
# MAC-DEV-BOOTSTRAP MANAGED BLOCK - DO NOT EDIT!
#--------------------------------------------------

export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

export MAVEN_OPTS="-Xms2048m -Xmx2048m"
export JAVA_OPTS="-Xms2048m -Xmx2048m"
export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"
