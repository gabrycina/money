import { NativeRouter, Route, Link, Routes } from "react-router-native";
import { Home } from "./src/pages/home";
import { Login } from "./src/pages/login";
import { Welcome } from "./src/pages/welcome";
import GlobalFont from 'react-native-global-font'
import { useEffect } from "react";

export default function App() {
  useEffect(() => {
   let fontName = 'Heavitas'
   GlobalFont.applyGlobal(fontName)
  }, [])

  return (
    <NativeRouter>
      <Routes>
        <Route path="/" element={<Welcome />} />
        <Route path="/login" element={<Login/>} />
        <Route path="/home" element={<Home />} />
      </Routes>
    </NativeRouter>
  );
}