import { UserInfo } from "../models";
import { configureStore } from "@reduxjs/toolkit";
import { userReducer } from "./slices";

export interface AppStore {
  user: UserInfo;
}

export default configureStore<AppStore>({
  reducer: {
    user: userReducer,
  },
});
