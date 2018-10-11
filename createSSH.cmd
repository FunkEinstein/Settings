@echo off

if not "%1"=="" (
	set email=%1
	goto call
)

set /p email=Write your email:

:call
echo ssh-keygen -t rsa -C "%email%"
bash -c 'ssh-keygen -t rsa -C "%email%"'

clip < %USERPROFILE%\.ssh\id_rsa.pub
start %USERPROFILE%\.ssh
pause