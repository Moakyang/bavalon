import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './components/App';
import registerServiceWorker from './registerServiceWorker';
import configureStore from './store'
import includes from 'lodash/includes'
window.includes = includes

const setupStore = () => {
  let store
  store = window.currentUser ?
            configureStore({ session: window.currentUser }) :
            configureStore()

  window.store = store
  return store
}


ReactDOM.render(<App store={setupStore()} />, document.getElementById('root'));
registerServiceWorker();
