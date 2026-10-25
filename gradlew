#!/bin/sh
# Bootstrap fallback: use the wrapper if its JAR exists, otherwise explain how to regenerate it.
APP_HOME=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
if [ -f "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" ]; then
  exec java -classpath "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain "$@"
fi
if command -v gradle >/dev/null 2>&1; then
  echo "Gradle wrapper JAR missing; generating wrapper with installed Gradle..." >&2
  (cd "$APP_HOME" && gradle wrapper --gradle-version 8.14.3) || exit $?
  exec "$APP_HOME/gradlew" "$@"
fi
echo "NEXORA: gradle-wrapper.jar is missing and Gradle is not installed." >&2
echo "Install Gradle 8.14+ or run 'gradle wrapper --gradle-version 8.14.3', then retry." >&2
exit 1
