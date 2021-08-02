![基于Docker运行的人大金仓Kingbase数据库](./doc/image/WX202108021418082x.jpg)

# 人大金仓数据库管理系统（KingbaseES V8 R3) Docker 镜像

本人使用 MacOS 开发项目，无法安装人大金仓数据库，所以将人大金仓数据库封装到了 Docker，分享出来给各位程序员使用。

使用的人大金仓版本号：V008R003C002B0320

教程文章：[在苹果 MacOS 上基于 Docker 容器运行人大金仓（Kingbase）V8 R3 数据库的教程](https://www.renfei.net/posts/1003506)

## 构建镜像

```bash
git clone https://github.com/renfei/kingbase-es-v8-r3-docker.git
cd kingbase-es-v8-r3-docker
docker build -t kingbase:v8r3 .
```

注意 ```docker build -t kingbase:v8r3 .``` ，后面有个点（.）不能缺。

国内用户可将 ```https://github.com/renfei/kingbase-es-v8-r3-docker.git``` 更换为码云地址 ```https://gitee.com/rnf/kingbase-es-v8-r3-docker.git```

## 运行

```bash
docker run -d --name kingbase -p 54321:54321 -e SYSTEM_PWD=SYSTEM -v /opt/kingbase/data:/opt/kingbase/data -v /opt/kingbase/license.dat:/opt/kingbase/Server/bin/license.dat kingbase:v8r3
```

- --name: 容器名称
- -p: 端口映射
- -e: 默认用户SYSTEM,通过环境变量SYSTEM_PWD指定初始化数据库时的默认用户密码
- -v: 挂载宿主机的一个目录，这里挂载了数据目录和license文件

## 截图

![Docker](./doc/image/WX202108021417482x.png)

![Docker](./doc/image/WX202108021418082x.png)