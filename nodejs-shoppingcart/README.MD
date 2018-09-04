# Node.js app for using VS Code + WSL on Windows 10

This app is a simple shopping cart implemented using NodeJS, Express, Express-Session and Express handlebars (hbs). The project is originally from https://github.com/gtsopour/nodejs-shopping-cart and is licensed under **MIT**.

## Story
This demo will showcase how students can develop a Node.js app in VS Code by using the Windows Subsystem for Linux. They can run and debug the application with the Linux version of Node on a Windows device, which gives them a consistent experience between their local Windows device and the cloud (Azure) where the Node.js app will run inside a Linux container.

In addition, you can highlight the debugger and integrated terminal functionality in VS Code, where you can attach the built-in Node debugger to the process that allows you to debug the express app. See Debugging section for more for more

Lastly we also included a workspace recommendation that enables you to install the Azure App Service extension for VS Code that allows easy deployment to Azure (from within VS Code). See #Azure section for more details.

## Prerequisites
You can install the tools you'll need for this tutorial with one click by using the [Node.js tutorial setup script](http://boxstarter.org/package/url?https://raw.githubusercontent.com/Microsoft/Dev-Advocacy-Samples/master/nodejs_tutorial_setup.ps1) based on the [Windows Dev Box Setup Scripts](https://github.com/Microsoft/windows-dev-box-setup-scripts) project. 

After you run the script, restart your Ubuntu 18.04 app and install node by running the following:
```script
nvm install node
```

Verify you have successfully installed node:
```script
node --version
```

Alternatively, follow the steps below to install prerequisites.

1. Install Visual Studio Code for Windows using the installation instructions [here](https://code.visualstudio.com/Download). 
2. Make sure WSL is set up on your machine. You can follow the installation instructions [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).
3. You need to have installed Node and NVM. Follow the instructions [here]( https://gist.github.com/micahgodbolt/8b9a338c8bab7bc147975646ea20826c).

## Tutorial
1. Create a user called 'ubuntu' that you will use throughout this tutorial. In you Ubuntu 18.04 terminal type the following:
``` shell
sudo adduser ubuntu
```
Add 'ubuntu' to the sudo user group
``` shell
sudo adduser ubuntu sudo
su - ubuntu
```

Note that when you create the user you will be promted for a password. Go ahead and create one. You'll also be propted for a few other details. You can skip filling those in by pressing "Enter".

2. Go to `/nodejs-shoppingcart`

3. Install dependencies
``` shell
npm install
```

4. Open this folder in VS Code from your bash terminal
``` shell
code .
```

5. Open the Integrated Terminal in VS Code (make sure it's using bash/wsl). You can set your default shell by using the command palette (Ctrl + Shift + P) and typing "Terminal: Select Default Shell." From there select "WSL Bash." Now start the node server:
``` shell
npm start
```

6. Visit the app on `http://localhost:3000`.

## Debugging
To debug the Node app running within WSL, we have included a `launch.json` that contains a debug configuration that's launching the Node process for you. This means that you have to stop/kill the existing Node process that you may have started from the integrated terminal. The debug configuration works by running `npm run debug`, which is a predefine npm script in the `package.json` which starts the node process with the debug `--inspect` flag. Notice that the `useWSL` property is set too, and this tells VS Code to use WSL, so the launched Node process runs within WSL and not Windows.

To start debugging simply go to the Debug section and select the `Launch NPM debug` config, and you should see your Node process start. From here you can go to `routes/index.js` and set breakpoints in the event handler.


## Azure & Next Steps
We also included a workspace recommendation that enables you to install the [Azure App Service extension for VS Code](vscode:extension/ms-azuretools.vscode-azureappservice), that allows easy deployment to Azure (from within VS Code). 

See this in depth tutorial for how to get started with App Service and VS Code: https://code.visualstudio.com/tutorials/app-service-extension/getting-started
