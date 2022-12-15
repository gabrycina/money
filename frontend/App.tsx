import { NativeRouter, Route, Link, Routes } from "react-router-native";
import { Home } from "./src/pages/home";
import { Login } from "./src/pages/login";
import { Welcome } from "./src/pages/welcome";
import GlobalFont from 'react-native-global-font'
import { useEffect } from "react";
import { Provider } from "react-redux";
import store from "./src/redux/store";

export default function App() {
  useEffect(() => {
   let fontName = 'Heavitas'
   GlobalFont.applyGlobal(fontName)
  }, [])

  return (
    <Provider store={store}>
      <NativeRouter>
        <Routes>
          <Route path="/" element={<Welcome />} />
          <Route path="/login" element={<Login/>} />
          <Route path="/home" element={<Home />} />
        </Routes>
      </NativeRouter>
    </Provider>
  );
}