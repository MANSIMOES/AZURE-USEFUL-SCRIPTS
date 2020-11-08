REM 1 # PART 1 

REM # 2 PART 2
@ECHO OFF
ECHO "HELLO"
@ECHO ON
: git ls-tree -r test01
: git push origin test01
: git commit -m "test02"
: git checkout test01  
: git status
: git merge DatBranch01
: git 
: git config --global user.name "MANS-admin"
: git remote add origin server
: git remote -v