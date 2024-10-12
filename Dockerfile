# 使用官方 Golang 镜像作为基础镜像
FROM golang:1.23 AS builder

# 设置工作目录
WORKDIR /app

# 复制 go.mod 和 go.sum 文件
COPY go.mod go.sum ./

# 下载依赖
RUN go mod tidy

# 复制源代码
COPY . .

RUN ls

# 构建 Go 应用
RUN go build -o myapp .

# 创建一个小的镜像用于运行
FROM golang:1.23

# 将从 builder 镜像中构建的二进制文件复制到新的镜像
COPY --from=builder /app/myapp .

# 暴露默认端口 (例如：8080)
EXPOSE 8080

RUN chmod +x ./myapp

RUN ls -l .

# 设置容器启动时的命令
CMD [ "./myapp"]
