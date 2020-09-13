FROM debian:jessie

RUN mv /etc/apt/sources.list /etc/apt/sources.list-bak &&\
    echo 'deb http://mirrors.tuna.tsinghua.edu.cn/debian/ jessie main contrib non-free' >> /etc/apt/sources.list &&\
    echo 'deb http://mirrors.tuna.tsinghua.edu.cn/debian/ jessie-updates main contrib non-free' >> /etc/apt/sources.list &&\
    echo 'deb http://mirrors.tuna.tsinghua.edu.cn/debian-security jessie/updates main contrib non-free' >> /etc/apt/sources.list &&\
    apt-get update &&\
    apt-get install -y sudo vim wget curl openssh-server &&\
    apt-get autoclean &&\
    sed -i 's/PermitRootLogin/#PermitRootLogin/g' /etc/ssh/sshd_config &&\
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config &&\
    echo 'root:root' | chpasswd &&\
    useradd -s /bin/bash -G sudo -m a &&\
    echo 'a:a' | chpasswd

EXPOSE 22 9090

ENTRYPOINT ["/sbin/init"]

# docker build --rm -t yinping/jessie .
# docker run --privileged --name=jessie --hostname=jessie -p 2222:22 -d yinping/jessie
