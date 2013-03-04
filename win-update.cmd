@echo off
%systemroot%\system32\inetsrv\AppCmd.exe stop apppool /apppool.name:itrackgames

git pull

call bundle install

call rake db:migrate

%systemroot%\system32\inetsrv\AppCmd.exe start apppool /apppool.name:itrackgames

