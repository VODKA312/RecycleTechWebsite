@echo off
REM RecycleTech Docker部署脚本
REM 使用方法: deploy-docker.bat [build^|start^|stop^|restart^|logs^|clean]

setlocal enabledelayedexpansion

REM 检查参数
set "ACTION=%1"
if "%ACTION%"=="" set "ACTION=start"

echo RecycleTech Docker部署脚本
echo ================================

if "%ACTION%"=="build" (
    echo 构建Docker镜像...
    docker-compose build
    echo 构建完成！
    
) else if "%ACTION%"=="start" (
    echo 启动RecycleTech服务...
    docker-compose up -d
    echo 服务启动完成！
    echo.
    echo 访问地址:
    echo - 主站: http://localhost:9090
    echo - 管理后台: http://localhost:9090/admin/
    echo - 应用端口: http://localhost:8001
    echo.
    echo 查看日志: deploy-docker.bat logs
    
) else if "%ACTION%"=="stop" (
    echo 停止RecycleTech服务...
    docker-compose down
    echo 服务已停止！
    
) else if "%ACTION%"=="restart" (
    echo 重启RecycleTech服务...
    docker-compose restart
    echo 服务重启完成！
    
) else if "%ACTION%"=="logs" (
    echo 查看服务日志...
    docker-compose logs -f
    
) else if "%ACTION%"=="clean" (
    echo 清理Docker资源...
    docker-compose down --volumes --remove-orphans
    docker system prune -f
    echo 清理完成！
    
) else (
    echo 错误: 无效的操作 '%ACTION%'
    echo.
    echo 可用操作:
    echo   build    - 构建Docker镜像
    echo   start    - 启动服务 (默认)
    echo   stop     - 停止服务
    echo   restart  - 重启服务
    echo   logs     - 查看日志
    echo   clean    - 清理资源
    echo.
    echo 示例: deploy-docker.bat build
    exit /b 1
)

echo.
echo 操作完成！
pause 