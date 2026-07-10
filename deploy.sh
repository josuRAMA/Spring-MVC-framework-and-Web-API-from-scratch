#!/bin/bash
# Instruction
# Copy deploy.sh (and optionally create.sh) inside the project file
# If you copied create.sh too, execut it first or you can just create all files manually

#Initialization of variables, you can edit them if you want but make sure to keep the same structure for the project
APP_NAME="${PWD##*/}"                                                               #name of the project/principal directory, u can edit it if it doesn't macth what you want
SRC_DIR="test"                                                                      #all application files (.java)
WEB_DIR="web"                                                                       #all web files (jsp,xml,..)
FRAMEWORK_DIR="framework"                                                           #all framework files (servlet, filter, listener,..)
BUILD_DIR="build"                                                                   #temporary file
LIB_DIR="web/WEB-INF/lib"                                                           #CATALINA_HOME/lib
TOMCAT_WEBAPPS="/opt/tomcat11/webapps"                                              #CATALINA_HOME/webpps (Where we will deploy our project ;)
SERVLET_API_JAR="web/WEB-INF/lib/jakarta.servlet-api-6.0.0.jar"        
#SERVLET_API_JAR="$LIB_DIR/servlet-api.jar:$LIB_DIR/jsp-api.jar"                                           

# Directories for to put the compilated files (.class)
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/WEB-INF/classes

# Compilation of every source files(.java)        
find $FRAMEWORK_DIR -name "*.java" > framework.txt                                      #create a list of all framework .java files and copy the name inside framework.txt
javac -cp $SERVLET_API_JAR -d $FRAMEWORK_DIR/out @framework.txt                         #then compilate with required lib and place all executable inside /framework/out         
jar cf $BUILD_DIR/WEB-INF/lib/framework.jar -C $FRAMEWORK_DIR/out .                       #create a jar file of the framework and place it inside /WEB-INF/lib                        
find $SRC_DIR -name "*.java" > application.txt                                          #create a list of all application .java files and copy the name inside application.txt
javac -cp "$LIB_DIR/*" -d $BUILD_DIR/WEB-INF/classes @application.txt               #then compilate with required lib and place all executable inside /WEB-INF/classes

# Check if there is no compilation error before the deployement
if [ $? -ne 0 ]; then
    echo "////////////////////////////////////////"
    echo "****************************************"
    echo "COMPILATION ERROR, Project not deployed..."
    echo "****************************************"
    echo "////////////////////////////////////////"
    exit 1
fi

# Copy all web relatded files
cp -r $WEB_DIR/* $BUILD_DIR/

# Packaging the project into .war
cd $BUILD_DIR || exit
jar -cvf $APP_NAME.war *
cd ..

# Deploying the project to tomcat
cp -f $BUILD_DIR/$APP_NAME.war $TOMCAT_WEBAPPS/

#***************************************End of script*****************************
echo "////////////////////////////////////////"
echo "****************************************"
echo "Project deployed succesfully..."
echo "****************************************"
echo "////////////////////////////////////////"
