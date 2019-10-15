#!/bin/sh
set -e

java_version=${java_version:-jdk1.8.0_191}
echo "Java is installing... Version is" ${java_version}
url="https://repo.huaweicloud.com/java/jdk/8u191-b12/jdk-8u191-linux-x64.tar.gz"
install_dir="/usr/local/src"
cd ${install_dir}
yum install -y wget
wget  ${url} 
tar -xzf jdk-8u191-linux-x64.tar.gz
cd ${java_version}
alternatives --install /usr/bin/java java ${install_dir}/${java_version}/bin/java 2
alternatives --config java

sleep 5
alternatives --install /usr/bin/jar jar ${install_dir}/${java_version}/bin/jar 2
alternatives --install /usr/bin/javac javac ${install_dir}/${java_version}/bin/javac 2
alternatives --set jar ${install_dir}/${java_version}/bin/jar
alternatives --set javac ${install_dir}/${java_version}/bin/javac

cat << EOF > /etc/profile.d/java.sh
#!/bin/sh
export JAVA_HOME=${install_dir}/${java_version}
export JRE_HOME=${install_dir}/${java_version}/jre
export PATH=$PATH:${install_dir}/${java_version}/bin:${install_dir}/${java_version}/jre/bin
EOF

source /etc/profile.d/java.sh

echo java installed to ${install_dir}/${java_version}
java -version

printf "\n\nTo get java in your path, open a new shell or execute: source /etc/profile.d/java.sh\n"

source /etc/profile.d/java.sh
