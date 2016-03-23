import {app, BrowserWindow} from 'electron';

const menu = [{
  label: 'Development',
  submenu: [{
      label: 'Reload',
      accelerator: 'CmdOrCtrl+R',
      click: function () {
          BrowserWindow.getFocusedWindow().webContents.reloadIgnoringCache();
      }
  },{
      label: 'Toggle DevTools',
      accelerator: 'Alt+CmdOrCtrl+I',
      click: function () {
          BrowserWindow.getFocusedWindow().toggleDevTools();
      }
  },{
      label: 'Quit',
      accelerator: 'CmdOrCtrl+Q',
      click: function () {
          app.quit();
      }
  }]
}]

export default {
  menu: menu
}
